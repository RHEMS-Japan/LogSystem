## base
default['dlserver'] = 'http://chef.rhems-japan.net:8080/src/'

## libestr
default['libestr']['name'] = 'libestr-0.1.9.tar.gz'
default['libestr']['dir'] = 'libestr-0.1.9'
default['libestr']['checkfile'] = '/usr/local/include/libestr.h'

## liblogging
default['liblogging']['name'] = 'liblogging-1.0.4.tar.gz'
default['liblogging']['dir'] = 'liblogging-1.0.4'
default['liblogging']['checkfile'] = '/usr/local/include/liblogging/stdlog.h'

## librelp
default['librelp']['name'] = 'librelp-1.2.7.tar.gz'
default['librelp']['dir'] = 'librelp-1.2.7'
default['librelp']['checkfile'] = '/usr/local/include/librelp.h'

## librabbitmq
default['librabbitmq']['name'] = 'librabbitmq-1.5.2.tar.gz'
default['librabbitmq']['dir'] = 'librabbitmq-1.5.2'
default['librabbitmq']['checkfile'] = '/usr/local/bin/amqp-get'

## rsyslog
default['rsyslog']['name'] = 'rsyslog-8.2.2.tar.gz'
default['rsyslog']['dir'] = 'rsyslog-8.2.2'
default['rsyslog']['prefix'] = '/usr/local/rsyslog-8.2.2'
default['rsyslog']['checkfile'] = '/usr/local/rsyslog-8.2.2/sbin/rsyslogd'

## include
include_attribute 'rsyslog-server::infraconf'
include_attribute 'rsyslog-server::appconf'
include_attribute 'rsyslog-server::rsyslogconf'
