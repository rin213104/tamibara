import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../const/colors.dart';
import '../screen/goal.dart';
import 'package:provider/provider.dart';
import '../action/selectedImageModel.dart';
import '../screen/to_do_list_screen.dart';

/*
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SelectedImageModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WelcomeScreen(),
      ),
    );
  }
}

 */

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final selectedImage = Provider.of<SelectedImageModel>(context).selectedImage;

    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

    return Scaffold(
      body: Container(
        color: PRIMARY_COLOR,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, screenHeight * 0.15, 0, 0),
                      child: Text(
                        '준비가 끝났습니다!',
                        style: TextStyle(
                          color: TEXT_COLOR,
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, screenHeight * 0.001),
                      child: Text(
                        '이제 목표를 향해 달려 볼까요?',
                        style: TextStyle(
                          color: TEXT_COLOR,
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.1),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      child: selectedImage != null
                          ? Image.asset(
                        Provider.of<SelectedImageModel>(context).selectedImage!,
                        width: screenWidth * 0.6,
                        height: screenWidth * 0.6,
                      )
                          : SizedBox(), // 선택된 이미지가 없으면 빈 SizedBox 반환
                    ),
                    SizedBox(height: screenHeight * 0.06),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ToDoScreen(),
                          ),
                        );
                      },
                      child: Text(
                        '시작하기',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // 버튼 패딩 조정
                        minimumSize: Size(150, 50), // 버튼 최소 크기 설정
                        backgroundColor: Color(0xFF5B9A90),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}