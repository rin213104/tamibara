import 'package:flutter/material.dart';

class gameSlide extends StatelessWidget {
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
  String _currentCharacterImage = 'assets/images/capybara.png';
  String _selectedButton = '';
  bool _isCharacterSelection = true;

  void _updateCharacterImage(String newImagePath) {
    setState(() {
      _currentCharacterImage = newImagePath;
      _selectedButton = newImagePath;
    });
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
                          '안녕!',
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
                  Image.asset(
                    _currentCharacterImage,
                    width: 200,
                    height: 280,
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
                            _buildCharacterSection('카피바라', 'capybara'),
                            Divider(
                              height: 30,
                              thickness: 2,
                              color: Color(0xFFB4B4B4),
                            ),
                            _buildCharacterSection('강아지', 'dog'),
                            Divider(
                              height: 30,
                              thickness: 2,
                              color: Color(0xFFB4B4B4),
                            ),
                            _buildCharacterSection('고양이', 'cat'),
                            Divider(
                              height: 30,
                              thickness: 2,
                              color: Color(0xFFB4B4B4),
                            ),
                            _buildCharacterSection('햄스터', 'hamster'),
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
            _buildImageButton('assets/images/${imagePrefix}_egg.png', '알'),
            _buildImageButton('assets/images/${imagePrefix}_baby.png', '아기'),
            _buildImageButton('assets/images/${imagePrefix}_child.png', '어린이'),
            _buildImageButton('assets/images/${imagePrefix}_adult.png', '어른'),
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