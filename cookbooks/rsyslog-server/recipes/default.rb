#
# Cookbook Name:: rsyslog-server
# Recipe:: default
#
# Copyright 2014, RHEMS Japan.CO,. Ltd.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

########## INSTALL RPM PACKAGES
## install devtools
execute "devtools" do
  user "root"
  command 'yum -y groupinstall "Development Tools"'
  action :run
end

## install dev Libraries
execute "devtools" do
  user "root"
  command 'yum -y groupinstall "Development Libraries"'
  action :run
end

## other packages
%w{
        make
        glibc-devel
        gcc
        uuid-devel
        uuid
        byacc
        json-c-devel
        libuuid-devel
        libgcrypt-devel
        gnutls
        gnutls-devel
        git 
        cmake 
        openssl-devel 
        mlocate 
        telnet
}.each do |package_name|
  package "#{package_name}" do
    action :install
  end
end

######## START RSYSLOG
## include
include_recipe "rsyslog-server::rabbitmqsetup"
include_recipe "rsyslog-server::libestr"
include_recipe "rsyslog-server::liblogging"
include_recipe "rsyslog-server::librelp"
include_recipe "rsyslog-server::librabbitmq"
include_recipe "rsyslog-server::rsyslog"
include_recipe "rsyslog-server::createconf"
case node[:platform_version]
when "7.1.1503"
    include_recipe "rsyslog-server::systemctl"
else
    include_recipe "rsyslog-server::initfile"
end
