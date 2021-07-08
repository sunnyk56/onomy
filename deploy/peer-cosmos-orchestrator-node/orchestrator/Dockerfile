FROM leeway321/gravity-bridge-binary:latest as builder

EXPOSE 61278
ARG PUBLIC_IP=${PUBLIC_IP}
ARG GIT_HUB_USER=${GIT_HUB_USER}
ARG GIT_HUB_PASS=${GIT_HUB_PASS}
ARG GIT_HUB_EMAIL=${GIT_HUB_EMAIL}
ARG GIT_HUB_BRANCH=${GIT_HUB_BRANCH}

RUN git clone -b $GIT_HUB_BRANCH https://github.com/sunnyk56/gravity-bridge.git
RUN cp -r /root/gravity-bridge/deploy/master-cosmos-orchestrator-node/scripts scripts
RUN cp -r /root/gravity-bridge/master/assets assets
RUN cp -r /root/gravity-bridge/master/testchain testchain

RUN chmod -R +x /root/scripts
RUN chmod -R +x /root/assets
RUN chmod -R +x /root/testchain

CMD ["sh", "scripts/orchestrator-run.sh $PUBLIC_IP  $PUBLIC_IP"]