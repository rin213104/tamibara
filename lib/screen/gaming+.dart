import 'package:flutter/material.dart';
import 'dart:math';
import '../const/colors.dart';

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
            fontSize: 18,
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
  String _currentCharacter = '카돌';
  String _currentCharacterImage = 'assets/images/카돌알.png';
  String _selectedButton = 'assets/images/카돌알.png';
  bool _isCharacterSelection = true;
  String _currentSentence = '안녕!';

  final Map<String, List<String>> _characterSentences = {
    '카돌': [
      '좋은 아침.',
      '…',
      '산책?',
      '잘 잤나?',
      '행복해.',
      '할 수 있어.',
      '힘내.',
      '완벽해.',
      '좋네.',
      '파이팅.',
    ],
    '곰돌': [
      '오늘도 좋은 하루 보내자~',
      '간지러워!',
      '같이 공부할래?',
      '날씨가 좋아! 같이 산책할까?',
      '잘 잤어?',
      '귀여운 미소 자주 보여 줘!',
      '너랑 있으면 언제든 힘이 나.',
      '나랑 늘 행복하자!',
      '힘들 땐 내가 옆에 있을게.',
      '너랑 함께한 날은 항상 완벽해!',
      '너랑 있는 게 너무 좋아!',
      '오늘도 힘내 보자!',
      '우리가 함께라면 무적이야!',
      '날 웃게 해 주는 건 너야~',
      '오늘도 우리는 최강!',
    ],
    '냥돌': [
      '어이, 늦잠 자지 말라고. -_-',
      '뭐야, 간지럽히지 마!',
      '공부가 어려워? 내가 봐 줘?',
      '날씨 좋긴 하네.',
      '잘 잤냐?',
      '뭐, 그 미소… 나쁘진 않네. -_-^',
      '너랑 있으면… 뭐, 나쁘진 않아.',
      '힘들면 말해. 도와줄지도?',
      '오늘도 힘내든가.',
      '우리? 뭐, 무적일지도.',
      '넌 가끔 웃기다니까.',
      '너만 잘하면 우린 최강일지도?',
      '좀 더 웃어 봐. 그래, 그렇게.',
      '제법 기특한데.',
      '오늘은 좀 즐겁달까.',
    ],
  };

  final Map<String, Map<String, int>> _characterStats = {
    '카돌': {'growth': 0, 'intimacy': 30, 'stage': 0, 'totalGrowth': -23000},
    '곰돌': {'growth': 0, 'intimacy': 50, 'stage': 0, 'totalGrowth': -23000},
    '냥돌': {'growth': 0, 'intimacy': 70, 'stage': 0, 'totalGrowth': -23000},
  };
  void _increaseGrowth() {
    setState(() {
      final stats = _characterStats[_currentCharacter]!;
      final currentStage = stats['stage']!;
      final currentGrowth = stats['growth']!;
      final totalGrowth = stats['totalGrowth']!;

      stats['totalGrowth'] = totalGrowth + 1000;

      if (currentStage < 3) {
        final requiredGrowth = _growthRequirements[currentStage]!;
        if (currentGrowth + 1000 >= requiredGrowth) {
          stats['growth'] = 0;
          stats['stage'] = currentStage + 1;

          String newImagePath;
          if (_currentCharacter == '카돌') {
            newImagePath = 'assets/images/카돌${_stageSuffix(currentStage + 1)}.png';
          } else if (_currentCharacter == '곰돌') {
            newImagePath = 'assets/images/곰돌${_stageSuffix(currentStage + 1)}.png';
          } else {
            newImagePath = 'assets/images/냥돌${_stageSuffix(currentStage + 1)}.png';
          }
          _updateCharacterImage(_currentCharacter, newImagePath);
        } else {
          stats['growth'] = currentGrowth + 1000;
        }
      } else {
        stats['growth'] = currentGrowth + 1000;
      }
    });
  }
  final Map<int, int> _growthRequirements = {
    0: 3600,
    1: 7200,
    2: 10800,
  };

  void _updateCharacterImage(String character, String newImagePath) {
    setState(() {
      _currentCharacter = character;
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



  String _stageSuffix(int stage) {
    switch (stage) {
      case 0:
        return '알';
      case 1:
        return '아기';
      case 2:
        return '어린이';
      case 3:
      default:
        return '';
    }
  }
  Widget _buildLinearProgressIndicator(int currentStage, int growth, int requiredGrowth, int totalGrowth) {
    if (currentStage < 3) {
      return SizedBox(
        width: 200,
        child: LinearProgressIndicator(
          value: growth / requiredGrowth,
          minHeight: 7,
          borderRadius: BorderRadius.circular(10),
          backgroundColor: Color(0xFFAFCBBF),
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF5B9A90)),
        ),
      );
    } else {
      return SizedBox(
        width: 200,
        child: LinearProgressIndicator(
          value: totalGrowth / (totalGrowth + 1),
          minHeight: 7,
          borderRadius: BorderRadius.circular(10),
          backgroundColor: Color(0xFFAFCBBF),
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF5B9A90)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final stats = _characterStats[_currentCharacter]!;
    final growth = stats['growth']!;
    final totalGrowth = stats['totalGrowth']!;
    final currentStage = stats['stage']!;
    final requiredGrowth = _growthRequirements[currentStage] ?? 1;
    final growthPercentage = (growth / requiredGrowth) * 100;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR, // 앱 상단바 색상 설정
        title: Text('03. 28. THU'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: PRIMARY_COLOR, // 바디 배경색 설정
        child: Column(
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
                            size: Size(30, 20),
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
                        height: 200,
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: _buildLinearProgressIndicator(currentStage, growth, requiredGrowth, totalGrowth),
                    ),
                    SizedBox(height: 10),
                    Text(
                      currentStage < 3 ? '${growthPercentage.toStringAsFixed(2)}%' : '성장도: $totalGrowth',
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
                          _buildCircleButton('assets/images/love.png'),
                          _buildCircleButton('assets/images/chara.png'),
                          _buildCircleButton('assets/images/plus.png'),
                          _buildCircleButton('assets/images/increase.png', _increaseGrowth), //성장도 오르는 버튼
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
                            : _buildCharacterStats(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }


  Widget _buildCircleButton(String imagePath, [VoidCallback? onTap]) {
    return InkWell(
      onTap: onTap ?? () {
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
            _buildImageButton('assets/images/${imagePrefix}알.png', '알', characterName, 0),
            _buildImageButton('assets/images/${imagePrefix}아기.png', '아기', characterName, 1),
            _buildImageButton('assets/images/${imagePrefix}어린이.png', '어린이', characterName, 2),
            _buildImageButton('assets/images/${imagePrefix}.png', '어른', characterName, 3),
          ],
        ),
      ],
    );
  }

  Widget _buildImageButton(String imagePath, String label, String characterName, int stage) {
    bool isSelected = _selectedButton == imagePath;
    bool isUnlocked = _characterStats[characterName]!['stage']! >= stage;

    return Column(
      children: [
        InkWell(
          onTap: () {
            if (isUnlocked) {
              _updateCharacterImage(characterName, imagePath);
            }
          },
          borderRadius: BorderRadius.circular(50),
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: isSelected ? Color(0xFFA2D2C7) : Color(0xFFD9D9D9),
              shape: BoxShape.circle,
              border: Border.all(
                color: isUnlocked ? Colors.transparent : Colors.grey,
                width: isUnlocked ? 0 : 2,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                  opacity: isUnlocked ? 1.0 : 0.5,
                  child: Image.asset(
                    imagePath,
                    width: 40,
                    height: 40,
                  ),
                ),
                if (isSelected && isUnlocked)
                  Icon(
                    Icons.check,
                    color: Colors.black,
                    size: 30,
                  ),
                if (!isUnlocked)
                  Icon(
                    Icons.lock,
                    color: Colors.black54,
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
    final stats = _characterStats[_currentCharacter]!;
    final growth = stats['growth']!;
    final totalGrowth = stats['totalGrowth']!;
    final intimacy = stats['intimacy']!;
    final currentStage = stats['stage']!;
    final requiredGrowth = _growthRequirements[currentStage] ?? 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '캐릭터 이름 | $_currentCharacter',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 10),
        Text(
          currentStage < 3 ? '성장도 | $growth / $requiredGrowth XP (${_stageSuffix(currentStage)})' : '총 성장도 | $totalGrowth',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        SizedBox(
          width: 250,
          child: LinearProgressIndicator(
            value: currentStage < 3 ? growth / requiredGrowth : totalGrowth / (totalGrowth + 1),
            minHeight: 7,
            borderRadius: BorderRadius.circular(10),
            backgroundColor: Color(0xFFAFCBBF),
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF5B9A90)),
          ),
        ),
        SizedBox(height: 10),
        Text(
          '친밀도 | $intimacy / 100 (100%)',
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