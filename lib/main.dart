import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Locations(title: 'Flutter Demo'),
    );
  }
}

//첫 검색창 화면
class Locations extends StatefulWidget {
  final String title;

  Locations({Key? key, required this.title}) : super(key: key);

  @override
  LocationsState createState() => LocationsState();
}

//첫 검색창 화면에서 '도보 경로 찾기'를 눌렀을 때의 state 변화
class LocationsState extends State<Locations> {
  final formKey = GlobalKey<FormState>();

  final startController = TextEditingController();
  final endController = TextEditingController();

  void dispose(){
    startController.dispose();
    endController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(title: Text('조약돌')),
        body: Container(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '출발지를 입력하세요',
                      ),
                      controller: startController,
                      keyboardType: TextInputType.text,
                      validator: (value){
                        if(value!.trim().isEmpty){
                          return '출발지를 입력하세요';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '도착지를 입력하세요',
                      ),
                      controller: endController,
                      keyboardType: TextInputType.text,
                      validator: (value){
                        if(value!.trim().isEmpty){
                          return '도착지를 입력하세요';
                        }
                        return null;
                      },
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 16.0),
                        alignment: Alignment.centerRight,
                        child: RaisedButton(
                          onPressed: (){
                            if(formKey.currentState!.validate()){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Pebbles(
                                        startController.text.trim(),
                                        endController.text.trim()
                                    ),
                                  )
                              );
                            }
                          },
                          child: Text('도보 경로 찾기'),
                        )
                    )
                  ],
                )
            )
        )
    );
  }
}

//길 안내 시 장소에 대한 사진을 보여주는 '사진' 버튼
// class PicButton extends StatefulWidget{
//   @override
//   PicButtonState createState() => PicButtonState();
// }

