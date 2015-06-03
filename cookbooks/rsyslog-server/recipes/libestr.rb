## libestr
remote_file "#{Chef::Config[:file_cache_path]}/#{node['libestr']['name']}" do
  source "#{node['dlserver']}/#{node['libestr']['name']}"
  not_if  { File.exists?("#{node['libestr']['checkfile']}") }
end

## configure && make && make install
bash 'make & install libestr' do
  cwd Chef::Config[:file_cache_path]
  code <<-EOF
  tar zxf #{node['libestr']['name']}
  cd #{node['libestr']['dir']}
  ./configure && make && make install
  EOF
  not_if  { File.exists?("#{node['libestr']['checkfile']}") }
end
