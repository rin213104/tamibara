import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import '../const/colors.dart'; // Ensure this import is correct and the file exists
import '../database/local_exp.dart';
import '../action/gaming_data_model.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GamingDataModel(),
      child: MyApp(),
    ),
  );
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

class _CharacterScreenState extends State<CharacterScreen> with TickerProviderStateMixin {
  String _currentCharacter = '카돌';
  String _currentCharacterImage = 'assets/images/카돌알.png';
  String _currentSentence = '안녕!';

  bool _showCharacterSelection = false;
  bool _showCharacterStats = false;

  //late double _experience;
  //final ExperienceStorage _storage = ExperienceStorage();


  @override
  void initState() {
    super.initState();
    //_loadExperience(); // initState에서 경험치를 로드합니다.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadExperience();
    });
    //_characterStats[_currentCharacter]!['growth'] = Provider.of<GamingDataModel>(context, listen: false).EXP;
  }

  void _loadExperience() async {
    await Provider.of<GamingDataModel>(context, listen: false).loadExperience();
    double exp = Provider.of<GamingDataModel>(context, listen: false).EXP;
    setState(() {
      _characterStats[_currentCharacter]!['growth'] = exp;
    });
  }
/*
  // 경험치를 로드하는 메서드
  void _loadExperience() async {
    double loadedExperience = await _storage.getExperience();
    setState(() {
      _experience = loadedExperience;
      _characterStats[_currentCharacter]!['growth'] = loadedExperience; // 경험치를 _characterStats에 저장합니다.
    });
  }

 */




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

  final Map<String, Map<String, double>> _characterStats = {
    '카돌': {'growth': 0, 'intimacy': 50, 'stage': 0, 'totalGrowth': 0},
    '곰돌': {'growth': 0, 'intimacy': 50, 'stage': 0, 'totalGrowth': 0},
    '냥돌': {'growth': 0, 'intimacy': 50, 'stage': 0, 'totalGrowth': 0},
  };

  final Map<int, double> _growthRequirements = {
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

  void _showHeartAnimation(BuildContext context) {
    final RenderBox buttonRenderBox = context.findRenderObject() as RenderBox;
    final buttonPosition = buttonRenderBox.localToGlobal(Offset.zero);
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: buttonPosition.dy - 50,
        left: buttonPosition.dx + buttonRenderBox.size.width / 2 - 25,
        child: HeartAnimation(),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('MM. dd. EEE').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: Text(
          formattedDate,
          style: TextStyle(
            fontSize: 22,
            color: Color(0xFF4D6058),
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
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
                  if (_showCharacterSelection || _showCharacterStats)
                    SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Builder(
                        builder: (context) => _buildCircleButton('assets/images/love.png', () => _showHeartAnimation(context)),
                      ),
                      _buildCircleButton('assets/images/chara.png', _toggleCharacterSelection),
                      _buildCircleButton('assets/images/plus.png', _toggleCharacterStats),
                    ],
                  ),
                  if (!(_showCharacterSelection || _showCharacterStats))
                    SizedBox(height: 30),
                ],
              ),
            ),
            _showCharacterSelection || _showCharacterStats
                ? SizedBox( // Flexible 대신 SizedBox 사용
              height: MediaQuery.of(context).size.height * 0.3, // 화면의 60% 높이로 설정
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
            )
                : SizedBox.shrink(),

          ],
        ),
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
        //SizedBox(height: 100),
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
  final Map<String, Map<String, double>> characterStats;
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
              currentStage < 3 ? '성장도 | $growth / $requiredGrowth XP (${_stageSuffix(currentStage.toInt())})' : '총 성장도 | $totalGrowth',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            SizedBox(
              width: 200,
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

class HeartAnimation extends StatefulWidget {
  @override
  _HeartAnimationState createState() => _HeartAnimationState();
}

class _HeartAnimationState extends State<HeartAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: -150).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: child,
        );
      },
      child: Icon(
        Icons.favorite,
        color: Colors.red,
        size: 50,
      ),
    );
  }
}