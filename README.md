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