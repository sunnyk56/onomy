FROM golang:alpine AS build-env

# Install minimum necessary dependencies,
ENV PACKAGES curl make git libc-dev bash gcc linux-headers eudev-dev python3
RUN apk add --no-cache $PACKAGES

# Set working directory for the build
ARG GRAVITY_DIR=/go/src/github.com/onomyprotocol/cosmos-gravity-bridge
RUN git clone https://github.com/onomyprotocol/cosmos-gravity-bridge.git $GRAVITY_DIR
# WORKDIR /go/src/github.com/althea-net/cosmos-gravity-bridge/module
WORKDIR $GRAVITY_DIR/module

# Add source files
# COPY . .

# install simapp, remove packages
RUN make install

# Final image
FROM alpine:edge

# Install ca-certificates
RUN apk add --no-cache ca-certificates yq bash \
    curl \
    build-base \
    tar \
    git
WORKDIR /root

# Copy over binaries from the build-env
COPY --from=build-env /go/bin/gravity /usr/bin/gravity
# FROM ubuntu:latest

# RUN apt-get update -y -q && apt-get upgrade -yq
# # common (DEBIAN_FRONTEND is a fix for tzdata)
# RUN DEBIAN_FRONTEND="noninteractive" apt-get install --no-install-recommends -yq software-properties-common \
#     curl \
#     build-essential \
#     ca-certificates \
#     tar \
#     git

# ARG GRAVITY_DIR=/go/src/github.com/onomyprotocol/cosmos-gravity-bridge
# RUN git clone https://github.com/onomyprotocol/cosmos-gravity-bridge.git $GRAVITY_DIR


# # ------------------ gravity module ------------------
# # install golang
# RUN curl https://dl.google.com/go/go1.16.4.linux-amd64.tar.gz --output go.tar.gz
# RUN tar -C /usr/local -xzf go.tar.gz
# ENV PATH="/usr/local/go/bin:$PATH"
# ENV GOPATH=/go
# ENV PATH=$PATH:$GOPATH/bin
# # build gravity artifact
# WORKDIR $GRAVITY_DIR/module
# # Build gravity artifact
# RUN make install
# # copy binary to bin
# RUN cp /go/bin/gravity /usr/bin/gravity

# ------------------ orchestrator ------------------
# install rust
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
# check cargo works
RUN cargo version
# build orchestrator artifact
WORKDIR $GRAVITY_DIR/orchestrator
RUN rustup target add x86_64-unknown-linux-musl
RUN apk add --no-cache yq musl
RUN ls
# RUN apt-get install --no-install-recommends -yq musl-tools
RUN cargo build --target=x86_64-unknown-linux-musl --release  --all
RUN cp $GRAVITY_DIR/orchestrator/target/x86_64-unknown-linux-musl/release/gbt /usr/bin/gbt

# ------------------ Solidity ------------------
RUN apk add --no-cache yq python3 \
    make \
    g++

RUN curl -sL https://deb.nodesource.com/setup_15.x  | bash -
RUN apk add --update nodejs nodejs-npm
# RUN apt-get -y install nodejs
# compile contract
WORKDIR $GRAVITY_DIR/solidity
RUN npm ci
RUN chmod -R +x scripts
RUN npm run typechain

# ------------------ ethereum go (geth) ------------------
# RUN add-apt-repository -y ppa:ethereum/ethereum
RUN apk add --no-cache yq geth
# ------------------ soft to run the scripts ------------------
RUN apk add --no-cache yq jq \
    moreutils

# go to root
WORKDIR /root
CMD ["bash"]
