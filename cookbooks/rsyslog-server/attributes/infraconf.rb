## init
default['rsyslog_infra']['facility'] = 'local1'
default['rsyslog_infra']['virtual_host'] = '/'
default['rsyslog_infra']['host'] = '127.0.0.1'
default['rsyslog_infra']['user'] = 'admin'
default['rsyslog_infra']['password'] = 'guest'
default['rsyslog_infra']['template'] = 'RSYSLOG_FileFormat'
default['rsyslog_infra']['routing_key'] = 'infra'
default['rsyslog_infra']['timeoutenqueue'] = '0'
default['rsyslog_infra']['highwatermark'] = '12000000'
default['rsyslog_infra']['lowwatermark'] = '400000'
default['rsyslog_infra']['discardmark'] = '16000000'
default['rsyslog_infra']['maxdiskspace'] = '5g'
default['rsyslog_infra']['queuesize'] = '20000000'
default['rsyslog_infra']['saveonshutdown'] = 'on'
default['rsyslog_infra']['resumeretrycount'] = '-1'
