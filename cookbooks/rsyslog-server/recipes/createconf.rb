## rsyslog.conf
template "/etc/rsyslog.conf" do
  source 'rsyslog.erb'
  owner "root"
  group "root"
  mode "0755"
end

## OS
template "/etc/rsyslog.d/os.conf" do
  source 'os.erb'
  owner "root"
  group "root"
  mode "0755"
end

## INFRA
template "/etc/rsyslog.d/infra.conf" do
  source 'infra.erb'
  owner "root"
  group "root"
  mode "0755"
end

## APP
template "/etc/rsyslog.d/app.conf" do
  source 'app.erb'
  owner "root"
  group "root"
  mode "0755"
end
