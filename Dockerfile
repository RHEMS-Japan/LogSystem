FROM           centos:centos6
MAINTAINER 	rayman <rayman@rhems-japan.co.jp>
# Container Build

## run base setup
RUN yum -y update; yum clean all
RUN yum -y install mlocate telnet tar net-tools rsyslog java libcurl-devel; yum clean all
RUN yum -y groupinstall "Development Tools"; yum clean all

## FOR rubbitmq
RUN yum -y install epel-release; yum clean all
RUN yum -y install pwgen wget logrotate rabbitmq-server; yum clean all

RUN /usr/lib/rabbitmq/bin/rabbitmq-plugins enable rabbitmq_management

## -------- FOR rubbitmq --------
#
# add run/set passwd script
#ADD run-rabbitmq-server.sh /run-rabbitmq-server.sh
#RUN chmod 750 ./run-rabbitmq-server.sh


# 
# expose some ports
#
# 5672 rabbitmq-server - amqp port
# 15672 rabbitmq-server - for management plugin
# 4369 epmd - for clustering
# 25672 rabbitmq-server - for clustering
# 514 syslog
EXPOSE 5672 15672 4369 25672 514 514/udp 8080

### CHEF
# install
RUN curl -L http://www.opscode.com/chef/install.sh | bash
ENV CHEF_REPO /root/chef-repo
WORKDIR /root/dockerbuild
ENV ENV local

## FOR SETUP
ADD cookbooks ${CHEF_REPO}/cookbooks
ADD chefconf.rb ${CHEF_REPO}/chefconf.rb
ADD setup.json ${CHEF_REPO}/setup.json
RUN cd ${CHEF_REPO} && chef-client -c chefconf.rb -j setup.json -z
#ADD run-setup.sh /run-setup.sh
#RUN chmod 750 /run-setup.sh
CMD ["/sbin/init"]
