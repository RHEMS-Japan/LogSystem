# backup rsyslog_init original
rsyslog_init = "/etc/init.d/rsyslog"

bash 'copy_rsyslog_init_original' do
  code <<-EOC
    cp #{rsyslog_init} #{rsyslog_init}.org
  EOC
  creates "#{rsyslog_init}.org"
end

settings = {
        'exec=/sbin/rsyslogd' => 'exec=/usr/local/rsyslog/sbin/rsyslogd'
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
   action [ :enable, :restart ]
end
