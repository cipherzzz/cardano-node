#!/bin/bash
echo "Docker container ::: Starting node cardano-sl, wallet mode"

# remove default nginx config
sudo rm -f /etc/nginx/sites-enabled/default

# try to remove lock file from previous execution
sudo rm -f /home/cardano/cardano-sl/state-wallet-mainnet/wallet-db/open.lock

# restart nginx service in bg, give 10 sec that cardano node create ssl certif.
sleep 10 && sudo /usr/sbin/service nginx restart && echo "Docker container ::: Nginx service restarted" &

# start node
sudo /home/cardano/cardano-sl/connect-to-mainnet --runtime-args --no-tls