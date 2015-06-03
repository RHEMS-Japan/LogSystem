default['rhems_logsystem']['url'] = 'http://chef.rhems-japan.net:8080/src/'
default['rhems_logsystem']['path'] = '/usr/local/rhemslog/'
default['rhems_logsystem']['easy_install']['bin'] ='/usr/lib64/pypy-2.0.2/bin/easy_install'
default['rhems_logsystem']['pip']['bin'] ='/usr/lib64/pypy-2.0.2/bin/pip'

## appconf
default['rhems_logsystem']['app']['mqserver'] = '127.0.0.1'
default['rhems_logsystem']['app']['script_log'] = '/var/log/Split_App.log'
default['rhems_logsystem']['app']['logbase'] = '/var/log/servers'
default['rhems_logsystem']['app']['queuename'] ='app'

## infra
default['rhems_logsystem']['infra']['mqserver'] = '127.0.0.1'
default['rhems_logsystem']['infra']['script_log'] = '/var/log/Split_Infra.log'
default['rhems_logsystem']['infra']['logbase'] = '/var/log/servers'
default['rhems_logsystem']['infra']['queuename'] ='infra'
