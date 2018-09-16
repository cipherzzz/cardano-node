# Cardano Wallet/Node - Docker

This project will build a 1.3.x Cardano Node and Wallet running within a docker container on Ubuntu. This repo was forked from [here](https://github.com/TheDevKnight/cardano-sl-wallet) and thanks to @TheDevKnight for his help in getting me up and going. I also borrowed config content from [here](https://github.com/EmurgoVN/cardano_docker).

## Requirements
- Ubuntu - OSX did not work for me ;(
- Git
- Docker

## Options
You can build the image or use a prebuilt image. Both options are presented below, but you will need to create the data dir.

## Create Data Dir
```
$ mkdir cardano && cd cardano
$ mkdir data && chmod 777 data
```

***

## Building Image

```
$ git clone https://github.com/cipherzzz/cardano-node

$ cd cardano-node

# Build the image locally
$ docker build -t cardano-node .
```

###  Updating an Image
```
# Login to docker hub
$ docker login

# Tag the local build with a remote tag
$ docker tag cardano-node cipherz/cardano-node

# Push the new tag to the remote
$ docker push cipherz/cardano-node
```

***

## Using Existing Image

```
# Pull the remote built image
$ docker pull cipherz/cardano-node
```

***

## Run Built/Pulled Image
```
# Get image id below
$ docker images

# Create and run the container
$ docker run -d --name=cardano-node -v ~/cardano/data:/home/cardano/cardano-sl/state-wallet-mainnet:Z -p 127.0.0.1:8090:443 <image id>
```
***

## Verify

```
# Curl Wallet API 
$ curl -k 
https://127.0.0.1:8090/api/v1/node-info

# Verify wallet /data dir
$ ls ../data

# Peek at Node logs
$ docker logs -f cardano-node
```

***

## Maintenance

```
# Start/Stop Container
$ docker stop cardano-node
$ docker start cardano-node

# Remove Container
$ docker ps
$ docker container rm -f <container id>
```

***

## Creating a Wallet

Once you have verified the node is running, we need to create a wallet on it. Run the following command to create your wallet on your node and edit the parameters as you wish.

```
curl -k -X POST https://127.0.0.1:8090/api/v1/wallets \
  -d '{ "operation": "create", "backupPhrase": [<12 word mnemonic>], "assuranceLevel": "normal", "name": "Test Wallet" }' \
  -H "Accept: application/json; charset=utf-8" \
  -H "Content-Type: application/json; charset=utf-8"
```

Now that you have created a wallet, let's list the wallets for our node. Find and write down the `id` param for the wallet from this response.

```
curl -k https://127.0.0.1:8090/api/v1/wallets
```

Now we need to get the accountIndex for the wallet `id`. Execute the following curl with the substitution of the `id` param. You will find an array of accounts from the response below. Write down the `accountIndex` param.

```
curl -k https://localhost:8090/api/v1/wallets/<wallet id>/accounts
```

We have created a wallet and noted the wallet `id` and the default wallet `accountIndex`. We will need these in order to interact with our wallet to do things like generate an address and send a transaction.
