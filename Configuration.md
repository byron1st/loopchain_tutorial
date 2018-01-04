각종 상황들에 대한 Option 설정
=======================

 loopchain을 사용하는데 여러가지 사용환경에 따라 설정해야 하는 다양한 것들이 있습니다. 이에 따라 어떤 설정을 해야 하는지에 대해 안내하는 문서입니다.


설정파일은 어떻게 만들고 사용하는가
--------
설정파일은 JSON형식으로 된 파일입니다. 예를 들어 아래처럼 만듭니다.

```
{
  "Variable 1":"Value1",
  "Variable 2":"Value2",
  "Variable 3":"Value3",
  .....
}
```

특정한 JSON파일을 만들고 그 안에 내용을 집어넣고 Peer를 아래와 같이 ``` -o``` option을 줘서 해당 파일을 읽게 해서 peer를 올립니다.

``` python3 peer.py -o peer_conf.json .....```

이 문서에서는 각종 상황별로, 문제별로 어떤 옵션을 설정파일에 집어넣어 처리하면 되는지를 정리한 것입니다.


Log level 설정하기
-------
```LOOPCHAIN_LOG_LEVEL```을 이용하세요. 아래증 하나의 String값을 가지면 됩니다. 기본값은 "DEBUG"입니다.
 - 설정할 수 있는 값: "CRITICAL", "ERROR", "INFO", "WARN", "WARNING", "INFO", "DEBUG", "NOTSET"

Peer의 외부 IP 설정하기
-------

 ```LOOPCHAIN_HOST```에 IP값을 설정해줍니다.

 **기본적으로 Peer는 시작할 때, 해당 Peer가 속한 Network에서 사설 IP(Private IP) 가지고 다른 Peer들과 통신하려고 합니다.** 외부와 통신하지 않고 내부 Network로만 동작하는 경우에는 문제가 없습니다. 그러나 상황에 따라서 공용 IP(Public IP)를 가지고 통신하는 것이 나을 수 있습니다.

 예를 들어, Network를 구성하는 Node들이 기존 인터넷 망을 이용하거나 VPN을 이용해서 통신을 하는 경우, Peer의 IP는 기존 인터넷망이나 VPN에서 접근 가능한 IP여야 합니다. 안타깝게도 Docker상에서는 이런 상황에서 IP를 가져올 수가 없습니다. 그래서 ```LOOPCHAIN_HOST```를 이용해서 다른 Peer들과 통신을 하기 위해 공유되는 IP를 지정할 수 있습니다.

```
{
  'LOOPCHAIN_HOST':'$현재 node가 보여주어야 하는 IP'
}
```

SCORE불러오는 Repository URL 바꾸기
------
*  ```DEFAULT_SCORE_HOST```:현재 Blockchain 서비스에서 SCORE를 가져오기 위해 사용할 Git repository의 URL을 설정해주면 됩니다.


KeyLoad 설정 방법
-------

### loopchain Key 구성요소
loopchain에서는 보안 통신, 트랜잭션 서명등을 위하여 인증서와 키 옵션을 설정해 주어야합니다.

loopchain에서 사용하는 키는 다음과 같습니다.

* Channel 별 서명 키
    * ecdsa secp256k
    * X.509 인증서, Publickey

### Channel 별 서명 키 옵션 설정

 loopchain에서는 트랜잭션 생성 및 블록 생성시 각 Peer를 검증하기위하여 공개키 기반 암호화 알고리즘을 통해 인증 서명을 사용합니다.이때 사용하는 알고리즘은 ecdsa secp256k를 사용하고 인증서 형태와 Publickey 형태를 지원합니다.

 loopchain Peer는 키를 로드 하기 위해 공개키의 형태와(cert, publickey), 키세트 로드방식 키 위치등을 설정하여야 합니다. json형태로 옵션을 설정해야하며 다음 예제는 키 옵션별로 세팅해야될 세팅을 설명.

    ex)
    * channel1 = key_file을 통해 load한다면 아래와 같이 해준다.

