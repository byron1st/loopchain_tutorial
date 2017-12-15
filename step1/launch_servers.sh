#!/usr/bin/env bash

export TAG=latest


# Make log folder.
export LOG_FOLDER=$(pwd)/logs
mkdir ${LOG_FOLDER}


# log server 띄우기.
docker run -d \
--name loop-logger \
--publish 24224:24224/tcp \
--volume $(pwd)/fluentd:/fluentd \
--volume ${LOG_FOLDER}:/logs \
loopchain/loopchain-fluentd:${TAG}


# RadioStation에서 이용할 데이타 저장 공간을 만듭니다.
mkdir -p storageRS

# RadioStation을 실행합니다.
docker run -d --name radio_station \
-v $(pwd)/conf:/conf \
-v $(pwd)/storageRS:/.storage \
-p 7102:7102 \
-p 9002:9002 \
--log-driver fluentd --log-opt fluentd-address=localhost:24224 \
loopchain/looprs:${TAG} \
python3 radiostation.py -o /conf/rs_conf.json


# Peer 0번에서 이용할 데이타 저장 공간을 만듭니다.
mkdir -p storage0

# Peer 0번을 띄웁니다.
docker run -d --name peer0 \
-v $(pwd)/conf:/conf \
-v $(pwd)/storage0:/.storage \
--link radio_station:radio_station \
--log-driver fluentd --log-opt fluentd-address=localhost:24224 \
-p 7100:7100 -p 9000:9000  \
loopchain/looppeer:${TAG} \
python3 peer.py -o /conf/peer_conf.json  -r radio_station:7102
