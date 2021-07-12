#!/bin/bash
set -eu

echo "running gravity cosmos node"

# Initial dir
CURRENT_WORKING_DIR="/root"
# Name of the network to bootstrap
CHAINID="testchain"
# Name of the gravity artifact
GRAVITY=gravity
# The name of the gravity node
GRAVITY_NODE_NAME="gravity"
# The address to run gravity node
GRAVITY_HOST="0.0.0.0"
# Home folder for gravity config
GRAVITY_HOME="$CURRENT_WORKING_DIR/$CHAINID/$GRAVITY_NODE_NAME"
# Home flag for home folder
GRAVITY_HOME_FLAG="--home $GRAVITY_HOME"
# Prefix of cosmos addresses
GRAVITY_ADDRESS_PREFIX=cosmos
# Gravity chain demons
STAKE_DENOM="stake"

ETH_MINER_PUBLIC_KEY="0xBf660843528035a5A4921534E156a27e64B231fE"
# The host of ethereum node
ETH_HOST="0.0.0.0"

# ------------------ Run gravity ------------------

echo "Starting $GRAVITY_NODE_NAME"
$GRAVITY $GRAVITY_HOME_FLAG start --pruning=nothing &>/dev/null
sleep 10