Local computer에서 RadioStation과 1개의 Peer로 한 장비 위에서 Blockchain network 구성하기
==================



## 목적

RadioStation과 Peer 1개로 구성된 네트워크를 올리는 테스트입니다. 

9002, 9000은 Restful로 연결할 수 있는 Interface를 만들기 위해 열리는 Port입니다.



## Prerequisite

- Docker >= 1.7



## Project Structure

```
├── README.md
├── conf
│   ├── channel_manage_data.json
│   ├── peer_conf.json
│   └── rs_conf.json
├── fluentd
│   └── etc
│       └── fluent.conf
└── launch_servers.sh
```



## Docker Image 받기

```
$ docker pull loopchain/looprs:latest             # radio station
$ docker pull loopchain/looppeer:latest.          # peer
$ docker pull loopchain/loopchain-fluentd:latest  # log server
```



## Docker Image확인 하기

```
$ docker images
REPOSITORY                    TAG                 IMAGE ID            CREATED             SIZE
loopchain/looppeer            latest              8968af8c1721        2 days ago          783MB
loopchain/looprs              latest              f8bf3265a09b        2 days ago          783MB
loopchain/loopchain-fluentd   latest              95900cef2721        2 days ago          39.5MB
```



## Docker container 올리기

```
$ ./launch_servers.sh
af1e36a376d4f3a5d0d78e20dbd414c4f4d4f7008337298bfa5991dba65a1bd8
7b963a9437e34b3791fe1cc04d05d2dcbcae305b9ca262cabd960051755a5c47
a532bedf104b683965c613f2f6d68119fd2073d698180a0248908dbaafdb507e
```



## 확인하기

Radio station에게 channel1에 접속된 Peer들의 정보를 출력해 봅니다.

실행 후 peer가 channel1에 접속하는데 몇 분이상 시간이 소요될 수 있습니다.

```json
$ curl http://localhost:9002/api/v1/peer/list?channel=channel1
{"response_code": 0, "data": {"registered_peer_count": 1, "connected_peer_count": 1, "registered_peer_list": [{"order": 1, "peer_id": "cfe71fb6-e139-11e7-b48f-0242ac110004", "group_id": "cfe71fb6-e139-11e7-b48f-0242ac110004", "target": "172.17.0.4:7100", "cert": "MFYwEAYHKoZIzj0CAQYFK4EEAAoDQgAE+HQPBowjyJnyinsYjiztl5i6hQ1JiWdpRmyFR1T283M4liQia7weerQQ4Qw6jDVwd+RkwHeenvR0xxovUFCTQg==", "status_update_time": "2017-12-15 01:47:13.147460", "status": 1, "peer_type": 1}], "connected_peer_list": [{"order": 1, "peer_id": "cfe71fb6-e139-11e7-b48f-0242ac110004", "group_id": "cfe71fb6-e139-11e7-b48f-0242ac110004", "target": "172.17.0.4:7100", "cert": "MFYwEAYHKoZIzj0CAQYFK4EEAAoDQgAE+HQPBowjyJnyinsYjiztl5i6hQ1JiWdpRmyFR1T283M4liQia7weerQQ4Qw6jDVwd+RkwHeenvR0xxovUFCTQg==", "status_update_time": "2017-12-15 01:47:13.147460", "status": 1, "peer_type": 1}]}}
```


