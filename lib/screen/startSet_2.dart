import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screen/startSet_3.dart';


void main() {
  runApp(NickNameScreen());
}

class NickNameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: Color(0xFFD3F3EF),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 70, 150, 0),
                        child: Text(
                          "어떤 이름으로",
                          style: TextStyle(
                            color: Color(0xFF6F867C),
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 75, 0),
                        child: Text(
                          "불러 드리면 될까요?",
                          style: TextStyle(
                            color: Color(0xFF6F867C),
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Image.asset(
                          'assets/images/스크린샷 2024-05-03 08.59.44.png',
                          width: 350,
                          height: 90,
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: 350,
                          height: 60,
                          child: NickNameBox(),
                        ),
                        SizedBox(height: 350), // 위 아래 여백 조절
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
  _NickNameBoxState createState() => _NickNameBoxState(); // 상태 관리용 State 클래스 변경
}

// 닉네임 박스 상태
class _NickNameBoxState extends State<NickNameBox> { // 상태 관리용 State 클래스 이름 변경
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _showPlaceHolder = true;
  bool _isNameAvailable = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _showPlaceHolder = !_focusNode.hasFocus;
      });
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
    return Container(
          decoration: BoxDecoration(
          color: Color(0xFFF7FFFD),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: TextFormField(
          controller: _textController,
          focusNode: _focusNode,
          textAlign: TextAlign.left,
          decoration: InputDecoration(
          contentPadding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
          hintText: _showPlaceHolder ? '닉네임을 입력하세요' : null,
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: Color(0xFFA1A1A1),
            fontSize: 15,
            ),
          ),
        ),
    );
  }
}

/* // 닉네임 중복 메시지 출력 > 수정 필요, 닉네임 박스 하단에 위치시키고 싶은데 박스 안에 출력됨
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
    if (textController != null && textController!.text.isNotEmpty)
      return Container(
        padding: EdgeInsets.all(8),
        child: Text(
          isNameAvailable ? '사용 가능한 닉네임입니다' : '중복된 닉네임입니다',
          style: TextStyle(color: isNameAvailable ? Colors.green : Colors.red),
        ),
      );
    else
      return SizedBox.shrink();
  }
} */

bool isDuplicateNickName(String inputNickName) {
  // 로직 작성해야 함 > 데이터베이스에서 확인
  return inputNickName == 'test';
}