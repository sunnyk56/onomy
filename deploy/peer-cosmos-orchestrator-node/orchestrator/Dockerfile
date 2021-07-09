FROM leeway321/gravity-bridge-binary:latest as builder

EXPOSE 61278
ARG GRAVITY_HOST=${GRAVITY_HOST}
ARG ETH_HOST=${ETH_HOST}
ARG GIT_HUB_BRANCH=${GIT_HUB_BRANCH}

RUN git clone -b $GIT_HUB_BRANCH https://github.com/sunnyk56/gravity-bridge.git
RUN cp -r /root/gravity-bridge/deploy/master-cosmos-orchestrator-node/scripts scripts
RUN cp -r /root/gravity-bridge/master/assets assets
RUN cp -r /root/gravity-bridge/master/testchain testchain

RUN chmod -R +x /root/scripts
RUN chmod -R +x /root/assets
RUN chmod -R +x /root/testchain

CMD ["sh", "scripts/orchestrator-run.sh $GRAVITY_HOST  $ETH_HOST"]