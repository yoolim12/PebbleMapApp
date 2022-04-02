# __길치들을 위한 지도 앱 '조약돌'__

## 1. 기존 지도 앱의 문제점
![image](https://user-images.githubusercontent.com/78739536/161401678-81f87be9-95a2-438d-85ef-82f04736c0d9.png)

1. 출발지에서 도착지까지 가기 위해서 사용자가 지도 구조를 파악하면서 가야하는 불편함
2. 지도 상에서 가는 길에 있는 건물들을 찾아보지만 잘 안 보임
3. 화살표 켜기를 하여도 나의 위치를 잘 따라오지 못해 처음부터 다시 검색해야 하는 경우 다반사.
4. 도착지 근처에 도착했다고 뜨지만 여러 건물들에 둘러싸여 있어 잘 보이지 않아 또 헤맨 적이 많음.

__즉, 사용자가 구조를 스스로 파악해야 한다는 점에서 사용자 친화적이지 못함.__

## 2. 눈에 띄는 장소 위주로 길을 안내해주자!
<img width="484" alt="image" src="https://user-images.githubusercontent.com/78739536/161401960-05d6ded2-c066-49f6-8013-ce4644a3c7ab.png">

기존 지도 앱의 경우 사용자가 스스로 지도 구조를 파악하여 길을 찾아야했다면, 가는 길에 있는 친숙하거나 눈에 띄는 장소(지하철역, 백화점, 카페 체인점, 공원 등) 혹은 구조(육교, 버스 정거장 등)들을 위주로  길을 안내하여 사용자가 지도 구조를 파악해야하는 어려움을 줄이고자 하였습니다.

## 3. About 조약돌
<img width="486" alt="image" src="https://user-images.githubusercontent.com/78739536/161402244-07d823bd-5509-419a-b967-aed0da3c9698.png">

① 출발 지점을 사용자로부터 입력 받거나 사용자의 현위치를 추적한다.

② 도착지점을 사용자로부터 입력 받는다.

③ 출발점에서 도착점까지 거치게 되는 장소들에 대한 사진들을 보여준다. 터치하면 사진이 확대된다.

④ 사진에 해당하는 장소가 보이지 않을 때 ※장소가 안 보여요! 를 터치하면 장소의 위치에 대한 자세한 설명이 나온다.

예) 이매고등학교 정문을 등 지고 10시 방향을 바라보면 이매 스타벅스가 보입니다.

⑤ 두 지점 사이의 거리는 사람의 눈에 쉽게 보일 수 있는 거리로 설정한다.(5~10m 간격으로 설정할 예정)

---

<img width="428" alt="image" src="https://user-images.githubusercontent.com/78739536/161402416-7107f7f2-b633-426e-a9cc-a6f6b29fcbc8.png">

- 우리나라에 있는 눈에 띄는 장소들을 모두 정점으로 나타냅니다. 빨간 점은 출발점, 도착점(혹은 출발점, 도착점에서 가까운 눈에 띄는 장소)을 나타냅니다.
(왼쪽은 어느 지역의 일부분 만을 나타낸 것입니다.)

- 간선에는 두 정점 사이의 거리를 적습니다.(두 정점 간의 거리가 5~10m 이내가 될 때 간선으로 연결하고 거리를 적습니다)

- 출발점에서 도착점 까지의 최단 거리를 뽑아서 사용자에게 길을 안내하고 예상 도보 시간을 나타냅니다.

## 4. 린 캔버스

1. 문제: 기존의 지도의 경우 길을 찾을 때 사용자가 지도 구조를 파악해야 한다는 불편함

2. 고객군: 기존 지도의 길찾기에 어려움을 느끼는 사람들

3. 고유의 가치 제안: 지도 구조를 없앰으로써 사용자가 길 안내를 좀더 이해하기 쉽게 한다.(사용자 			친화적)

4. 솔루션: 1. 사용자의 현 위치를 입력 받거나 위치 추적, 도착점을 입력 받는다. -> 2. 출발점과 도착점 사이의 눈에 띄는 장소들 이름과 사진 제공 -> 3. 사진에 해당하는 장소가 보이지 않을 시, 위치에 대한 자세한 설명 제공 (예) 이매고를 등지고 10시 방향을 바라보시오.)

5. 경쟁 우위: 메신저 기능을 제공하는 기업과 연동하여서 길 안내 내용을 다른 사람과 공유할 수 있도록 한다.

6. 수익원: 어플 하단에 광고 or 두 정점(눈에 띄는 장소) 사이에 있는 업체가 홍보를 원하면 두 정점을 이어주는 간선에 업체 광고를 넣는다.
<img width="338" alt="image" src="https://user-images.githubusercontent.com/78739536/161402638-36eabb0e-16ef-43ef-9611-d04c3be62399.png">

7. 비용 구조: 서버 유지 비용 및 어플 마케팅 비용

8. 핵심 지표: 들어오는 광고의 수 및 메신저에서 길 안내 내용 공유 횟수

9. 채널: 해당 메신저 어플 및 SNS를 통해 서비스를 알린다.

## 5. 앱 구현 범위
캡스톤 디자인에 참여하였기에 3달 내에 결과물을 만들어야했어서, 시간적 한계 상 전국 범위가 아닌 아주대학교 캠퍼스 길 안내로 범위를 좁혀서 구현했습니다.
눈에 잘 띄는 구조 및 건물들은 캠퍼스 내에 있는 건물들로 선정하였습니다.

## 6. 앱 구현
<img width="523" alt="image" src="https://user-images.githubusercontent.com/78739536/161403077-dfafdd4d-7c34-49f3-842c-6f967d764f51.png">

## 7. 느낀 점 및 아쉬웠던 
