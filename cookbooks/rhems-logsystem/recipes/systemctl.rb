template "/etc/systemd/system/daemontools.service" do
    source "daemontools.service.erb"
    owner "root"
    group "root"
    mode 0644
end
