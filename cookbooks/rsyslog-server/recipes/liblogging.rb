## liblogging
remote_file "#{Chef::Config[:file_cache_path]}/#{node['liblogging']['name']}" do
  source "#{node['dlserver']}/#{node['liblogging']['name']}"
  not_if  { File.exists?("#{node['liblogging']['checkfile']}") }
end

## configure && make && make install
bash 'make & install liblogging' do
  cwd Chef::Config[:file_cache_path]
  code <<-EOF
  tar zxf #{node['liblogging']['name']}
  cd #{node['liblogging']['dir']}
  ./configure --disable-journal && make && make install
  EOF
  not_if  { File.exists?("#{node['liblogging']['checkfile']}") }
end
