## GET /root/rabbitmqadmin
template "/root/rabbitmqadmin" do
  source 'rabbitmqadmin.erb'
  owner "root"
  group "root"
  mode "0777"
end

bash 'rabbitmq setup' do
  cwd Chef::Config[:file_cache_path]
  code <<-EOF
    if [ ! -f /.run-rabbitmq-server-firstrun ]; then
        PASS="guest"
        cat >/etc/rabbitmq/rabbitmq.config <<-EOD
            [ {rabbit, [{default_user, <<"admin">>}, {default_pass, <<"$PASS">>}]} ].
        EOD
        echo "set default user = admin and default password = $PASS"
        # add the vhost
        (sleep 10 && rabbitmqctl add_vhost $DEVEL_VHOST_NAME && rabbitmqctl set_permissions -p $DEVEL_VHOST_NAME admin ".*" ".*" ".*") &
        touch /.run-rabbitmq-server-firstrun
    fi
    /root/rabbitmqadmin --username=admin --password=guest declare queue name=app durable=false
    /root/rabbitmqadmin --username=admin --password=guest declare queue name=infra durable=false
  EOF
end

service "rabbitmq-server" do
   provider Chef::Provider::Service::Systemd
   supports :status => true, :restart => true, :reload => true
   action [ :enable, :restart ]
end
