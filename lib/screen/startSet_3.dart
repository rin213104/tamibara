import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screen/welcome.dart';

void main() {
  runApp(CharacterSelect());
}

class CharacterSelect extends StatefulWidget {
  @override
  _CharacterSelectState createState() => _CharacterSelectState();
}

class _CharacterSelectState extends State<CharacterSelect> {
  String? selectedImage; // 선택된 이미지

  final List<String> imagePaths = [
    'assets/images/카피바라 성년.png',
    'assets/images/곰돌기본채색.png',
    'assets/images/냥돌기본채색.png',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              color: Color(0xFFD3F3EF),
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
                    width: 350,
                    height: 90,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 10),
                  buildClickableImageWidget(imagePaths[0]),
                  SizedBox(height: 20),
                  buildClickableImageWidget(imagePaths[1]),
                  SizedBox(height: 15),
                  buildClickableImageWidget(imagePaths[2]),
                ],
              ),
            ),
            if (selectedImage != null)
              Positioned(
                bottom: 60,
                right: 40,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(0xFFAFCBBF),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    iconSize: 30,
                    icon: Icon(Icons.arrow_forward),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
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
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildClickableImageWidget(String imagePath) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = imagePath;
        });
      },
      child: Stack(
        children: [
          Opacity(
            opacity: selectedImage == imagePath ? 0.5 : 1.0,
            child: Image.asset(
              imagePath,
              width: 120,
              height: 120,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}