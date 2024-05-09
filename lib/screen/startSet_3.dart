import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(CharacterSelect());
}

class CharacterSelect extends StatefulWidget {
  @override
  _CharacterSelectState createState() => _CharacterSelectState();
}

class _CharacterSelectState extends State<CharacterSelect> {
  String? selectedImage;

  // 이미지들의 경로 리스트 정의
  final List<String> imagePaths = [
    'assets/images/카피바라 성년.png',
    'assets/images/곰돌 (1).png',
    'assets/images/냥돌 (1).png',
  ];

  // 이미지들의 효과를 저장하는 맵을 정의
  final Map<String, Color?> selectedImageEffects = {};

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: Color(0xFFD3F3EF), // 전체 배경 색상 지정
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 30, 155, 0),
               child: Text(
                "목표를 함께할",
                style: TextStyle(
                  color: Color(0xFF6F867C),
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 35, 0),
              child: Text(
                "캐릭터를 선택해 주세요!",
                style: TextStyle(
                  color: Color(0xFF6F867C),
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Image.asset(
                'assets/images/스크린샷 2024-05-03 20.27.26.png',
                width: 350, // 이미지1의 가로 크기
                height: 90, // 이미지1의 세로 크기
                fit: BoxFit.contain, // 이미지가 위젯 영역에 맞게 조절되도록 설정
              ),
              SizedBox(height: 10), // 이미지1과 이미지2,3,4 간격 조정
              buildClickableImageWidget('assets/images/카피바라 성년.png'),
              SizedBox(height: 20), // 이미지2와 이미지3,4 간격 조정
              buildClickableImageWidget('assets/images/곰돌기본채색.png'),
              SizedBox(height: 15), // 이미지3와 이미지4 간격 조정
              buildClickableImageWidget('assets/images/냥돌기본채색.png'),
            ],
          ),
        ),
      ),
    );
  }

  // 이미지 클릭 시 효과 주기 > 로직 수정 필요...
  Widget buildClickableImageWidget(String imagePath) {
    bool isSelected = selectedImage == imagePath;
    bool isAnyImageSelected = selectedImage != null;

    ColorFilter? colorFilter;
    if (!isSelected && isAnyImageSelected) {
      // 이미 선택된 이미지가 없는 경우에만 흐리게 표시
      colorFilter = ColorFilter.mode(Colors.grey.withOpacity(0.5), BlendMode.srcOver);
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          if (selectedImage == imagePath) {
            selectedImage = null; // 이미 선택된 이미지를 다시 선택하면 선택 해제
          } else {
            selectedImage = imagePath; // 새로운 이미지 선택
          }
        });
      },
        // child: ColorFiltered(
         // colorFilter: colorFilter, // 널 값 때문에 오류... 해결 못함
          child: Image.asset(
            imagePath,
            width: 120,
            height: 120,
            fit: BoxFit.contain,
        ),
      //),
    );
  }
}