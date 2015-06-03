## librabbitmq
remote_file "#{Chef::Config[:file_cache_path]}/#{node['librabbitmq']['name']}" do
  source "#{node['dlserver']}/#{node['librabbitmq']['name']}"
  not_if  { File.exists?("#{node['librabbitmq']['checkfile']}") }
end

## configure && make && make install
bash 'make & install librabbitmq' do
  cwd Chef::Config[:file_cache_path]
  code <<-EOF
  tar zxf #{node['librabbitmq']['name']}
  cd #{node['librabbitmq']['dir']}
  python setup.py build
  python setup.py install
  cd clib/
  ./configure && make && make install
  EOF
  not_if  { File.exists?("#{node['librabbitmq']['checkfile']}") }
end
