import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screen/welcome.dart';
import '../const/colors.dart';

void main() {
  runApp(CharacterSelect());
}

class CharacterSelect extends StatefulWidget {
  @override
  _CharacterSelectState createState() => _CharacterSelectState();
}

class _CharacterSelectState extends State<CharacterSelect> {
  String? selectedImage; // 선택된 이미지

  final List<String> imagePaths = [ // 이미지 경로 저장
    'assets/images/카피바라 성년.png',
    'assets/images/곰돌기본채색.png',
    'assets/images/냥돌기본채색.png',
  ];

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: PRIMARY_COLOR,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, screenHeight * 0.1, 0, 0),
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
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, screenHeight * 0.03),
                  child: Text(
                    "캐릭터를 선택해 주세요!",
                    style: TextStyle(
                      color: Color(0xFF6F867C),
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Image.asset(
                  'assets/images/chap03.png',
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.1,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: screenHeight * 0.03),
                buildClickableImageWidget(imagePaths[0], screenWidth, screenHeight),
                SizedBox(height: screenHeight * 0.02),
                buildClickableImageWidget(imagePaths[1], screenWidth, screenHeight),
                SizedBox(height: screenHeight * 0.015),
                buildClickableImageWidget(imagePaths[2], screenWidth, screenHeight),
              ],
            ),
          ),
        ),
        floatingActionButton: selectedImage != null
            ? Positioned(
          bottom: screenHeight * 0.05,
          right: screenWidth * 0.05,
          child: FloatingActionButton(
            backgroundColor: Color(0xFFAFCBBF),
            child: Icon(Icons.arrow_forward, color: Colors.white, size: screenWidth * 0.08),
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder( // 선택된 이미지 경로를 인자로 전달
                  pageBuilder: (context, animation, secondaryAnimation) => WelcomeScreen(selectedImage: selectedImage),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    var begin = Offset(1.0, 0.0);
                    var end = Offset.zero;
                    var curve = Curves.ease;
                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                ),
              );
            },
          ),
        )
            : null,
      ),
    );
  }

  Widget buildClickableImageWidget(String imagePath, double screenWidth, double screenHeight) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = imagePath; // 이미지 경로 저장
        });
      },
      child: Stack(
        children: [
          Opacity(
            opacity: selectedImage == imagePath ? 0.5 : 1.0, // 선택되면 투명도 절반 감소
            child: Image.asset(
              imagePath,
              width: screenWidth * 0.3,
              height: screenHeight * 0.15,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}