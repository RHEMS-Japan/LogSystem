## librelp
remote_file "#{Chef::Config[:file_cache_path]}/#{node['librelp']['name']}" do
  source "#{node['dlserver']}/#{node['librelp']['name']}"
  not_if  { File.exists?("#{node['librelp']['checkfile']}") }
end

## configure && make && make install
bash 'make & install librelp' do
  cwd Chef::Config[:file_cache_path]
  code <<-EOF
  tar zxf #{node['librelp']['name']} 
  cd #{node['librelp']['dir']} 
  export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/lib64/pkgconfig 
  ldconfig
  echo "========================================"
  pkg-config --list-all | grep gnutls
  echo "========================================"
  ./configure && make && make install
  EOF
  not_if  { File.exists?("#{node['librelp']['checkfile']}") }
end
