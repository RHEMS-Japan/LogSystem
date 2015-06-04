## GET /root/rabbitmqadmin
template "/root/rabbitmqadmin" do
  source 'rabbitmqadmin.erb'
  owner "root"
  group "root"
  mode "0777"
end

bash 'rabbitmq set pass' do
  code <<-EOF
    PASS="guest"
    cat >/etc/rabbitmq/rabbitmq.config <<EOD
[
        {rabbit, [{default_user, <<"admin">>}, {default_pass, <<"$PASS">>}]}
].
EOD
    echo "set default user = admin and default password = $PASS"
EOF
end

case node[:platform_version]
when "7.1.1503"
   service "rabbitmq-server" do
      provider Chef::Provider::Service::Systemd
      supports :status => true, :restart => true, :reload => true
      action [ :enable, :restart ]
   end
else
   service "rabbitmq-server" do
      supports :status => true, :restart => true, :reload => true
      action [ :enable, :restart ]
   end
end

bash 'rabbitmq setup' do
  code <<-EOF
    (sleep 10 && rabbitmqctl add_vhost develop && rabbitmqctl set_permissions -p develop admin ".*" ".*" ".*")
    touch /.run-rabbitmq-server-firstrun
  EOF
end
