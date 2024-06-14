import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math';
<<<<<<< HEAD
import '../action/gaming_data_model.dart';
import 'package:provider/provider.dart';
import '../widget/customToast.dart';
import '../action/selectedImageModel.dart';
=======
import 'gaming_data_model.dart';
import 'package:provider/provider.dart';
import '../widget/customToast.dart';
import 'selectedImageModel.dart';
import '../database/database_helper.dart';
import '../screen/to_do_list_screen.dart';
import '../action/gaming_data_model.dart';
>>>>>>> origin/rin213104

// 타이머 종료 시 토스트 알림 메시지 리스트
List<String> toastMessages = [
  '대단해요!\n목표 시간을 다 채웠어요',
  '멋져요!\n시간을 알차게 사용했어요',
  '잘했어요!\n목표 시간 달성',
  '축하합니다!\n목표 시간을 모두 채웠네요',
  '훌륭해요!\n목표 시간을 완수했어요',
  '우와!\n목표 시간을 다 채웠어요',
  '잘했어요!\n목표에 가까워졌어요',
  '멋져요!\n시간 관리를 잘했어요',
  '훌륭합니다!\n목표 시간을 모두 소화했어요',
  '대단해요!'
];

// 타이머 모델
class TimerModel extends ChangeNotifier {
  int maxSeconds = 3600; // 기본값: 3600초 (1시간)으로 설정
  int seconds = 0; // 남은 시간을 관리하는 변수
  int elapsedSeconds = 0; // 경과 시간을 관리하는 변수
  String? originalImage; // 원래 이미지 경로를 저장
  String? modifiedImage; // 변경된 이미지 경로를 저장
  bool isAnimating = false; // 광질 애니메이션 상태 추가
  bool isGemAnimating = false; // 보석 애니메이션 상태 추가
  bool isFirstImage = true; // 애니메이션 이미지를 번갈아가며 표시하기 위한 상태
  String stoneImage = 'assets/images/stone1.png'; // 바위 이미지 경로
  String? gemImage1; // 보석 이미지 1
  String? gemImage2; // 보석 이미지 2
<<<<<<< HEAD
=======
  String id = ''; // todocard id
>>>>>>> origin/rin213104

  Timer? _timer;
  Timer? _animationTimer;
  Timer? _gemAnimationTimer; // 보석 애니메이션 타이머
  BuildContext? _context; // context를 저장할 변수

<<<<<<< HEAD
=======
  final DatabaseHelper dbHelper = DatabaseHelper(); // 데이터베이스 헬퍼 인스턴스 추가

>>>>>>> origin/rin213104
  void setMaxSeconds(int newMaxSeconds) {
    maxSeconds = newMaxSeconds;
    seconds = newMaxSeconds;
    elapsedSeconds = 0; // 경과 시간을 초기화
    notifyListeners();
  }

<<<<<<< HEAD
=======
  // 원본 캐릭터 이미지 저장
  void setOriginalImage(String imagePath) {
    originalImage = imagePath;
    notifyListeners();
  }

>>>>>>> origin/rin213104
  // context를 저장할 변수
  void setContext(BuildContext context) {
    _context = context;
    // context를 설정할 때 SelectedImageModel에서 선택된 이미지를 가져옵니다.
    final selectedImageModel = Provider.of<SelectedImageModel>(_context!, listen: false);
<<<<<<< HEAD
    setOriginalImage(selectedImageModel.selectedImage!);
=======
    if (selectedImageModel.selectedImage != null) {
      setOriginalImage(selectedImageModel.selectedImage!);
    }
  }

  // todocard의 타이머 시간
  void setDurationFromToDoCard(int durationSeconds, String tempid) {
    maxSeconds = durationSeconds;
    seconds = durationSeconds;
    elapsedSeconds = 0; // 경과 시간을 초기화
    id = tempid;
    notifyListeners();
>>>>>>> origin/rin213104
  }

