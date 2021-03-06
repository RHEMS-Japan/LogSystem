# backup rsyslog_init original
rsyslog_init = "/usr/lib/systemd/system/rsyslog.service"

bash 'copy_rsyslog_init_original' do
  code <<-EOC
    cp #{rsyslog_init} #{rsyslog_init}.org
  EOC
  creates "#{rsyslog_init}.org"
end

settings = {
        'exec=/usr/sbin/rsyslogd' => 'exec=/usr/local/rsyslog/sbin/rsyslogd'
}

settings.each do |k, v|
  bash "set_rsyslog_init_#{v.split(' ').first}" do
    code <<-EOC
      sed -i -e "s|^#{k}|#{v}|g" #{rsyslog_init}
    EOC
    not_if "cat #{rsyslog_init} | grep '^#{v}'"
  end
end

## restart rsyslog
service "rsyslog" do
   provider Chef::Provider::Service::Systemd
   supports :status => true, :restart => true, :reload => true
   action [ :enable, :restart ]
end
