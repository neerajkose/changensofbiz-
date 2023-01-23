FROM ubuntu:18.04
RUN echo "$Username" > arg.txt
RUN echo "$Passwd" >> arg.txt
RUN apt-get update
RUN apt-get  install -y openjdk-8-jdk
RUN apt-get install -y apache2 
RUN apt-get install mysql-server -y
RUN apt-get install git -y
RUN git clone https://gitbox.apache.org/repos/asf/ofbiz-framework.git /oms
RUN mkdir -p /var/www/html/htdocs
RUN echo "test" /var/www/html/htdocs/test
RUN sed -i -e '361 s/127.0.0.1/localhost/'g -e '361 s/ofbiz/ofbiztest/'g /oms/framework/entity/config/entityengine.xml
RUN sed -i -e '395 s/127.0.0.1/localhost/'g -e '395 s/ofbiz/ofbizolap/'g /oms/framework/entity/config/entityengine.xml
RUN sed -i -e '429 s/127.0.0.1/localhost/'g -e '429 s/ofbiz/ofbiztenant/'g /oms/framework/entity/config/entityengine.xml
RUN sed -i -e '458 s/127.0.0.1/localhost/'g -e '458 s/ofbiz/ofbiz_odbc/'g /oms/framework/entity/config/entityengine.xml
ENV TZ=EST 
RUN echo $TZ=/etc/timezone
RUN adduser test-user
RUN echo test:123456 | chpasswd
ENTRYPOINT tail -f /arg.txt
