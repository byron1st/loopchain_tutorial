### GET /api/v1/peer/list?channel={channel_name}
Radio Station에 등록/연결 된 Peer 정보를 가져옴
#### Response Body
```json
{
    "registered_peer_count": "int: 등록된 Peer의 수",
    "connected_peer_count": "int: 연결된 Peer의 수",
    "registered_peer_list": "등록된 Peer의 정보 목록"
    [
        {
            "order": "Radio Station에 등록된 Peer에 할당된 고유 순번",
            "peer_id": "Peer ID",
            "group_id": "Peer group의 ID",
            "target": "Peer의 IP: Port'로 이루어진 문자열",
            "auth": "Peer의 public key 정보(인증서)",
            "token": "Radio station이 Peer에게 발급한 토큰",
            "status_update_time": "Peer의 연결 상태 정보가 업데이트 된 시간",
            "status": "int: Radio station과 Peer의 연결 상태. (unknown:0, connected:1, disconnected:2)",
            "peer_type": "gRPC proto에 정의된 peer 타입의 문자값 (peer:"0", leader:"1")"
        },
        {
            "..."
        }      
    ],
    "connected_peer_list": "연결된 Peer의 정보 목록"
    [
        {
            "order": "Radio Station에 등록된 Peer에 할당된 고유 순번",
            "peer_id": "Peer ID",
            "group_id": "Peer group의 ID",
            "target": "Peer의 IP: Port'로 이루어진 문자열",
            "auth": "Peer의 public key 정보(인증서)",
            "token": "Radio station이 Peer에게 발급한 토큰",
            "status_update_time": "Peer의 연결 상태 정보가 업데이트 된 시간",
            "status": "int: Radio station과 Peer의 연결 상태. (unknown:0, connected:1, disconnected:2)",
            "peer_type": "gRPC proto에 정의된 peer 타입의 문자값 (peer:"0", leader:"1")"
        },
        {
            "..."
        }  
    ]
}
```


### GET /api/v1/peer/leader?channel={channel_name}
Leader Peer의 정보를 가져옴
#### Response Body
```json
{
    "response_code": "int : RES_CODE",
    "data": {
        "order": "Radio Station에 등록된 Peer에 할당된 고유 순번",
        "peer_id": "Peer ID",
        "group_id": "Peer group의 ID",
        "target": "Peer의 IP: Port'로 이루어진 문자열",
        "auth": "Peer의 public key 정보(인증서)",
        "token": "Radio station이 Peer에게 발급한 토큰",
        "status_update_time": "Peer의 연결 상태 정보가 업데이트 된 시간",
        "status": "int: Radio station과 Peer의 연결 상태. (unknown:0, connected:1, disconnected:2)"
    }
}
```


### GET /api/v1/peer/status?peer_id={Peer의 ID}&group_id={Peer의 group ID}&channel={channel_name}
Parameter로 전달한 target 정보와 일치하는 Peer의 상태 정보를 가져옴
#### Response Body
```json
{
    "response_code": "int : RES_CODE",
    "data": {
        "made_block_count": "해당 Peer가 생성한 block의 수",
        "status": "Peer의 연결 상태",
        "audience_count": "해당 Peer를 subscription 중인 Peer의 수",
        "consensus": "합의 방식(none:0, default:1, siever:2)",
        "peer_id": "Peer의 ID",
        "peer_type": "Leader Peer 여부",
        "block_height": "Blockchain 내에서 생성된 Block 수",
        "total_tx": "int: Blockchain 내에서 생성된 Transaction 수",
        "peer_target": "Peer의 gRPC target 정보"
    }
}
```

### GET /api/v1/conf
Loopchain의 모든 Configuration 목록을 가져옴
#### Response Body
```json
{
    "response_code": "int : RES_CODE",
    "data": [
        {
            "name": "Configuration 이름",
            "value": "String 타입의 Configuration 값",
            "type": "int : Configuration 값의 데이터 타입 (string:0, int:1, float:2)"
        },
        {
            "..."
        }
    ]
}
```

### GET /api/v1/conf?name={Configuration 이름}
Loopchain의 Configuration 중 특정 값을 Configuration 이름 기준으로 가져옴
#### Response Body
```json
{
    "response_code": "int : RES_CODE",
    "data": {
        "name": "Configuration 이름",
        "value": "String 타입의 Configuration 값",
        "type": "int : Configuration 값의 데이터 타입 (string:0, int:1, float:2)"
    }
}
```

### POST /api/v1/conf
Loopchain의 특정 Configuration을 설정
#### Request BODY
* Content-Type : application/json
* Request-body : Raw 데이터로써, JSON형태의 데이터

```json
{
    "name": "Configuration 이름",
    "value": "String 타입의 Configuration 값",
}
```
#### Response Body
```json
{
    "response_code": "int : RES_CODE",
    "message": "message"
}
```

### GET /api/v1/cert/list/ca
CA인증서를 발급함
#### Response Body
```json
{
    "response_code": "int : RES_CODE",
    "message": "message"
}
```

### GET /api/v1/cert/list/peer
Peer의 인증서를 발급함
#### Response Body
```json
{
    "response_code": "int : RES_CODE",
    "message": "message"
}
```

### GET /api/v1/cert/issue/ca
Radio station이 발급한 CA인증서를 가져옴
#### Response Body
```json
{
    "response_code": "int : RES_CODE",
    "data": {
        "cert_type": "인증서 타입 (signature:0, encryption:1, ca:2)",
        "subject": "공개키 주체 정보",
        "issuer": "발급 주체 정보",
        "serial_number": "일련번호",
        "not_after": "인증서 만료일",
        "cert_pem": "인증서"
    }
}
```

### GET /api/v1/cert/issue/peer
Radio station이 발급하나 Peer인증서 목록을 가져옴
#### Response Body
```json
{
    "response_code": "int : RES_CODE",
    "data": [
        {
            "cert_type": "인증서 타입 (signature:0, encryption:1, ca:2)",
            "subject": "공개키 주체 정보",
            "issuer": "발급 주체 정보",
            "serial_number": "일련번호",
            "not_after": "인증서 만료일",
            "cert_pem": "인증서"
        },
        {
            "..."
        }
    ]
}
```