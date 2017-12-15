Local computer에서 RadioStation과 2개의 Peer로 한 장비 위에서 Blockchain network 구성하기
==================



## 목적

이번 과정은 RadioStation과 Peer 2개로 구성된 네트워크를 올리는 것 입니다. 9002, 9000, 9100은 Restful로 연결할 수 있는 Interface를 만들기 위해 열리는 Port입니다.



## Prerequisite

- Docker >= 1.7



## Project Structure

```
├── README.md
├── conf
│   ├── channel_manage_data.json
│   ├── peer_conf0.json
│   ├── peer_conf1.json
│   └── rs_conf.json
├── fluentd
│   └── etc
│       └── fluent.conf
├── launch_servers.sh
└── stop_servers.sh
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
8fcc955e648740f96fc78eb80ce0af3f5c9b55d8e70df7875c8ed7362fce81bd
e2d3c8fd02f5fbe1e945f29bab55820137715aa0ea74a288fc610df16ee753e2
76c6b70b29802a87b63bd741001aca960fe7d7d2fa865811530a1b57a6fede27
6cc2f85adadd95c0331f6876c0c6e9f4446f49c2a83fa1a22b6cbdd2e8f1c8d3
```



## 확인하기

Radio station에게 channel1에 접속된 Peer들의 정보를 출력해 봅니다.

실행 후 peer가 channel1에 접속하는데 몇 분이상 시간이 소요될 수 있습니다.

```json
$ curl http://localhost:9002/api/v1/peer/list?channel=channel1
{"response_code": 0, "data": {"registered_peer_count": 2, "connected_peer_count": 2, "registered_peer_list": [{"order": 1, "peer_id": "35eae1bc-e130-11e7-97d3-0242ac110004", "group_id": "35eae1bc-e130-11e7-97d3-0242ac110004", "target": "172.17.0.4:7100", "cert": "MFYwEAYHKoZIzj0CAQYFK4EEAAoDQgAE+HQPBowjyJnyinsYjiztl5i6hQ1JiWdpRmyFR1T283M4liQia7weerQQ4Qw6jDVwd+RkwHeenvR0xxovUFCTQg==", "status_update_time": "2017-12-15 00:39:24.403738", "status": 1, "peer_type": 1}, {"order": 2, "peer_id": "590118e2-e130-11e7-9845-0242ac110005", "group_id": "590118e2-e130-11e7-9845-0242ac110005", "target": "172.17.0.5:7200", "cert": "MFYwEAYHKoZIzj0CAQYFK4EEAAoDQgAE+HQPBowjyJnyinsYjiztl5i6hQ1JiWdpRmyFR1T283M4liQia7weerQQ4Qw6jDVwd+RkwHeenvR0xxovUFCTQg==", "status_update_time": "2017-12-15 00:39:24.880252", "status": 1, "peer_type": 0}], "connected_peer_list": [{"order": 1, "peer_id": "35eae1bc-e130-11e7-97d3-0242ac110004", "group_id": "35eae1bc-e130-11e7-97d3-0242ac110004", "target": "172.17.0.4:7100", "cert": "MFYwEAYHKoZIzj0CAQYFK4EEAAoDQgAE+HQPBowjyJnyinsYjiztl5i6hQ1JiWdpRmyFR1T283M4liQia7weerQQ4Qw6jDVwd+RkwHeenvR0xxovUFCTQg==", "status_update_time": "2017-12-15 00:39:24.403738", "status": 1, "peer_type": 1}, {"order": 2, "peer_id": "590118e2-e130-11e7-9845-0242ac110005", "group_id": "590118e2-e130-11e7-9845-0242ac110005", "target": "172.17.0.5:7200", "cert": "MFYwEAYHKoZIzj0CAQYFK4EEAAoDQgAE+HQPBowjyJnyinsYjiztl5i6hQ1JiWdpRmyFR1T283M4liQia7weerQQ4Qw6jDVwd+RkwHeenvR0xxovUFCTQg==", "status_update_time": "2017-12-15 00:39:24.880252", "status": 1, "peer_type": 0}]}}

```



## Docker Container 종료하기

```
$ ./stop_server.sh
```



