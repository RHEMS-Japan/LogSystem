#
# Cookbook Name:: rhems-logsystem
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
%w{
       pypy 
}.each do |package_name|
  package "#{package_name}" do
    options '--enablerepo=epel'
    action :install
  end
end

###### RPM
%w{
        daemontools-0.76-RHEMS_Japan.x86_64.rpm
        ucspi-tcp-0.88-RHEMS_Japan.x86_64.rpm
}.each do |package_name|
        remote_file "/tmp/#{package_name}" do
             source "#{node['rhems_logsystem']['url']}/#{package_name}"
        end

        package "rpmforge" do
                action :install
                source "/tmp/#{package_name}"
                provider Chef::Provider::Package::Rpm
        end
end

## svscan
template "/etc/init/svscan.conf" do
    source "svscanboot.erb"
    owner "root"
    group "root"
    mode 0644
end

## GET FILE
remote_file "#{Chef::Config[:file_cache_path]}/ez_setup.py" do
  source "#{node['rhems_logsystem']['url']}ez_setup.py"
  not_if  { File.exists?("#{node['rhems_logsystem']['easy_install']['bin']}") }
end

## configure && make && make install
bash 'setup pypy' do
  cwd Chef::Config[:file_cache_path]
  code <<-EOF
	pypy ez_setup.py -U setuptools
	#{node['rhems_logsystem']['easy_install']['bin']} pip
	#{node['rhems_logsystem']['pip']['bin']} install pika
  EOF
  not_if  { File.exists?("#{node['rhems_logsystem']['easy_install']['bin']}") }
end

bash 'setup rhemslog' do
   code <<-EOF
	for _dir in bin conf supervise
	do
		mkdir -p #{node['rhems_logsystem']['path']}${_dir}
	done
   EOF
end

## GET FILE
remote_file "#{node['rhems_logsystem']['path']}bin/rhems-logsystem.py" do
  source "#{node['rhems_logsystem']['url']}rhems-logsystem.py"
  mode '0755'
  not_if  { File.exists?("#{node['rhems_logsystem']['path']}bin/rhems-logsystem.py") }
end

%w{
	app
	infra
}.each do |splitprog|
	link "#{node['rhems_logsystem']['path']}bin/#{splitprog}" do
		to "#{node['rhems_logsystem']['path']}bin/rhems-logsystem.py"
		link_type :hard
	end

	## create rabbitmq queues
	bash 'make rabbitmq queue and supervise' do
		code <<-EOF
			rabbitmqadmin declare queue name=#{splitprog}
			mkdir -p #{node['rhems_logsystem']['path']}supervise/#{splitprog}/log/main
		EOF
	end

	#supervise/<app>/log/run
	template "#{node['rhems_logsystem']['path']}supervise/#{splitprog}/log/run" do
		source "run_log.erb"
		owner "root"
		group "root"
		mode "0755"
	end

	#supervise/<app>/run
	template "#{node['rhems_logsystem']['path']}supervise/#{splitprog}/run" do
		source "#{splitprog}_run.erb"
		owner "root"
		group "root"
		mode "0755"
	end

	## make conf app.conf.erb  infra.conf.erg
	template "#{node['rhems_logsystem']['path']}conf/#{splitprog}.conf" do
		source "#{splitprog}.conf.erb"
		owner "root"
		group "root"
		mode "0755"
        only_if { File.exists?("#{node['rhems_logsystem']['path']}conf/#{splitprog}.conf") }
        action :nothing
	end
	
	## start prog
	link "/service/#{splitprog}" do
		to "#{node['rhems_logsystem']['path']}supervise/#{splitprog}"
	end
end

