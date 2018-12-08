# References:
#   https://www.elastic.co/guide/en/logstash/current/plugins-inputs-s3.html
#   https://www.elastic.co/blog/logstash-lines-inproved-resilience-in-S3-input
# 	https://www.elastic.co/guide/en/logstash/6.3/installing-logstash.html
# 	https://www.elastic.co/guide/en/logstash/current/working-with-plugins.html
# 	https://www.garron.me/en/bits/curl-delete-request.html

sudo yum update -y
sudo yum install -y java-1.8.0-openjdk
java -version
# Logstash requires Java 8
sudo rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

sudo vi /etc/yum.repos.d/logstash.repo

# Insert this below as the contents (omitting the leading "#" ):

# [logstash-6.x]
# name=Elastic repository for 6.x packages
# baseurl=https://artifacts.elastic.co/packages/6.x/yum
# gpgcheck=1
# gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
# enabled=1
# autorefresh=1
# type=rpm-md

# Now install Logstash
sudo yum install -y logstash

sudo systemctl start logstash

sudo systemctl stop logstash




# The S3 Logstash plugins should be present by default....otherwise you will need to install them
sudo yum install -y mlocate
sudo updatedb

cd /usr/share/logstash
bin/logstash-plugin list


# Config files are stored here: 
# /etc/logstash/conf.d/*.conf

cd /etc/logstash/conf.d/
sudo vi s3_input.conf

sudo systemctl start logstash


# Now look at the log file for logstash here:  tail -f /var/log/logstash/logstash-plain.log



