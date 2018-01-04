loopchain tutorial
==================

목적
---
loopchain을 실제 설치하고 운영하는데 있어서 가장 중요한 설치 과정에 대한 내용을 기술하고 있습니다.

사전 설치하기
-------

### 최소 사양
* Intel CPU: 8~16 cores per machine
* 8 GB 혹은 그 이상의 memory
* 10 Gigabit 혹은 그 이상의 network


### Docker 설치하기
Docker CE(Community Edition)X86_64, Docker EE(Enterprise edition) X86_64를 운용할 수 있는 최신 환경이면 됩니다.
* Docker CE: 무료사용버전, 가장 기본적인 버전
* Docker EE:상용버전, 무료 Trial제공. 각종 OS들에 대한 지원추가. [Contact point](https://goto.docker.com/contact-us.html)
* 모든 상황에서 방법이 없으면 [docker를 binary부터 설치할 수 있는 방법](https://docs.docker.com/engine/installation/linux/docker-ce/binaries/#install-static-binaries)이 있습니다.

### loopchain Docker image종류
Docker image들은 크게 3가지로 나뉩니다.
* looprs: Radiostation docker images
* looppeer: Peer docker image
* loopchain-fluentd: Log를 받아서 처리하게 수정한 fluentd image입니다.

### 포트 열기
* loopchain을 사용하기 위해 다음의 Port가 열려야 합니다.

* RadioStation
  - 7102: gRPC port
  - 9002: RESTful port

* Peer
  - 7100:gRPC port
  - 9000: RESTful port

TIP:동적으로 포트를 다르게 할 수도 있습니다.

### 최소 Node수
**제대로된 Blockchain network를 구성하기 위해서 약 4개 이상의 Node들을 띄우셔야 합니다.** 여기 예제들에서 1개 혹은 2개만 띄운것은 일종의 예제로 보시면 됩니다.


목차
-----

1. [1개의 RadioStaion과 1개의 Peer로 한 장비 위에서 Blockchain network 구성하기](step1/)
2. [1개의 RadioStation과 2개의 Peer로 한 장비 위에서 Blockchain network 구성하기](step2/)
3. [Local computer에서 SCORE개발 환경 만들기](step3/)
4. [각종 상황들에 대한 Option 설정](Configuration.md)
