
Local computer에서 SCORE개발 환경 만들기
===================



1. SCORE 작업 프로젝트 만들기
------

 SCORE를 작업하는 프로젝트를 만들고 github에 만듭니다. [기본 예제](https://github.com/theloopkr/loopchain/tree/master/score/sample-test_score)에서 보이듯 두개의 파일로 구성됩니다.

  * package.json
  * SCORE code ( ```*.py```파일)

To-Do: 추가


2. 만든 SCORE 프로젝트 연결하기
-----

### 2.1 SSH key만들고 Github에 등록하기
 1. Github에서 [Contract sample](https://github.com/theloopkr/contract_sample)Project를 Fork.
 2. 현재 Fork한 프로젝트에 개인 컴퓨터의 SSH public key를 등록

### 2.2 프로젝트 설정하기
 1. Peer 설정 변경

 아래와 같이 ```channel_manage_data.json``` 변경
 ```
 {
   "channel1":
     {
       "score_package": "{your_github_id}/contract_sample"
     }
 }

 ```
 2. Docker 시작 Script변경.
```
docker run -d --name peer0 \
  -v $(pwd)/conf:/conf \
  -v $(pwd)/storage0:/.storage \
  -v $(pwd)/score:/score \
  -v "${SSH_KEY_FOLDER}:/root/.ssh/id_rsa \
  -e "DEFAULT_SCORE_HOST=github.com" \
  --link radio_station:radio_station \
  --log-driver fluentd --log-opt fluentd-address=localhost:24224 \
  -p 7100:7100 -p 9000:9000  \
  loopchain/looppeer:${TAG} \
  python3 peer.py -o /conf/peer_conf.json  -r radio_station:7102
````

3. 확인하기
------

### 3.1 서버들 상태 확인
```
$ curl http://localhost:9002/api/v1/peer/list | python -m json.tool
$ curl http://localhost:9100/api/v1/status/peer | python -m json.tool
```

### 3.2 SCORE 버전 관리
```
$ curl http://localhost:9000/api/v1/status/score | python -m json.tool

```

### 3.3 SCORE에 Transaction보내기

 propose()라는 내부 함수를 불러서 계약 내용을 보내는 Transaction을 Peer0에 만들어봅니다.

```
curl -H "Content-Type: application/json" -X POST -d '{"jsonrpc":"2.0","method":"propose","params":{"proposer":"RealEstateAgent" , "counterparties": ["leaseholder","lessor"], "content": "A아파트 203동 803호를 보증금 1500 월세 70에 계약 2019년 8월 1일까지 임대함, 임대 취소시 ~~~ ", "quorum": "3"}}'  http://localhost:9000/api/v1/transactions | python -m json.tool

```

### 3.4 Transaction 확인하기

```
curl http://localhost:9000/api/v1/transactions/result?hash=${HASH값} | python -m json.tool
```

4. 요약하기
------
