The gitAction present in ONET-42 is going to use this folder to deploy a network automatically. We are using a [pre-built image](https://hub.docker.com/r/leeway321/gravity-bridge-binary) that is having binary for all these nodes

# Test Network

This test network is having one validator, one orchestrator, and one ethereum node that are deployed in different containers in one machine.

## master-cosmos-validator-node

This is the main validator node it should be started first. To start master cosmos validator node these steps are followed:
- Build an image for master-cosmos-validator-node using Dockerfile present in cosmos folder and push it to Docker hub.
- Use this image to start a docker container.
- Now we start the Ethereum node in a separate container

## master-cosmos-eth-node
This is an Ethereum node it should be started after starting the validator node. To start the ethereum node these steps are followed:
- Build an image for master-cosmos-eth-node using Dockerfile present in the ethereum folder.
- Use this image to start a docker container.
- It uses the updated ETHgenesis.json file from the validator which has a public minter address and other information that are generated when add eth-key command ran.
- Now we deploy the smart contract.

## Deploy smart contract
Now we have to deploy the smart contract and save the returned contract-address to our GitHub repo. To deploy the smart contract these steps are followed:
- Start a docker build using the Dockerfile present in the deployContract folder, pass the build arguments regarding GRAVITY_HOST and ETH_HOST.
- It will save a contract-address in the GitHub repo in the config branch, which will be needed to start the orchestrator.

## master-cosmos-orch-node
Now we have to deploy the orchestrator node, these steps are followed:
- Build an image using the Dockerfile present in the orchestrator folder and push it to the docker hub.
- Use this image to start a container.

When all these steps are completed you are ready with a network that is having one validator, one orchestrator, and one ethereum node in separate containers.
