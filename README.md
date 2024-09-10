# Vxnaid Biometric Server

This package is used to setup the Biometric Server

1. Pre-requisites
--------------
1.1. Licenses
1. Iris matcher license for matching the iris templates of the participants
2. Server license

The above 2 licenses needs to be copied to biometric/config/Licenses directory.

1.2. Biometric server setup files and libraries

The files required to setup the server (Neurotechnology licensed SDK) were downloaded from [Neurotechnology website](https://www.neurotechnology.com/download.html).
The attached biometric/neurotech_iris.tar.gz is a slimmed-down SDK.

1.3. License config file (biometric/config/pgd.conf)
License files details needs to be updated here

1.4. Biometric server config file (biometric/config/NServer.conf)
Biometric server config details which contains ports and queries to insert/match templates

1.5. MySQL ODBC driver files (mysql/drivers)
This is used to setup MYSQL ODBC drivers in the docker container

1.6. Install mysql template for ODBC connectivity (mysql/mysql_template)
This file is required for ODBC connectivity

2. Installation
---------------
docker-compose -f docker-compose.yml up --build -d

3. Check logs
-------------
Verify the logs

docker logs -f --tail=100 vmp_iris_server_iris_1

## FAQ

1. There is "None of the compatible products are activated" log and server doesn't work.
* Check if you added license files and configured them in pgd.conf file.
* Check if license are correct MegaMatcher and IrisMatcher products.
* If you moved licenses from other running server (including different docker container) and these
 licenses are internet licenses the you need to wait around 30min for them to be released from the old server.
