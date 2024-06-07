import 'package:flutter/material.dart';
import 'dart:math';

import 'package:untitled1/const/colors.dart'; // Ensure this import is correct and the file exists

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
  String _currentCharacter = '카돌';
  String _currentCharacterImage = 'assets/images/카돌알.png';
  String _currentSentence = '안녕!';

  bool _showCharacterSelection = false;
  bool _showCharacterStats = false;

  final Map<String, List<String>> _characterSentences = {
    '카돌': ['안녕!', '반가워!', '잘 지내?'],
    '곰돌': ['안녕하세요!', '반갑습니다!', '오늘도 좋은 하루!'],
    '냥돌': ['야옹!', '안냥!', '냥냥!'],
  };

  final Map<String, Map<String, int>> _characterStats = {
    '카돌': {'growth': 0, 'intimacy': 30, 'stage': 0, 'totalGrowth': 0},
    '곰돌': {'growth': 0, 'intimacy': 50, 'stage': 0, 'totalGrowth': 0},
    '냥돌': {'growth': 0, 'intimacy': 70, 'stage': 0, 'totalGrowth': 0},
  };

  final Map<int, int> _growthRequirements = {
    0: 3600,
    1: 7200,
    2: 10800,
  };

  void _updateCharacterImage(String character, String newImagePath) {
    setState(() {
      _currentCharacter = character;
      _currentCharacterImage = newImagePath;
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

  void _toggleCharacterSelection() {
    setState(() {
      _showCharacterSelection = !_showCharacterSelection;
      _showCharacterStats = false; // 캐릭터 선택창이 열릴 때 캐릭터 상태창을 닫음
    });
  }

  void _toggleCharacterStats() {
    setState(() {
      _showCharacterStats = !_showCharacterStats;
      _showCharacterSelection = false; // 캐릭터 상태창이 열릴 때 캐릭터 선택창을 닫음
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
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
                    child: _buildLinearProgressIndicator(),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${(_characterStats[_currentCharacter]!['growth']! / _growthRequirements[_characterStats[_currentCharacter]!['stage']!]! * 100).toStringAsFixed(2)}%',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: _showCharacterSelection || _showCharacterStats ? Colors.white : Colors.transparent,
            child: Column(
              children: [
                SizedBox(height: 20), // 버튼 위에 빈 공간 추가
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCircleButton('assets/images/love.png', () {}),
                    _buildCircleButton('assets/images/chara.png', _toggleCharacterSelection),
                    _buildCircleButton('assets/images/plus.png', _toggleCharacterStats),
                  ],
                ),
                SizedBox(height: 10), // Add spacing between buttons and below area
              ],
            ),
          ),
          _showCharacterSelection || _showCharacterStats
              ? Flexible(
            child: FractionallySizedBox(
              heightFactor: 1.0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_showCharacterSelection)
                      Expanded(
                        child: CharacterSelectionScreen(onCharacterSelected: _updateCharacterImage),
                      ),
                    if (_showCharacterStats)
                      Expanded(
                        child: CharacterStatsScreen(
                          characterStats: _characterStats,
                          currentCharacter: _currentCharacter,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          )
              : SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildCircleButton(String imagePath, [VoidCallback? onTap]) {
    final bool isSelected = (_showCharacterSelection && imagePath.contains('chara')) ||
        (_showCharacterStats && imagePath.contains('plus'));

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFAED8CE) : (_showCharacterSelection || _showCharacterStats) ? Color(0xFFD5E7E0) : Color(0xFFAFCBBF),
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

  Widget _buildLinearProgressIndicator() {
    final stats = _characterStats[_currentCharacter]!;
    final growth = stats['growth']!;
    final totalGrowth = stats['totalGrowth']!;
    final currentStage = stats['stage']!;
    final requiredGrowth = _growthRequirements[currentStage] ?? 1;
    return SizedBox(
      width: 200,
      child: LinearProgressIndicator(
        value: currentStage < 3 ? growth / requiredGrowth : totalGrowth / (totalGrowth + 1),
        minHeight: 7,
        borderRadius: BorderRadius.circular(10),
        backgroundColor: Color(0xFFAFCBBF),
        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF5B9A90)),
      ),
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
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class CharacterSelectionScreen extends StatelessWidget {
  final Function(String, String) onCharacterSelected;

  CharacterSelectionScreen({required this.onCharacterSelected});

  final Map<String, Map<String, int>> _characterStats = {
    '카돌': {'stage': 0},
    '곰돌': {'stage': 0},
    '냥돌': {'stage': 0},
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            height: 30,
            thickness: 2,
            color: Color(0xFFB4B4B4),
          ),
          _buildCharacterSection(context, '카돌', '카돌'),
          Divider(
            height: 30,
            thickness: 2,
            color: Color(0xFFB4B4B4),
          ),
          _buildCharacterSection(context, '곰돌', '곰돌'),
          Divider(
            height: 30,
            thickness: 2,
            color: Color(0xFFB4B4B4),
          ),
          _buildCharacterSection(context, '냥돌', '냥돌'),
        ],
      ),
    );
  }

  Widget _buildCharacterSection(BuildContext context, String characterName, String imagePrefix) {
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
            _buildImageButton(context, 'assets/images/${imagePrefix}알.png', '알', characterName, 0),
            _buildImageButton(context, 'assets/images/${imagePrefix}아기.png', '아기', characterName, 1),
            _buildImageButton(context, 'assets/images/${imagePrefix}어린이.png', '어린이', characterName, 2),
            _buildImageButton(context, 'assets/images/${imagePrefix}.png', '어른', characterName, 3),
          ],
        ),
      ],
    );
  }

  Widget _buildImageButton(BuildContext context, String imagePath, String label, String characterName, int stage) {
    final bool isUnlocked = _characterStats[characterName]!['stage']! >= stage;

    return Column(
      children: [
        InkWell(
          onTap: () {
            if (isUnlocked) {
              onCharacterSelected(characterName, imagePath);
            }
          },
          borderRadius: BorderRadius.circular(50),
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Color(0xFFD9D9D9),
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
}

class CharacterStatsScreen extends StatelessWidget {
  final Map<String, Map<String, int>> characterStats;
  final String currentCharacter;

  CharacterStatsScreen({required this.characterStats, required this.currentCharacter});

  final Map<int, int> _growthRequirements = {
    0: 3600,
    1: 7200,
    2: 10800,
  };

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

  @override
  Widget build(BuildContext context) {
    final stats = characterStats[currentCharacter]!;
    final growth = stats['growth']!;
    final totalGrowth = stats['totalGrowth']!;
    final intimacy = stats['intimacy']!;
    final currentStage = stats['stage']!;
    final requiredGrowth = _growthRequirements[currentStage] ?? 1;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              height: 30,
              thickness: 2,
              color: Color(0xFFB4B4B4),
            ),
            Text(
              '캐릭터 이름 | $currentCharacter',
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
              width: MediaQuery.of(context).size.width, // 가득 채우기
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
        ),
      ),
    );
  }
}