  // 타이머 시작
  void startTimer({bool reset = true}) {
    if (_timer != null && _timer!.isActive) {
      modifiedImage = originalImage;
      _timer!.cancel();
    }
    if (reset) {
      seconds = maxSeconds;
      elapsedSeconds = 0; // 경과 시간을 초기화
      modifiedImage = originalImage; // 이미지 복원
    }

    stoneImage = 'assets/images/stone1.png'; // 타이머 시작 시 바위 이미지 초기화

    isAnimating = true; // 광질 애니메이션 시작
    isGemAnimating = false; // 보석 애니메이션 중지
    notifyListeners();

    // 애니메이션 타이머 시작
    _animationTimer = Timer.periodic(Duration(milliseconds: 500), (_) {
      isFirstImage = !isFirstImage;
      notifyListeners();
    });

    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (elapsedSeconds < maxSeconds) {
        seconds--;
        elapsedSeconds++;
        notifyListeners();
      } else {
        _timer!.cancel();
        onTimerEnd(); // 타이머 종료시 이미지 변경
      }
    });
    notifyListeners();
  }

  // 타이머 정지
  void stopTimer({bool reset = true}) {
    if (reset) {
      seconds = maxSeconds;
      elapsedSeconds = 0; // 경과 시간을 초기화
      modifiedImage = originalImage; // 이미지 복원
      stoneImage = 'assets/images/stone1.png'; // 타이머 정지 시 바위 이미지 초기화
    }
    _timer?.cancel();
    _animationTimer?.cancel(); // 애니메이션 타이머 정지
    _gemAnimationTimer?.cancel(); // 보석 애니메이션 타이머 정지
    isAnimating = false; // 광질 애니메이션 정지
    isGemAnimating = false; // 보석 애니메이션 정지
    notifyListeners();
  }

  // 타이머 포기
  void resetTimer() {
    seconds = maxSeconds;
    elapsedSeconds = 0; // 경과 시간을 초기화
    modifiedImage = originalImage; // 이미지 복원
    stoneImage = 'assets/images/stone1.png'; // 타이머 포기 시 바위 이미지 초기화
    _animationTimer?.cancel(); // 애니메이션 타이머 정지
    _gemAnimationTimer?.cancel(); // 보석 애니메이션 타이머 정지
    isAnimating = false; // 광질 애니메이션 정지
    isGemAnimating = false; // 보석 애니메이션 정지
    notifyListeners();
  }

  bool get isRunning => _timer != null && _timer!.isActive;

  // 타이머 종료 시 이미지 변경 함수
  void changeImageOnTimerEnd() {
    if (_context != null) {
      final selectedImageModel = Provider.of<SelectedImageModel>(_context!, listen: false);
<<<<<<< HEAD
      String? folder = selectedImageModel.selectedFolder;
=======
      String? folder = selectedImageModel.selectedFolder ?? selectedImageModel.selectedImage?.split('/')[2];
>>>>>>> origin/rin213104

      if (folder != null) {
        gemImage1 = 'assets/images/$folder/${folder}보석1.png';
        gemImage2 = 'assets/images/$folder/${folder}보석2.png';
        isGemAnimating = true; // 보석 애니메이션 시작

        // 보석 애니메이션 타이머 시작
        _gemAnimationTimer = Timer.periodic(Duration(milliseconds: 500), (_) {
          isFirstImage = !isFirstImage;
          notifyListeners();
        });
      }

      // modifiedImage 설정
      if (originalImage != null) {
        if (originalImage!.contains('곰돌기본채색.png')) {
          modifiedImage = 'assets/images/bear/곰돌신남채색.png';
        } else if (originalImage!.contains('카피바라성년.png')) {
          modifiedImage = 'assets/images/capybara/카피바라기쁨.png';
        } else if (originalImage!.contains('냥돌기본채색.png')) {
          modifiedImage = 'assets/images/cat/냥돌신남채색.png';
        }
      }

      stoneImage = 'assets/images/stone2.png'; // 타이머 종료 시 바위 이미지 변경
      notifyListeners();
    }
  }

<<<<<<< HEAD
=======
  void _ToDoDelete() {
    dbHelper.deleteTodo(id); // 데이터베이스에서 할 일 삭제
    ToDoScreen().ToDoList.remove(id);
    notifyListeners();
  }

>>>>>>> origin/rin213104

  // 타이머 종료 시
  void onTimerEnd() {
    _animationTimer?.cancel(); // 애니메이션 타이머 정지
    isAnimating = false; // 광질 애니메이션 정지

    if (!_timer!.isActive) { // 타이머가 이미 종료되었는지 확인
      changeImageOnTimerEnd();    // 타이머 완료 이미지 변경
      showRandomToastMessage();   // 토스트 알림
<<<<<<< HEAD
=======
      _ToDoDelete(); // 투두 삭제
      Provider.of<GamingDataModel>(_context!, listen: false).increaseCheckedEXP(); // 경험치 증가
>>>>>>> origin/rin213104
    }

    // notifyListeners();

    if (_context != null) {
      // 경험치 분당 +0.25씩 증가하는 함수
      Provider.of<GamingDataModel>(_context!, listen: false).increaseTimerEXP(maxSeconds);
    }
  }

  // 타이머 종료시 원본 이미지로 복원
  void resetImage() {
    modifiedImage = originalImage; // modifiedImage를 originalImage로 복원
    stoneImage = 'assets/images/stone1.png';
    isGemAnimating = false; // 보석 애니메이션 정지
    _gemAnimationTimer?.cancel(); // 보석 애니메이션 타이머 정지
    notifyListeners();
  }

<<<<<<< HEAD
  // 원본 캐릭터 이미지 저장
  void setOriginalImage(String imagePath) {
    originalImage = imagePath;
    notifyListeners();
  }

=======
  void resetToOriginalImage() {
    modifiedImage = originalImage; // modifiedImage를 originalImage로 복원
    stoneImage = 'assets/images/stone1.png'; // 돌 이미지를 초기 상태로 복원
    isGemAnimating = false; // 보석 애니메이션 정지
    _gemAnimationTimer?.cancel(); // 보석 애니메이션 타이머 정지
    notifyListeners();
  }


>>>>>>> origin/rin213104
  String? getCurrentImage() {
    return modifiedImage ?? originalImage;
  }

  // 랜덤 토스트 알림 메시지 표시
  void showRandomToastMessage() {
    if (_context != null) {
      final random = Random();
      final selectedMessage = toastMessages[random.nextInt(toastMessages.length)];
      final overlay = Overlay.of(_context!);
      final overlayEntry = OverlayEntry(
        builder: (context) => customToast(message: selectedMessage),
      );

      overlay?.insert(overlayEntry);

<<<<<<< HEAD
      Future.delayed(Duration(seconds: 10), () {
=======
      Future.delayed(Duration(seconds: 3), () {
>>>>>>> origin/rin213104
        overlayEntry.remove();
      });
    }
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> origin/rin213104
