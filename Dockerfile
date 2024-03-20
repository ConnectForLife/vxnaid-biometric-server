FROM ubuntu:20.04

RUN apt-get update && apt-get install -y curl
RUN curl -sSL https://packages.microsoft.com/config/ubuntu/20.04/prod.list | tee /etc/apt/sources.list.d/microsoft-prod.list
RUN curl -sSL https://packages.microsoft.com/keys/microsoft.asc | tee /etc/apt/trusted.gpg.d/microsoft.asc
RUN apt-get update && apt-get install -y unixodbc

WORKDIR /home/vxnaid

ARG DB_HOST
ARG DB_USER
ARG DB_PASSWORD
ARG DB_PORT
ARG DB_NAME

# Copy over the drivers
# MySQL ODBC Unicode
COPY mysql/drivers/mysql-connector-odbc-8.0.25-linux-glibc2.12-x86-64bit.tar.gz .
COPY biometric/neurotech_iris.tar.gz .
RUN tar xC /opt -f neurotech_iris.tar.gz
COPY biometric/config/pgd.conf /opt/Neurotec_Biometric/Bin/Linux_x86_64/Activation/
COPY biometric/config/NServer.conf /opt/Neurotec_Biometric/Bin/Linux_x86_64/NServer/
COPY biometric/config/Licenses/*.lic /opt/Neurotec_Biometric/Bin/Licenses/
COPY biometric/startServer.sh /opt/startServer.sh

# MySQL ODBC Unicode driver
RUN tar xvzf mysql-connector-odbc-8.0.25-linux-glibc2.12-x86-64bit.tar.gz \
  && ./mysql-connector-odbc-8.0.25-linux-glibc2.12-x86-64bit/bin/myodbc-installer -d -a -n "MySQL" \
  -t "DRIVER=/home/vxnaid/mysql-connector-odbc-8.0.25-linux-glibc2.12-x86-64bit/lib/libmyodbc8w.so"

# Install MYSQL template
COPY mysql/mysql_template .
RUN sed -i -r "s/DB_HOST/${DB_HOST}/g" mysql_template
RUN sed -i -r "s/DB_USER/$DB_USER/g" mysql_template
RUN sed -i -r "s/DB_PASSWORD/$DB_PASSWORD/g" mysql_template
RUN sed -i -r "s/DB_PORT/$DB_PORT/g" mysql_template
RUN sed -i -r "s/DB_NAME/$DB_NAME/g" mysql_template
RUN odbcinst -i -s -f mysql_template

RUN chmod +x /opt/startServer.sh
ENTRYPOINT ["/opt/startServer.sh"]
