## rsyslog
remote_file "#{Chef::Config[:file_cache_path]}/#{node['rsyslog']['name']}" do
  source "#{node['dlserver']}/#{node['rsyslog']['name']}"
  not_if  { File.exists?("#{node['rsyslog']['checkfile']}") }
end

## configure && make && make install
bash 'make & install rsyslog' do
  cwd Chef::Config[:file_cache_path]
  code <<-EOF
  tar zxf #{node['rsyslog']['name']}
  cd #{node['rsyslog']['dir']}
  PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/lib64/pkgconfig::/lib64/pkgconfig \
  ./configure --prefix=#{node['rsyslog']['prefix']} \
  --enable-zlib \
  --enable-kmsg \
  --enable-debug \
  --enable-libgcrypt \
  --enable-relp \
  --enable-imptcp \
  --enable-omrabbitmq --enable-imfile
  make && make install
  EOF
  not_if  { File.exists?("#{node['rsyslog']['checkfile']}") }
end

link "/usr/local/rsyslog" do
  to "#{node['rsyslog']['prefix']}"
  link_type :symbolic
  action :create
end
