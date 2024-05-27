import 'package:asd/action/nickNameProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:asd/action/nickNameProvider.dart';
import '../screen/startSet_3.dart';
import '../const/colors.dart';


class NickNameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: PRIMARY_COLOR,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, screenHeight * 0.1, 0, 0),
                          child: Text(
                            "어떤 이름으로",
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
                            "불러 드리면 될까요?",
                            style: TextStyle(
                              color: Color(0xFF6F867C),
                              fontSize: screenWidth * 0.06,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Image.asset(
                          'lib/images/chap02.png',
                          width: screenWidth * 0.8,
                          height: screenHeight * 0.1,
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        SizedBox(
                          width: screenWidth * 0.8,
                          height: screenHeight * 0.07,
                          child: NickNameBox(),
                        ),
                        SizedBox(height: screenHeight * 0.35),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NickNameBox extends StatefulWidget {
  @override
  _NickNameBoxState createState() => _NickNameBoxState();
}

class _NickNameBoxState extends State<NickNameBox> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFF7FFFD),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
            child: TextFormField(
              controller: _textController,
              focusNode: _focusNode,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                contentPadding: EdgeInsetsDirectional.fromSTEB(screenWidth * 0.03, 0, 0, 0),
                hintText: _focusNode.hasFocus ? null : '닉네임을 입력하세요',
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Color(0xFFA1A1A1),
                  fontSize: screenWidth * 0.04,
                ),
              ),
              style: TextStyle(
                fontSize: screenWidth * 0.04,
              ),
            ),
          ),
        ),
        if (_textController.text.isNotEmpty)
          IconButton(
            icon: Icon(Icons.arrow_forward),
            iconSize: screenWidth * 0.06,
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                context.read<nickNameProvider>().setNickname(_textController.text);
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => CharacterSelect(),
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
              }
            },
          ),
      ],
    );
  }
}


// 닉네임 중복 메시지 출력 > 수정 필요, 닉네임 박스 하단에 위치시키고 싶은데 박스 안에 출력됨
class NickNameValidationMessage extends StatelessWidget {
  final bool isNameAvailable;
  final TextEditingController? textController;

  const NickNameValidationMessage({
    Key? key,
    required this.isNameAvailable,
    this.textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    if (textController != null && textController!.text.isNotEmpty)
      return Container(
        padding: EdgeInsets.all(screenWidth * 0.02),
        child: Text(
          isNameAvailable ? '사용 가능한 닉네임입니다' : '중복된 닉네임입니다',
          style: TextStyle(
            color: isNameAvailable ? Colors.green : Colors.red,
            fontSize: screenWidth * 0.04,
          ),
        ),
      );
    else
      return SizedBox.shrink();
  }
}

bool isDuplicateNickName(String inputNickName) {
  // 로직 작성해야 함 > 데이터베이스에서 확인
  return inputNickName == 'test';
}