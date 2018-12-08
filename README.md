# Install Logstash S3 input plugin on AWS
Use this to Install the Logstash S3 input plugin on and AWS EC2 Instance



### YouTube tutorial:

![youTube][thumb.png]




## Sample Logstash configuration for creating a simple
  AWS S3 -> Logstash -> Elasticsearch pipeline.
### References:
* https://www.elastic.co/guide/en/logstash/current/plugins-inputs-s3.html
* https://www.elastic.co/blog/logstash-lines-inproved-resilience-in-S3-input
* https://www.elastic.co/guide/en/logstash/current/working-with-plugins.html


## CloudCraft Diagram: 


![youTube][thumb.png]





*Installation Script*

```

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

```


*logstash.conf:*

```
# Sample Logstash configuration for creating a simple
# AWS S3 -> Logstash -> Elasticsearch pipeline.
# References:
#   https://www.elastic.co/guide/en/logstash/current/plugins-inputs-s3.html
#   https://www.elastic.co/blog/logstash-lines-inproved-resilience-in-S3-input
#   https://www.elastic.co/guide/en/logstash/current/working-with-plugins.html

input {
  s3 {
    #"access_key_id" => "your_access_key_id"
    #"secret_access_key" => "your_secret_access_key"
    "region" => "us-west-2"
    "bucket" => "testlogstashbucket1"
    "prefix" => "Logs"
    "interval" => "10"
    "additional_settings" => {
      "force_path_style" => true
      "follow_redirects" => false
                }
  }
}
 
output {
  elasticsearch {
    hosts => ["http://vpc-test-3ozy7xpvkyg2tun5noua5v2cge.us-west-2.es.amazonaws.com:80"]
    index => "logs-%{+YYYY.MM.dd}"
    #user => "elastic"
    #password => "changeme"
  }
}


```