//'사진' 버튼을 눌렀을 때의 state 변화
// class PicButtonState extends State<PicButton> {
//
//   String url = "";
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         new RaisedButton(onPressed: showImage,
//           child:
//
//           const Text(
//             "사진",
//             style: TextStyle(fontSize: 15),
//           ),
//         ),
//         new Image(image: AssetImage(url))
//       ],
//     );
//   }
//
//   //사진을 저장한 위치를 제시하는 함수
//   void showImage() {
//     setState(() {
//       // url = "images/yoolim.JPG";
//     });
//   }
// }

//출발 지점과 도착 지점을 입력한 것을 넘겨 받는다.
class Pebbles extends StatelessWidget{
  @override

  final String start;//출발 지점
  final String end;//도착 지점

  Pebbles(this.start, this.end);//출발, 도착 지점을 넘겨 받는 과정

  var data = [];//출발지, 도착지, 거쳐야 하는 길이 담긴 리스트
  var guide = [];//거쳐야 하는 길만 담긴 리스트

//학교 내에 있는 52개의 길들에 대한 안내. 정문에서 학교 안으로 들어가는 방향으로 설정하였다.
//길들에 대한 안내는 학교에서 눈에 띄는 장소들(이유: 크기가 크다던지, 높아서 눈에 잘 띈다던지 등)을 이용하여 한 것입니다.
  var exp1='운동장을 오른편에 두고 직진하세요';
  var exp2= '선구자상 쪽으로 직진하세요';
  var exp3= '선구자상 중심으로 왼쪽 갈림길로 가세요';
  var exp4= '선구자상 중심으로 오른쪽 갈림길로 가세요';
  var exp5= '원천관 앞 주차장을 지나가세요';
  var exp6= '화공실험동 쪽으로 가세요';
  var exp7= '원천관 뒷편의 주차장을 지나가세요';
  var exp8= '원천정보관 방향 계단을 올라가세요';
  var exp9= '화공실험동을 오른편에 두고 직진하세요';
  var exp10= '성호관 다리로 가세요';
  var exp11= '학생회관1 쪽으로 가세요';
  var exp12= '동관 쪽으로 가세요';
  var exp13= '토목실험동 쪽으로 가세요';
  var exp14= '토목실험동 중심으로 왼쪽 갈림길로 직진하세요';
  var exp15= '토목실험동 중심으로 오른쪽 갈림길로 직진하세요';
  var exp16= '팔달관 방향 계단을 올라가세요';
  var exp17= '남제관 기숙사 방향 계단을 올라가세요';
  var exp18= '남제관 기숙사를 오른편에 두고 직진하세요';
  var exp19= '용지관 기숙사 방향 계단을 올라가세요';
  var exp20= '화홍관 기숙사 방향 계단을 올라가세요';
  var exp21= '광교관 기숙사 방향 계단을 올라가세요';
  var exp22= '학생회관1을 오른편에 두고 직진하세요';
  var exp23= '에너지센터 주차장 쪽으로 가세요';
  var exp24= '중앙도서관 쪽으로 가세요';
  var exp25= '중앙도서관 옆 주차장을 왼편에 두고 직진하세요';
  var exp26= '제2 주차장 빌딩 쪽으로 가세요';
  var exp27= '체육관 쪽으로 가세요';
  var exp28= '율곡관을 오른편에 두고 직진하세요';
  var exp29= '학생회관2 쪽으로 가세요';
  var exp30= '성호관 극장 쪽으로 가세요';
  var exp31= '성호관 쪽으로 가세요';
  var exp32= '성호관을 왼편에 두고 직진하세요';
  var exp33= '율곡관 뒷편의 길을 직진하세요';
  var exp34= '다산관 쪽으로 가세요';
  var exp35= '종합관을 왼편에 두고 직진하세요';
  var exp36= '정문 밖으로 나가는 방향에서 왼쪽으로 직진하세요';
  var exp37= '병원별관을 왼편에 두고 직진하세요';
  var exp38= '다산관을 오른편에 둔 상태로 왼쪽 갈림길로 직진하세요';
  var exp39= '팔달관 주차장 앞의 오르막길을 올라가세요';
  var exp40= '종합설계동을 오른편에 둔 상태로 오르막길을 올라가세요';
  var exp41= '학군단을 오른편에 둔 상태로 오르막길을 올라가세요';
  var exp42= '기숙사 식당을 왼편에 둔 상태로 직진하세요';
  var exp43= '중앙도서관 옆 주차장으로 들어가세요';
  var exp44= '다산관 앞을 지나가세요';
  var exp45= '종합관 쪽으로 가세요';
  var exp46= '캠퍼스 플라자 앞의 정문 방향 횡단보도를 건네세요';
  var exp47= '송재관 쪽으로 가세요';
  var exp48= '아주대학교 병원 정문 쪽으로 가세요';
  var exp49= '병원 정문으로 들어가서 왼쪽으로 가세요';
  var exp50= '병원 정문으로 들어가서 직진하세요';
  var exp51= '병원 별관 쪽으로 가세요';
  var exp52= '아주대학교 병원을 왼편에 두고 직진하세요';

//같은 길이어도 위와 반대 방향으로 가게 될 경우, 설명도 조금씩 달라집니다.
  var bexp1='운동장을 왼편에 두고 직진하세요';
  var bexp2= '축구장 쪽으로 직진하세요';
  var bexp3= '에너지센터를 오른편에 둔 상태로 직진하세요';
  var bexp4= '더테라스를 왼편에 둔 상태로 직진하세요';
  var bexp5= '원천관 앞 주차장을 지나가세요';
  var bexp6= '원천관 쪽으로 가세요';
  var bexp7= '원천관 뒷편의 주차장을 지나가세요';
  var bexp8= '원천정보관 앞의 계단을 내려가세요';
  var bexp9= '서관을 왼편에 두고 직진하세요';
  var bexp10= '성호관 다리를 왼편에 두고 직진하세요';
  var bexp11= '학생회관1을 오른편에 둔 채로 직진하세요';
  var bexp12= '동관 옆의 학생회관1 방향의 내리막길을 내려가세요';
  var bexp13= '동관 쪽으로 가세요';
  var bexp14= '토목실험동 쪽으로 가세요';
  var bexp15= '토목실험동 쪽으로 가세요';
  var bexp16= '팔달관 앞의 계단을 내려가세요';
  var bexp17= '학생회관1 방향 계단을 내려가세요';
  var bexp18= '남제관 기숙사를 왼편에 두고 직진하세요';
  var bexp19= '기숙사 식당 방향 계단을 내려가세요';
  var bexp20= '용지관 기숙사 방향 계단을 내려가세요';
  var bexp21= '화홍관 기숙사 방향 계단을 내려가세요';
  var bexp22= '학생회관1을 왼편에 두고 직진하세요';
  var bexp23= '선구자상 쪽으로 가세요';
  var bexp24= '중앙도서관 쪽으로 가세요';
  var bexp25= '중앙도서관 옆 주차장을 오른편에 두고 직진하세요';
  var bexp26= '제2 주차장 빌딩 쪽으로 가세요';
  var bexp27= '체육관 쪽으로 가세요';
  var bexp28= '율곡관을 왼편에 두고 직진하세요';
  var bexp29= '학생회관1 쪽으로 가세요';
  var bexp30= '학생회관1 쪽으로 가세요';
  var bexp31= '중앙도서관 옆 주차장 쪽으로 가세요';
  var bexp32= '성호관을 오른편에 두고 직진하세요';
  var bexp33= '율곡관 뒷편의 길을 직진하세요';
  var bexp34= '다산관 쪽으로 가세요';
  var bexp35= '종합관을 오른편에 두고 직진하세요';
  var bexp36= '아주대학교 웰빙센터를 왼편에 둔 상태에서 오른쪽 갈림길로 직진하세요';
  var bexp37= '병원별관을 오른편에 두고 직진하세요';
  var bexp38= '국제학사 기숙사 앞의 내리막길을 내려가세요';
  var bexp39= '산학협력원 옆의 내리막길을 내려가세요';
  var bexp40= '북문을 기준으로 오른쪽 내리막길을 내려가세요';
  var bexp41= '북문을 기준으로 왼쪽 내리막길을 내려가세요';
  var bexp42= '기숙사 식당을 오른편에 둔 상태로 직진하세요';
  var bexp43= '축구장 쪽으로 나오세요';
  var bexp44= '다산관 앞을 지나가세요';
  var bexp45= '율곡관 쪽으로 가세요';
  var bexp46= '정문 앞의 왼쪽 횡단보도를 건네세요';
  var bexp47= '제2주차빌딩 쪽으로 가세요';
  var bexp48= '병원 정문을 오른편에 둔 상태에서 직진하세요';
  var bexp49= '병원 정문 쪽으로 가세요';
  var bexp50= '병원 정문 쪽으로 가세요';
  var bexp51= '웰빙센터 쪽으로 가세요';
  var bexp52= '아주대학교 병원을 오른편에 두고 직진하세요';

  void cal()
  {
    var startpoint = '출발지: $start';//입력 받았던 출발지점에 대하여 출발 지점을 무엇으로 입력 받았는지를 startpoint에 넘긴다.

    data.add(startpoint);//'출발지: ~'를 data라는 리스트에 추가

    //출발지점이 ~일 때, 도착지점이 ~면 무슨 길을 거쳐야 되는지 guide 리스트에 넣는다.(여기서부턴 너무 기니까 마우스로 스크롤을 쭉 내려주세요)
    if(start == '정문')
    {
      if(end == '버스정류장')
        guide = [exp1];

      else if(end == '선구자상')
        guide = [exp1, exp2];

      else if(end == '에너지센터')
        guide = [exp1, exp2, exp23];

      else if(end == '원천관')
        guide = [exp1, exp2, exp4, exp5];

      else if(end == '원천정보관')
        guide = [exp1, exp2, exp4, exp10, exp12];

      else if(end == '북문')
        guide = [exp1, exp2, exp4, exp10, exp22, exp18, exp41];

      else if(end == '화공실험동')
        guide = [exp1, exp2, exp3, exp6];

      else if(end == '서관')
        guide = [exp1, exp2, exp3, exp6, exp9];

      else if(end == '동관')
        guide = [exp1, exp2, exp4, exp10, exp12];

      else if(end == '종합설계동')
        guide = [exp1, exp2, exp3, exp6, exp9];

      else if(end == '대형지반연구실험동')
        guide = [exp1, exp2, exp3, exp6, exp9, '종합설계동 바로 오른쪽의 건물로 가세요'];

      else if(end == '토목실험동')
        guide = [exp1, exp2, exp3, exp6, exp9, bexp14];

      else if(end == '팔달관')
        guide = [exp1, exp2, exp4, exp10, exp22, exp16];

      else if(end == '학군단')
        guide = [exp1, exp2, exp4, exp10, exp22, exp18, '학군단 건물 쪽으로 가세요'];

      else if(end == '산학협력원')
        guide = [exp1, exp2, exp4, exp10, exp22, exp18, exp41, exp39];

      else if(end == '국제학사')
        guide = [exp1, exp2, exp4, exp10, exp22, exp18, exp42, '오르막길을 올라가세요'];

      else if(end == '광교관')
        guide = [exp1, exp2, exp4, exp10, exp22, exp19, exp20, exp21];

      else if(end == '화홍관')
        guide = [exp1, exp2, exp4, exp10, exp22, exp19, exp20];

      else if(end == '용지관')
        guide = [exp1, exp2, exp4, exp10, exp22, exp19];

      else if(end == '기숙사식당')
        guide = [exp1, exp2, exp4, exp10, exp22, exp18];

      else if(end == '교직원식당')
        guide = [exp1, exp2, exp4, exp10, exp22, exp18, '기숙사 식당 도착', '기숙사 식당 건물 2층으로 올라가세요'];

      else if(end == '남제관')
        guide = [exp1, exp2, exp4, exp10, exp11, exp17];

      else if(end == '학생회관1')
        guide = [exp1, exp2, exp4, exp10, exp11];

      else if(end == '학생회관2')
        guide = [exp1, exp2, exp4, exp10, exp11, exp29];

      else if(end == '성호관')
        guide = [exp1, exp2, exp4, exp10];

      else if(end == '더테라스')
        guide = [exp1, exp2, exp4];

      else if(end == '중앙도서관')
        guide = [exp1, exp24];

      else if(end == '노천극장')
        guide = [exp1, exp24, exp43, '노천극장 쪽으로 가세요'];

      else if(end == '율곡관')
        guide = [exp1, exp24, exp25];

      else if(end == '다산관')
        guide = [exp1, exp24, exp25, exp35, exp34];

      else if(end == '약학관')
        guide = [exp1, exp24, exp25, exp35, exp44, '약학관 쪽으로 가세요'];

      else if(end == '임상수기센터및실험동물센터')
        guide = [exp1, exp24, exp25, exp35, exp44, '임상수기센터및실험동물센터 쪽으로 가세요'];

      else if(end == '종합관')
        guide = [exp1, exp24, exp25, exp45];

      else if(end == '테니스장')
        guide = [exp1, exp24, exp25, exp45, '테니스장 쪽으로 가세요'];

      else if(end == '의과대학연구관')
        guide = [exp1, exp24, exp25, exp45, '의과대학연구관 쪽으로 가세요'];

      else if(end == '제2주차빌딩')
        guide = [exp1, exp24, exp25, exp26];

      else if(end == '체육관')
        guide = [exp1, exp24, exp25, exp26, exp27];

      else if(end == '운동장')
        guide = [];

      else if(end == '캠퍼스플라자')
        guide = [bexp46];

      else if(end == '송재관')
        guide = [exp36, bexp37, exp26, exp47];

      else if(end == '아주대학교병원')
        guide = [exp36, exp48, exp50];

      else if(end == '병원별관')
        guide = [exp36, exp48, exp49, exp51];

      else if(end == '웰빙센터')
        guide = [exp36, exp48, exp49];

      else if(end == '제1주차빌딩')
        guide = [exp1, exp24, exp25, exp45, '제1주차빌딩 쪽으로 가세요'];

      else if(end == '장례식장')
        guide = [exp1, exp24, exp25, exp45, '제1주차빌딩 쪽으로 가세요', '장례식장 쪽으로 가세요'];

      else if(end == '병원정문')
        guide = [exp36, exp48];

      else if(end == '동문')
        guide = [exp1, exp24, exp25, exp45, '제1주차빌딩 쪽으로 가세요', '장례식장 쪽으로 가세요', '동문 쪽으로 가세요'];

      else if(end == '권역외상센터')
        guide = [exp36, exp48, exp50, exp52];

      else if(end == '남문')
        guide = [exp36];
    }

    else if(start == '버스정류장')
    {
      if(end == '정문')
        guide = [bexp1];

      else if(end == '선구자상')
        guide = [exp2];

      else if(end == '에너지센터')
        guide = [exp2, exp23];

      else if(end == '원천관')
        guide = [exp2, exp3, exp5];

      else if(end == '원천정보관')
        guide = [exp2, exp4, exp10, exp12];

      else if(end == '북문')
        guide = [exp2, exp4, exp10, exp22, exp18, exp41];

      else if(end == '화공실험동')
        guide = [exp2, exp3, exp6];

      else if(end == '서관')
        guide = [exp2, exp3, exp6, exp9];

      else if(end == '동관')
        guide = [exp2, exp4, exp10, exp12];

      else if(end == '종합설계동')
        guide = [exp2, exp3, exp6, exp9];

      else if(end == '대형지반연구실험동')
        guide = [exp2, exp3, exp6, exp9, '종합설계동 바로 오른쪽의 건물로 가세요'];

      else if(end == '토목실험동')
        guide = [exp2, exp3, exp6, exp9, bexp14];

      else if(end == '팔달관')
        guide = [exp2, exp4, exp10, exp22, exp16];

      else if(end == '학군단')
        guide = [exp2, exp4, exp10, exp22, exp18, '학군단 건물 쪽으로 가세요'];

      else if(end == '산학협력원')
        guide = [exp2, exp4, exp10, exp22, exp18, exp41, exp39];

      else if(end == '국제학사')
        guide = [exp2, exp4, exp10, exp22, exp18, exp42, '오르막길을 올라가세요'];

      else if(end == '광교관')
        guide = [exp2, exp4, exp10, exp22, exp19, exp20, exp21];

      else if(end == '화홍관')
        guide = [exp2, exp4, exp10, exp22, exp19, exp20];

      else if(end == '용지관')
        guide = [exp2, exp4, exp10, exp22, exp19];

      else if(end == '기숙사식당')
        guide = [exp2, exp4, exp10, exp22, exp18];

      else if(end == '교직원식당')
        guide = [exp2, exp4, exp10, exp22, exp18, '기숙사 식당 도착', '기숙사 식당 건물 2층으로 올라가세요'];

      else if(end == '남제관')
        guide = [exp2, exp4, exp10, exp11, exp17];

      else if(end == '학생회관1')
        guide = [exp2, exp4, exp10, exp11];

      else if(end == '학생회관2')
        guide = [exp2, exp4, exp10, exp11, exp29];

      else if(end == '성호관')
        guide = [exp2, exp4, exp10];

      else if(end == '더테라스')
        guide = [exp2, exp4];

      else if(end == '중앙도서관')
        guide = [exp24];

      else if(end == '노천극장')
        guide = [exp24, exp43, '노천극장 쪽으로 가세요'];

      else if(end == '율곡관')
        guide = [exp24, exp25];

      else if(end == '다산관')
        guide = [exp24, exp25, exp35, exp34];

      else if(end == '약학관')
        guide = [exp24, exp25, exp35, exp44, '약학관 쪽으로 가세요'];

      else if(end == '임상수기센터및실험동물센터')
        guide = [exp24, exp25, exp35, exp44, '임상수기센터및실험동물센터 쪽으로 가세요'];

      else if(end == '종합관')
        guide = [exp24, exp25, exp45];

      else if(end == '테니스장')
        guide = [exp24, exp25, exp45, '테니스장 쪽으로 가세요'];

      else if(end == '의과대학연구관')
        guide = [exp24, exp25, exp45, '의과대학연구관 쪽으로 가세요'];

      else if(end == '제2주차빌딩')
        guide = [exp24, exp25, exp26];

      else if(end == '체육관')
        guide = [exp24, exp25, exp26, exp27];

      else if(end == '운동장')
        guide = [bexp2, bexp1];

      else if(end == '캠퍼스플라자')
        guide = [bexp2, bexp1, bexp46];

      else if(end == '송재관')
        guide = [bexp2, bexp1, exp36, bexp37, exp26, exp47];

      else if(end == '아주대학교병원')
        guide = [bexp2, bexp1, exp36, exp48, exp50];

      else if(end == '병원별관')
        guide = [bexp2, bexp1, exp36, exp48, exp49, exp51];

      else if(end == '웰빙센터')
        guide = [bexp2, bexp1, exp36, exp48, exp49];

      else if(end == '제1주차빌딩')
        guide = [exp24, exp25, exp45, '제1주차빌딩 쪽으로 가세요'];

      else if(end == '장례식장')
        guide = [exp24, exp25, exp45, '제1주차빌딩 쪽으로 가세요', '장례식장 쪽으로 가세요'];

      else if(end == '병원정문')
        guide = [bexp2, bexp1, exp36, exp48];

      else if(end == '동문')
        guide = [exp24, exp25, exp45, '제1주차빌딩 쪽으로 가세요', '장례식장 쪽으로 가세요', '동문 쪽으로 가세요'];

      else if(end == '권역외상센터')
        guide = [bexp2, bexp1, exp36, exp48, exp50, exp52];

      else if(end == '남문')
        guide = [bexp2, bexp1, exp36];
    }

    else if(start == '선구자상')
    {
      if(end == '정문')
        guide = [bexp2, bexp1];

      else if(end == '버스정류장')
        guide = [bexp2];

      else if(end == '에너지센터')
        guide = [exp23];

      else if(end == '원천관')
        guide = [exp3, exp5];

      else if(end == '원천정보관')
        guide = [exp4, exp10, exp12];

      else if(end == '북문')
        guide = [exp4, exp10, exp22, exp18, exp41];

      else if(end == '화공실험동')
        guide = [exp3, exp6];

      else if(end == '서관')
        guide = [exp3, exp6, exp9];

      else if(end == '동관')
        guide = [exp4, exp10, exp12];

      else if(end == '종합설계동')
        guide = [exp3, exp6, exp9];

      else if(end == '대형지반연구실험동')
        guide = [exp3, exp6, exp9, '종합설계동 바로 오른쪽의 건물로 가세요'];

      else if(end == '토목실험동')
        guide = [exp3, exp6, exp9, bexp14];

      else if(end == '팔달관')
        guide = [exp4, exp10, exp22, exp16];

      else if(end == '학군단')
        guide = [exp4, exp10, exp22, exp18, '학군단 건물 쪽으로 가세요'];

      else if(end == '산학협력원')
        guide = [exp4, exp10, exp22, exp18, exp41, exp39];

      else if(end == '국제학사')
        guide = [exp4, exp10, exp22, exp18, exp42, '오르막길을 올라가세요'];

      else if(end == '광교관')
        guide = [exp4, exp10, exp22, exp19, exp20, exp21];

      else if(end == '화홍관')
        guide = [exp4, exp10, exp22, exp19, exp20];

      else if(end == '용지관')
        guide = [exp4, exp10, exp22, exp19];

      else if(end == '기숙사식당')
        guide = [exp4, exp10, exp22, exp18];

      else if(end == '교직원식당')
        guide = [exp4, exp10, exp22, exp18, '기숙사 식당 도착', '기숙사 식당 건물 2층으로 올라가세요'];

      else if(end == '남제관')
        guide = [exp4, exp10, exp11, exp17];

      else if(end == '학생회관1')
        guide = [exp4, exp10, exp11];

      else if(end == '학생회관2')
        guide = [exp4, exp10, exp11, exp29];

      else if(end == '성호관')
        guide = [exp4, exp10];

      else if(end == '더테라스')
        guide = [exp4];

      else if(end == '중앙도서관')
        guide = [bexp2, exp24];

      else if(end == '노천극장')
        guide = [bexp2, exp24, exp43, '노천극장 쪽으로 가세요'];

      else if(end == '율곡관')
        guide = [bexp2, exp24, exp25];

      else if(end == '다산관')
        guide = [bexp2, exp24, exp25, exp35, exp34];

      else if(end == '약학관')
        guide = [bexp2, exp24, exp25, exp35, exp44, '약학관 쪽으로 가세요'];

      else if(end == '임상수기센터및실험동물센터')
        guide = [bexp2, exp24, exp25, exp35, exp44, '임상수기센터및실험동물센터 쪽으로 가세요'];

      else if(end == '종합관')
        guide = [bexp2, exp24, exp25, exp45];

      else if(end == '테니스장')
        guide = [bexp2, exp24, exp25, exp45, '테니스장 쪽으로 가세요'];

      else if(end == '의과대학연구관')
        guide = [bexp2, exp24, exp25, exp45, '의과대학연구관 쪽으로 가세요'];

      else if(end == '제2주차빌딩')
        guide = [bexp2, exp24, exp25, exp26];

      else if(end == '체육관')
        guide = [bexp2, exp24, exp25, exp26, exp27];

      else if(end == '운동장')
        guide = [bexp2, bexp1];

      else if(end == '캠퍼스플라자')
        guide = [bexp2, bexp1, bexp46];

      else if(end == '송재관')
        guide = [bexp2, bexp1, exp36, bexp37, exp26, exp47];

      else if(end == '아주대학교병원')
        guide = [bexp2, bexp1, exp36, exp48, exp50];

      else if(end == '병원별관')
        guide = [bexp2, bexp1, exp36, exp48, exp49, exp51];

      else if(end == '웰빙센터')
        guide = [bexp2, bexp1, exp36, exp48, exp49];

      else if(end == '제1주차빌딩')
        guide = [bexp2, exp24, exp25, exp45, '제1주차빌딩 쪽으로 가세요'];

      else if(end == '장례식장')
        guide = [bexp2, exp24, exp25, exp45, '제1주차빌딩 쪽으로 가세요', '장례식장 쪽으로 가세요'];

      else if(end == '병원정문')
        guide = [bexp2, bexp1, exp36, exp48];

      else if(end == '동문')
        guide = [bexp2, exp24, exp25, exp45, '제1주차빌딩 쪽으로 가세요', '장례식장 쪽으로 가세요', '동문 쪽으로 가세요'];

      else if(end == '권역외상센터')
        guide = [bexp2, bexp1, exp36, exp48, exp50, exp52];

      else if(end == '남문')
        guide = [bexp2, bexp1, exp36];
    }

    else if(start == '에너지센터')
    {
      if(end == '정문')
        guide = [bexp23, bexp2, bexp1];

      else if(end == '버스정류장')
        guide = [bexp23, bexp2];

      else if(end == '선구자상')
        guide = [bexp23];

      else if(end == '원천관')
        guide = [bexp23, exp3, exp5];

      else if(end == '원천정보관')
        guide = [bexp23, exp4, exp10, exp12];

      else if(end == '북문')
        guide = [bexp23, exp4, exp10, exp22, exp18, exp41];

      else if(end == '화공실험동')
        guide = [bexp23, exp3, exp6];

      else if(end == '서관')
        guide = [bexp23, exp3, exp6, exp9];

      else if(end == '동관')
        guide = [bexp23, exp4, exp10, exp12];

      else if(end == '종합설계동')
        guide = [bexp23, exp3, exp6, exp9];

      else if(end == '대형지반연구실험동')
        guide = [bexp23, exp3, exp6, exp9, '종합설계동 바로 오른쪽의 건물로 가세요'];

      else if(end == '토목실험동')
        guide = [bexp23, exp3, exp6, exp9, bexp14];

      else if(end == '팔달관')
        guide = [bexp23, exp4, exp10, exp22, exp16];

      else if(end == '학군단')
        guide = [bexp23, exp4, exp10, exp22, exp18, '학군단 건물 쪽으로 가세요'];

      else if(end == '산학협력원')
        guide = [bexp23, exp4, exp10, exp22, exp18, exp41, exp39];

      else if(end == '국제학사')
        guide = [bexp23, exp4, exp10, exp22, exp18, exp42, '오르막길을 올라가세요'];

      else if(end == '광교관')
        guide = [bexp23, exp4, exp10, exp22, exp19, exp20, exp21];

      else if(end == '화홍관')
        guide = [bexp23, exp4, exp10, exp22, exp19, exp20];

      else if(end == '용지관')
        guide = [bexp23, exp4, exp10, exp22, exp19];

      else if(end == '기숙사식당')
        guide = [bexp23, exp4, exp10, exp22, exp18];

      else if(end == '교직원식당')
        guide = [bexp23, exp4, exp10, exp22, exp18, '기숙사 식당 도착', '기숙사 식당 건물 2층으로 올라가세요'];

      else if(end == '남제관')
        guide = [bexp23, exp4, exp10, exp11, exp17];

      else if(end == '학생회관1')
        guide = [bexp23, exp4, exp10, exp11];

      else if(end == '학생회관2')
        guide = [bexp23, exp4, exp10, exp11, exp29];

      else if(end == '성호관')
        guide = [bexp23, exp4, exp10];

      else if(end == '더테라스')
        guide = [bexp23, exp4];

      else if(end == '중앙도서관')
        guide = [bexp23, bexp2, exp24];

      else if(end == '노천극장')
        guide = [bexp23, bexp2, exp24, exp43, '노천극장 쪽으로 가세요'];

      else if(end == '율곡관')
        guide = [bexp23, bexp2, exp24, exp25];

      else if(end == '다산관')
        guide = [bexp23, bexp2, exp24, exp25, exp35, exp34];

      else if(end == '약학관')
        guide = [bexp23, bexp2, exp24, exp25, exp35, exp44, '약학관 쪽으로 가세요'];

      else if(end == '임상수기센터및실험동물센터')
        guide = [bexp23, bexp2, exp24, exp25, exp35, exp44, '임상수기센터및실험동물센터 쪽으로 가세요'];

      else if(end == '종합관')
        guide = [bexp23, bexp2, exp24, exp25, exp45];

      else if(end == '테니스장')
        guide = [bexp23, bexp2, exp24, exp25, exp45, '테니스장 쪽으로 가세요'];

      else if(end == '의과대학연구관')
        guide = [bexp23, bexp2, exp24, exp25, exp45, '의과대학연구관 쪽으로 가세요'];

      else if(end == '제2주차빌딩')
        guide = [bexp23, bexp2, exp24, exp25, exp26];

      else if(end == '체육관')
        guide = [bexp23, bexp2, exp24, exp25, exp26, exp27];

      else if(end == '운동장')
        guide = [bexp23, bexp2, bexp1];

      else if(end == '캠퍼스플라자')
        guide = [bexp23, bexp2, bexp1, bexp46];

      else if(end == '송재관')
        guide = [bexp23, bexp2, bexp1, exp36, bexp37, exp26, exp47];

      else if(end == '아주대학교병원')
        guide = [bexp23, bexp2, bexp1, exp36, exp48, exp50];

      else if(end == '병원별관')
        guide = [bexp23, bexp2, bexp1, exp36, exp48, exp49, exp51];

      else if(end == '웰빙센터')
        guide = [bexp23, bexp2, bexp1, exp36, exp48, exp49];

      else if(end == '제1주차빌딩')
        guide = [bexp23, bexp2, exp24, exp25, exp45, '제1주차빌딩 쪽으로 가세요'];

      else if(end == '장례식장')
        guide = [bexp23, bexp2, exp24, exp25, exp45, '제1주차빌딩 쪽으로 가세요', '장례식장 쪽으로 가세요'];

      else if(end == '병원정문')
        guide = [bexp23, bexp2, bexp1, exp36, exp48];

      else if(end == '동문')
        guide = [bexp23, bexp2, exp24, exp25, exp45, '제1주차빌딩 쪽으로 가세요', '장례식장 쪽으로 가세요', '동문 쪽으로 가세요'];

      else if(end == '권역외상센터')
        guide = [bexp23, bexp2, bexp1, exp36, exp48, exp50, exp52];

      else if(end == '남문')
        guide = [bexp23, bexp2, bexp1, exp36];
    }

    else if(start == '원천관')
    {
      if(end == '정문')
        guide = [bexp4, bexp2, bexp1];

      else if(end == '버스정류장')
        guide = [bexp3, bexp2];

      else if(end == '선구자상')
        guide = [bexp3];

      else if(end == '에너지센터')
        guide = [bexp3, exp23];

      else if(end == '원천정보관')
        guide = [exp5, exp6, exp7, exp8];

      else if(end == '북문')
        guide = [exp10, exp22, exp18, exp41];

      else if(end == '화공실험동')
        guide = [exp6];

      else if(end == '서관')
        guide = [exp6, exp9];

      else if(end == '동관')
        guide = [exp10, exp12];

      else if(end == '종합설계동')
        guide = [exp6, exp9];

      else if(end == '대형지반연구실험동')
        guide = [exp6, exp9, '종합설계동 바로 오른쪽의 건물로 가세요'];

      else if(end == '토목실험동')
        guide = [exp6, exp9, bexp14];

      else if(end == '팔달관')
        guide = [exp10, exp22, exp16];

      else if(end == '학군단')
        guide = [exp10, exp22, exp18, '학군단 건물 쪽으로 가세요'];

      else if(end == '산학협력원')
        guide = [exp10, exp22, exp18, exp41, exp39];

      else if(end == '국제학사')
        guide = [exp10, exp22, exp18, exp42, '오르막길을 올라가세요'];

      else if(end == '광교관')
        guide = [exp10, exp22, exp19, exp20, exp21];

      else if(end == '화홍관')
        guide = [exp10, exp22, exp19, exp20];

      else if(end == '용지관')
        guide = [exp10, exp22, exp19];

      else if(end == '기숙사식당')
        guide = [exp10, exp22, exp18];

      else if(end == '교직원식당')
        guide = [exp10, exp22, exp18, '기숙사 식당 도착', '기숙사 식당 건물 2층으로 올라가세요'];

      else if(end == '남제관')
        guide = [exp10, exp11, exp17];

      else if(end == '학생회관1')
        guide = [exp10, exp11];

      else if(end == '학생회관2')
        guide = [exp10, exp11, exp29];

      else if(end == '성호관')
        guide = [exp10];

      else if(end == '더테라스')
        guide = [exp5];

      else if(end == '중앙도서관')
        guide = [bexp4, bexp2, exp24];

      else if(end == '노천극장')
        guide = [bexp4, bexp2, exp24, exp43, '노천극장 쪽으로 가세요'];

      else if(end == '율곡관')
        guide = [bexp4, bexp2, exp24, exp25];

      else if(end == '다산관')
        guide = [bexp4, bexp2, exp24, exp25, exp35, exp34];

      else if(end == '약학관')
        guide = [bexp4, bexp2, exp24, exp25, exp35, exp44, '약학관 쪽으로 가세요'];

      else if(end == '임상수기센터및실험동물센터')
        guide = [bexp4, bexp2, exp24, exp25, exp35, exp44, '임상수기센터및실험동물센터 쪽으로 가세요'];

      else if(end == '종합관')
        guide = [bexp4, bexp2, exp24, exp25, exp45];

      else if(end == '테니스장')
        guide = [bexp4, bexp2, exp24, exp25, exp45, '테니스장 쪽으로 가세요'];

      else if(end == '의과대학연구관')
        guide = [bexp4, bexp2, exp24, exp25, exp45, '의과대학연구관 쪽으로 가세요'];

      else if(end == '제2주차빌딩')
        guide = [bexp4, bexp2, exp24, exp25, exp26];

      else if(end == '체육관')
        guide = [bexp4, bexp2, exp24, exp25, exp26, exp27];

      else if(end == '운동장')
        guide = [bexp4, bexp2, bexp1];

      else if(end == '캠퍼스플라자')
        guide = [bexp4, bexp2, bexp1, bexp46];

      else if(end == '송재관')
        guide = [bexp4, bexp2, bexp1, exp36, bexp37, exp26, exp47];

      else if(end == '아주대학교병원')
        guide = [bexp4, bexp2, bexp1, exp36, exp48, exp50];

      else if(end == '병원별관')
        guide = [bexp4, bexp2, bexp1, exp36, exp48, exp49, exp51];

      else if(end == '웰빙센터')
        guide = [bexp4, bexp2, bexp1, exp36, exp48, exp49];

      else if(end == '제1주차빌딩')
        guide = [bexp4, bexp2, exp24, exp25, exp45, '제1주차빌딩 쪽으로 가세요'];

      else if(end == '장례식장')
        guide = [bexp4, bexp2, exp24, exp25, exp45, '제1주차빌딩 쪽으로 가세요', '장례식장 쪽으로 가세요'];

      else if(end == '병원정문')
        guide = [bexp4, bexp2, bexp1, exp36, exp48];

      else if(end == '동문')
        guide = [bexp4, bexp2, exp24, exp25, exp45, '제1주차빌딩 쪽으로 가세요', '장례식장 쪽으로 가세요', '동문 쪽으로 가세요'];

      else if(end == '권역외상센터')
        guide = [bexp4, bexp2, bexp1, exp36, exp48, exp50, exp52];

      else if(end == '남문')
        guide = [bexp4, bexp2, bexp1, exp36];
    }

    else if(start == '북문')
    {
      if(end == '정문')
        guide = [bexp41, bexp18, bexp22, bexp10, bexp4, bexp2, bexp1];
    }

    //guide 리스트 내의 모든 원소(길 안내 문구)들을 data 리스트에 추가합니다.
    for(int i=0; i<guide.length; i++)
    {
      var road = guide[i];
      data.add(road);
    }

    var endpoint = '도착지: $end';//도착지로 무엇을 입력 받았는지에 대한 설명을 endpoint에 넘겨줍니다.

    data.add(endpoint);//'도착지: ~'을 data 리스트에 추가합니다.
  }

  Widget buildStaticListView(){
    cal();//위의 함수 실행(출발지, 거쳐야 하는 길 안내, 도착지를 data 리스트에 넣는 과정)

    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int i){
          return ListTile(
            //data 리스트 내의 원소 개수 만큼 목록을 만듭니다.
            title: Text(data[i],
                style: TextStyle(
                  fontSize: 15,
                )),
            //data 리스트 내의 원소 개수 만큼 '사진' 버튼을 만듭니다.
            trailing: Column(
              children: [
                // new PicButton(),
              ],
            ),
          );
        }
    );
  }

  //출발지, 도착지를 입력한 다음 넘어지는 페이지의 title을 '조약돌'이라 설정
  Widget build(BuildContext context){
    return new MaterialApp(
        title: '조약돌',
        theme: new ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text("조약돌", style: new TextStyle(color: Colors.black,)),
          ),
          body: buildStaticListView(),//다음 페이지에서 위에서 만든 목록을 제시
        )
    );
  }
}