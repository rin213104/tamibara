import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screen/startSet_4.dart';
import '../const/colors.dart';
import '../action/selectedImageModel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(CharacterSelect());
}

class CharacterSelect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CharacterSelectPage(),
    );
  }
}

class CharacterSelectPage extends StatefulWidget {
  @override
  _CharacterSelectPageState createState() => _CharacterSelectPageState();
}

class _CharacterSelectPageState extends State<CharacterSelectPage> {
  final List<String> imagePaths = [
    'assets/images/capybara/카피바라성년.png',
    'assets/images/bear/곰돌기본채색.png',
    'assets/images/cat/냥돌기본채색.png',
  ];

  final List<String> descriptions = [
    "이름: 카돌\n특징: 선비 카피바라\n\n천년을 살았다는 전설의 동물. 무슨 생각을 하고 있는지 알기 어렵다. 과묵하지만 기분 변화가 표정에 잘 드러나는 편. 묵묵히 당신의 옆을 지키고 있을 것이다.",
    "이름: 곰돌\n특징: 다정한 곰\n\n몇 년을 살았는지 알 수 없는 곰이다. 곰의 형태를 하고 있지만 사실 살찐 햄스터일지도 모른다는 설이 돌고 있다. 하지만 누구보다 다정하게 당신을 응원해 줄 것이다.",
    "이름: 냥돌\n나이: 양아치 냥\n\n아직 어린 고등어 고양이. 힘든 길거리 생활 끝에 강인한 성격을 지니게 되었다. 쉽게 좌절하지 않는 편. 당신의 스파르타 동무가 되어 줄 것이다.",
  ];

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.1),
                child: Text(
                  "목표를 함께할",
                  style: TextStyle(
                    color: Color(0xFF6F867C),
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.03),
                child: Text(
                  "캐릭터를 선택해 주세요!",
                  style: TextStyle(
                    color: Color(0xFF6F867C),
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              buildClickableImageWidget(context, imagePaths[0], descriptions[0], screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.03),
              buildClickableImageWidget(context, imagePaths[1], descriptions[1], screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.03),
              buildClickableImageWidget(context, imagePaths[2], descriptions[2], screenWidth, screenHeight),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildClickableImageWidget(BuildContext context, String imagePath, String description, double screenWidth, double screenHeight) {
    return GestureDetector(
      onTap: () {
        Provider.of<SelectedImageModel>(context, listen: false).setSelectedImage(imagePath);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CharacterDetail(imagePath: imagePath, description: description),
          ),
        );
      },
      child: Center(
        child: Image.asset(
          imagePath,
          width: screenWidth * 0.4,
          height: screenHeight * 0.17,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
