#!/bin/bash
echo "Docker container ::: Starting node cardano-sl, wallet mode"

#try to remove lock file from previous execution
rm -f /home/cardano/cardano-sl/state-wallet-mainnet/wallet-db/open.lock

# restart nginx service in bg, give 10 sec that cardano node create ssl certif.
sleep 10 && sudo /usr/sbin/service nginx restart && echo "Docker container ::: Nginx service restarted" &
/home/cardano/cardano-sl/connect-to-mainnet
