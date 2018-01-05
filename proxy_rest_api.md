
Peer RESTful API
----------------

### GET /api/v1/status/peer?channel={channel name}
loopchain의 현재 상태를 가져옴(block height, total tx등)
#### Response Body
```json
{
    "status": "Service is online: 1",
    "audience_count": 0,
    "consensus": "siever",
    "peer_id": "ac997810-240b-11e7-b072-a45e60c5e043",
    "peer_type": "1"
}
```

### GET /api/v1/status/score?channel={channel name} 
loopchain의 SCORE 상태를 가져옴 (Score version , 배포된 버젼, 스코어 아이디)
#### Response Body
```json
{
    "id": "score/certificate",
    "status": 0,
    "version": "5b95c851bb90219cacce8444b4667eed4af73935",
    "all_version": [
        "5b95c851bb90219cacce8444b4667eed4af73935",
        "b40e09a84e2f25d91b10b7b8c89a3f3fbd9309a4",
        "67398e1c42929f85002dda25949743c8408a2556",
        "61819fefe9a403562815e94e889af6a74fc53715",
        "da54c689fb538342ae3190586af2e2cf2311ce96",
        "1b13778e65831f90761670bc9139fe5e13162db0",
        "29682ba50a586e534d52d647fb65f1a749d59036",
        "a222b096ef4a5c6f90c77736ac3914c39f55f2c5",
        "9c529558b9636e1d1aca6b2a8807f0ba3df474bf",
        "0c601c48e034dffa5b3a3f4336e15f285a45f3a9",
        "3447ef8db315a4addd499b620562576e10b3907d",
        "82f4f85786ef73e0d020244c1697c6918fca20ec",
        "81e7c40f5aab0546be6bb1398e8016f5a7e1a120",
        "a41b3e0dcaeca653e26f11b4c75e5c15766f761e",
        "5ead8aba390687a2b0768f60711a170c998e40aa",
        "d3924a4336fb7a2ed1d86f22d57c488b4be8432f",
        "d7d02cf9825ad879eb0e79f6f6ac1b81738e52aa",
        "7d590db788c0a81a7caeb938b8204a737d63dd71",
        "a62cf913ffdc8b497b1f6ecfd6d0d731d02506db",
        "5edd70fda15601035254c62157a6717b950e16ae",
        "084dc91f607ffe5a8d6cfa5f366a3706e8cd6b2b",
        "5bc674d2e5508165592f93a56bb24d7c46a679fc",
        "4701abc7c666f59559fea3d818687649f30708e7"
    ]
}
```



### POST /api/v1/query 
스코어가 실행된 결과 조회 
#### Request BODY
* Content-Type : application/json
* Request-body : Raw 데이터로써, JSON형태의 데이터
   * jsonrpc : 반드시 2.0으로 설정 
   * method  : SCORE안에 호출할 Function 이름 
   * params  : JSON으로 구성된 SCORE안에 호출할 Function의 parameters.

Ex)
```json
POST /api/v1/query
{
    "jsonrpc": "2.0",
    "channel": "channel_name",
    "method": "get_name",
    "id": "test_query",
    "params": {
        "id": "1",
    }
}
```



#### Response Body
* Content-Type : application/json
* response_code :
* Request-body : Raw 데이터로써, JSON형태의 데이터
   * jsonrpc : 반드시 2.0으로 설정.
   * code    : SCORE안에서 실행한 결과. 
   * resoponse : 결과로 넘어오는 JSON body


Ex)
```json
{
    "response_code": "int : RES_CODE",
    "response": {
        "jsonrpc": "2.0",
        "code": 0,
        "response": {
            "name": "godong"
        },
        "id": "test_query"
    }
}
```


### GET /api/v1/transactions?hash={찾으려는 트랜잭션 해시}&channel={channel_name}
트랜잭션 해시로 블록체인에 저장된 데이터를 가져옴

#### Response Body
```json
{
   "response_code" : "int : RES_CODE",
   "data" : "트랜잭션 생성 시 보낸 데이터",
   "meta" : {
       "peer_id" : "트랜잭션을 생성한 피어 아이디",
       "score_id" : "실행한 SCORE id",
       "score_version" : "실행한 SCORE version"
   },
   "more_info" : "추가 정보"
}
```

### GET /api/v1/transactions/result?hash={찾으려는 트랜잭션 해시}&channel={channel_name}
Score 실행 결과를 Transaction Hash를 통해 가져옴

#### Response Body
```json
{
   "response_code" : "int : RES_CODE",
   "response" : {
       "code" : 0(성공), 2(아직 commit되지 않음), 9000 Exception
       "message" : "실패시 실패 메시지"
   }
}
```


###  /api/v1/transactions
트랜잭션을 생성하여 SCORE를 실행

#### Request BODY
* Content-Type : application/json
* Request-body : Raw 데이터로써, JSON형태의 데이터

```json
{
    "jsonrpc": "2.0",
    "channel": "channel_name",
    "method": "get_bid",   # SCORE안에 호출할 Function 이름 
    "id": "test_query",    # 비동기 응답시 이용할 예정. 현재는 사용 안함.
    "params": {            # JSON으로 구성된 SCORE안에 호출할 Function의 parameters.
        "name": "1",
        "identity": "2"
    }
}
```


#### Response Body

```
#### Response Body
```json
{
    "response_code" : "int : RES_CODE",
    "tx_hash" : "트랜잭션 해시",
    "more_info" : "추가 정보"
}
```

### GET /api/v1/blocks?channel={channel name}
마지막 블록의 hash 데이터를 가져온다.
#### Response Body
```json
{
    "response_code" : "int RES_CODE",
    "block_hash" : "block_hash",
    "block_data_json" : "block_data_json"
}
```
### GET  /api/v1/blocks?channel={channel name}&hash={찾으려는 블록 해시}
블록 해시에 알맞은 블록에서 헤더 데이터로 filter에 있는 데이터를 가져오고 txFilter에 있는 데이터를 트랜잭션 데이터에 추가하여 블록데이터를 가져온다 .

#### Response Body
```json
{
    "block_hash" : "블록 해시",
    "block_data_json" : {
        "prev_block_hash" : "이전블록 해시",
        "merkle_tree_root_hash" : "머클 루트",
        "time_stamp" : "블록 생성 시간",
        "height" : "블록 높이",
        "peer_id" : "블록 생성 피어 id"
    },
    "tx_data_json" : [
        {
            "tx_hash" : "트랜잭션 해시",
            "timestamp" : "트랜잭션 생성 시간",
            "data_string" : "트랜잭션에 들어간 데이터",
            "peer_id" : "트랜잭션을 생성한 피어"
        }
    ]
}
```