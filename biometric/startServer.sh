#!/bin/sh
export SDK_HOME=/opt/Neurotec_Biometric
export LD_LIBRARY_PATH=$SDK_HOME/Lib/Linux_x86_64
export NSERVER_HOME=$SDK_HOME/Bin/Linux_x86_64/NServer
export NSERVER_ADMIN_PORT=24932
export NSERVER_CLIENT_PORT=25452
export NSERVER_HOST_URL=localhost

bash $SDK_HOME/Bin/Linux_x86_64/Activation/run_pgd.sh start &
sleep 5s
#Start the NServer
bash $NSERVER_HOME/run_NServer.sh 

