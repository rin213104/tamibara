import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFD3F3EF),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFD3F3EF),
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
      home: CharacterScreen(),
    );
  }
}

class CharacterScreen extends StatefulWidget {
  @override
  _CharacterScreenState createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  String _currentCharacterImage = 'assets/images/카돌.png';
  String _selectedButton = '';
  bool _isCharacterSelection = true;
  String _currentSentence = '안녕!';

  final Map<String, List<String>> _characterSentences = {
    '카돌': [
      '카돌 문장 1',
      '카돌 문장 2',
      '카돌 문장 3',
      // Add more sentences for 카돌
    ],
    '곰돌': [
      '곰돌 문장 1',
      '곰돌 문장 2',
      '곰돌 문장 3',
      // Add more sentences for 곰돌
    ],
    '냥돌': [
      '냥돌 문장 1',
      '냥돌 문장 2',
      '냥돌 문장 3',
      // Add more sentences for 냥돌
    ],
  };

  void _updateCharacterImage(String newImagePath) {
    setState(() {
      _currentCharacterImage = newImagePath;
      _selectedButton = newImagePath;
      _updateSentence();
    });
  }

  void _updateSentence() {
    String character = '';
    if (_currentCharacterImage.contains('카돌')) {
      character = '카돌';
    } else if (_currentCharacterImage.contains('곰돌')) {
      character = '곰돌';
    } else if (_currentCharacterImage.contains('냥돌')) {
      character = '냥돌';
    }

    if (character.isNotEmpty) {
      final sentences = _characterSentences[character];
      setState(() {
        _currentSentence = sentences![Random().nextInt(sentences.length)];
      });
    }
  }

  void _showCharacterSelection() {
    setState(() {
      _isCharacterSelection = true;
    });
  }

  void _showCharacterStats() {
    setState(() {
      _isCharacterSelection = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('03. 28. THU'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          _currentSentence,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -15,
                        child: CustomPaint(
                          size: Size(30, 30),
                          painter: TrianglePainter(),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: _updateSentence,
                    child: Image.asset(
                      _currentCharacterImage,
                      width: 200,
                      height: 280,
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 200,
                    child: LinearProgressIndicator(
                      value: 0.6, //성장도 선그래프
                      minHeight: 7,
                      borderRadius: BorderRadius.circular(10),
                      backgroundColor: Color(0xFFAFCBBF),
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF5B9A90)),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '60%', //성장도 퍼센테이지
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: FractionallySizedBox(
              heightFactor: 1.0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildCircleButton('assets/images/love.png'), // love 버튼, 추후 추가 예정
                        _buildCircleButton('assets/images/chara.png'), // chara 버튼, 캐릭터를 변경할 수 있는 기능
                        _buildCircleButton('assets/images/plus.png'), // plus 버튼, 캐릭터의 성장도와 친밀도를 볼 수 있는 기능
                      ],
                    ),
                    SizedBox(height: 20),
                    Divider(
                      height: 30,
                      thickness: 2,
                      color: Color(0xFFB4B4B4),
                    ),
                    Expanded(
                      child: _isCharacterSelection
                          ? SingleChildScrollView(
                        // 캐릭터를 선택하여 변경할 수 있는 기능
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildCharacterSection('카돌', '카돌'),
                            Divider(
                              height: 30,
                              thickness: 2,
                              color: Color(0xFFB4B4B4),
                            ),
                            _buildCharacterSection('곰돌', '곰돌'),
                            Divider(
                              height: 30,
                              thickness: 2,
                              color: Color(0xFFB4B4B4),
                            ),
                            _buildCharacterSection('냥돌', '냥돌'),
                          ],
                        ),
                      )
                          : _buildCharacterStats(), // Show character stats if plus button is selected
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleButton(String imagePath) {
    return InkWell(
      onTap: () {
        if (imagePath == 'assets/images/plus.png') {
          _showCharacterStats();
        } else if (imagePath == 'assets/images/chara.png') {
          _showCharacterSelection();
        }
      },
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: Color(0xFFD5E7E0),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Image.asset(
            imagePath,
            width: 40,
            height: 40,
          ),
        ),
      ),
    );
  }

  Widget _buildCharacterSection(String characterName, String imagePrefix) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          characterName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildImageButton('assets/images/알.png', '알'),
            _buildImageButton('assets/images/${imagePrefix}아기.png', '아기'),
            _buildImageButton('assets/images/${imagePrefix}어린이.png', '어린이'),
            _buildImageButton('assets/images/${imagePrefix}.png', '어른'),
          ],
        ),
      ],
    );
  }

  Widget _buildImageButton(String imagePath, String label) {
    bool isSelected = _selectedButton == imagePath;
    return Column(
      children: [
        InkWell(
          onTap: () {
            _updateCharacterImage(imagePath);
          },
          borderRadius: BorderRadius.circular(50),
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: isSelected ? Color(0xFFA2D2C7) : Color(0xFFD9D9D9),
              shape: BoxShape.circle,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  imagePath,
                  width: 40,
                  height: 40,
                ),
                if (isSelected)
                  Icon(
                    Icons.check,
                    color: Colors.black,
                    size: 30,
                  ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(label),
      ],
    );
  }

  Widget _buildCharacterStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '캐릭터 이름 | 바돌',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 10),
        Text(
          '성장도 | 12000 / 20000 XP (성체)', //성장도 텍스트
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        SizedBox(
          width: 250,
          child: LinearProgressIndicator(
            value: 0.6, //성장도 선그래프
            minHeight: 7,
            borderRadius: BorderRadius.circular(10),
            backgroundColor: Color(0xFFAFCBBF),
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF5B9A90)),
          ),
        ),
        SizedBox(height: 10),
        Text(
          '친밀도 | 30 /100 (100%)',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 2, size.height);
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