```json
{
    "CHANNEL_OPTION" : {
        "channel1" : {
            "load_cert" : false,
            "consensus_cert_use" : false,
            "tx_cert_use" : false,
            "key_load_type": 0,
            "public_path" : "{public_key path}",
            "private_path" : "{private_key path}",
            "private_password" : "{private_key password}"
        }
    }
}

```
 각 Parameter들의 내용들은 다음과 같습니다.
  * ```load_cert``` :load할 인증서의 type 이 cert 면 true, publickey 면 false
  * ```consensus_cert_use```: block 및 투표 서명에 사용할 공개키 타입 (true : cert false : publickey)
  * ```tx_cert_use``` : Transaction서명 및 검증에 사용할 공개키 타입 (true : cert false : publickey)
  * ```key_load_type``` : 0 (File에서 읽음)
  * ```public_path``` : Public key가 있는 위치
  * ```private_path``` : Private key가 있는 위치
  * ```private_password``` : Private key의 Password.



RESTful응답의 성능 높이기
-----
* ```USE_GUNICORN_HA_SERVER``` : 실제 운영단계에 들어가는 Node가 많은 RESTful API에 대한 Request들을 잘 받을 수 있게 gunicorn web service에서 쓸지 말지 결정해주는 변수입니다. 기본값은 False입니다. *실제 서비스에 올릴 때는 반드시 True로 설정되어야 합니다.*

Network가 느릴 경우 조절해야 하는 것들
-------
상황에 따라서 느린 네트워크에 운용을 하게 된다면 여러가지 네트워크 속도에  장애가 있는지 아닌지 확인하고 설정을 바꿔야 합니다.

### Case 1. RadioStaion의 Hart beat의 시간조절
RadioStation은 리더 장애를 파악하기 위해 주기적으로 Peer들에게 HeartBeat를 보내고
허용된 횟수만큼 리더가 응답이 없을 경우 리더를 교체하는 과정을 수행합니다. 그러나 네트워크 사정이 설치되는 환경에 따라 다를 것이기 때문에 아래의 변수들을 RadioStation에서 설정해주셔야 합니다.

* ``` SLEEP_SECONDS_IN_RADIOSTATION_HEARTBEAT ``` : RadioStation이 Peer의 Status를 확인하는 시간. 단위는 Second. 기본값은 30초.
* ``` NO_RESPONSE_COUNT_ALLOW_BY_HEARTBEAT ``` : RadioStation이 Status 확인이 안되는 Leader를 교체할 횟수. 기본값은 5회.

```SLEEP_SECONDS_IN_RADIOSTATION_HEARTBEAT``` X ```NO_RESPONSE_COUNT_ALLOW_BY_HEARTBEAT``` 만큼 리더 응답이 없으면 리더 응답이 없으면 RS가 리더를 교체합니다.

### Case 2. Peer들의 연결 Timeout 설정하기
네트워크 상태에 따라서 아래 변수들을 수정해야 할 수 있습니다. 보통의 경우에는 설정할 필요가 없지만 네트워크가 매우 안좋은 상황에는 시도해볼 수 있습니다.

 * ```GRPC_TIMEOUT```: gRPC 연결하는 시간의 Timeout 한계치. 단위는 Second.
 * ```GRPC_TIMEOUT_BROADCAST_RETRY```: gRPC로 data를 broadcasting하는 시간의 Timeout 한계치. 단위는 Second. 


Hardware 성능의 문제로 Block에 담기는 Tx 숫자를 조절
-------
 Blockchain은 검증된 여러 Tx들을 담고 있는 Block들의 연결입니다. 그러나 Hardware와 Network의 제약으로 이를 조절해야 할 경우, 아래의 변수들을 수정해주십시오.

 * ```MAX_BLOCK_TX_NUM```: 블럭의 담기는 트랜잭션의 최대 갯수
 * ```LEADER_BLOCK_CREATION_LIMIT```: Leader 의 block 생성 갯수. 한 Leader가 이 갯수 이상의 Block을 만들면 다른 Peer로 Leader가 변경.
 * ```BLOCK_VOTE_TIMEOUT```: Block에 대한 투표 응답을 기다리는 최대 시간. 단위는 Seconds.
