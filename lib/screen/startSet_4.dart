import 'package:flutter/material.dart';
import '../const/colors.dart';
import '../screen/welcome.dart';

class CharacterDetail extends StatelessWidget {
  final String imagePath;
  final String description;

  CharacterDetail({required this.imagePath, required this.description});

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
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, screenHeight * 0.02),
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
                imagePath,
                width: screenWidth * 0.5,
                height: screenHeight * 0.4,
                fit: BoxFit.contain,
              ),
              SizedBox(height: screenHeight * 0.02),
              Container(
                padding: EdgeInsets.all(screenWidth * 0.05),
                decoration: BoxDecoration(
                  color: Color(0xFFB5E6D1).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  description,
                  style: TextStyle(
                    color: Color(0xFF4D6058),
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "뒤로",
                      style: TextStyle(
                        color: Color(0xFF5E5F60),
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => WelcomeScreen(selectedImage: imagePath),
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
                    child: Text(
                      "선택",
                      style: TextStyle(
                        color: Color(0xFF3A6CCC),
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}