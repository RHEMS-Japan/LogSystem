## GET /root/rabbitmqadmin
template "/root/rabbitmqadmin" do
  source 'rabbitmqadmin.erb'
  owner "root"
  group "root"
  mode "0777"
end

service "rabbitmq-server" do
   provider Chef::Provider::Service::Systemd
   supports :status => true, :restart => true, :reload => true
   action [ :enable, :restart ]
end

bash 'rabbitmq setup' do
  cwd Chef::Config[:file_cache_path]
  code <<-EOF
    PASS="guest"
    echo "set default user = admin and default password = $PASS"
    (sleep 10 && rabbitmqctl add_vhost develop && rabbitmqctl set_permissions -p develop admin ".*" ".*" ".*")
    touch /.run-rabbitmq-server-firstrun
    /root/rabbitmqadmin --username=admin --password=guest declare queue name=app durable=false
    /root/rabbitmqadmin --username=admin --password=guest declare queue name=infra durable=false
  EOF
end
