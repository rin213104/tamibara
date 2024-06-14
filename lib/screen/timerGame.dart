import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
<<<<<<< HEAD
import '../shared/menu_bottom.dart';
=======
import 'package:timer/shared/menu_bottom.dart';
>>>>>>> origin/rin213104
import '../action/timerModel.dart';
import '../action/selectedImageModel.dart';
import '../const/colors.dart';

class TimerGamePage extends StatefulWidget {
<<<<<<< HEAD
=======
  final String title;
  TimerGamePage({required this.title}); // 생성자 수정

>>>>>>> origin/rin213104
  @override
  _TimerGamePageState createState() => _TimerGamePageState();
}

class _TimerGamePageState extends State<TimerGamePage> {
  @override
<<<<<<< HEAD
=======
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final selectedImageModel = Provider.of<SelectedImageModel>(context, listen: false);
      final timerModel = Provider.of<TimerModel>(context, listen: false);
      if (selectedImageModel.selectedImage != null) {
        timerModel.setOriginalImage(selectedImageModel.selectedImage!); // 선택된 이미지를 TimerModel에 설정
      }
    });
  }

  @override
>>>>>>> origin/rin213104
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: Column(
        children: [
          buildTopBar(context),
          Expanded(
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
<<<<<<< HEAD
                  Positioned(
                    bottom: 160,
                    child: Image.asset(
                      'assets/images/stone.png',
                      width: 300,
                      height: 400,
                    ),
                  ),
                  Consumer2<TimerModel, SelectedImageModel>(
                    builder: (context, timerModel, selectedImageModel, child) {
                      String? folder = selectedImageModel.selectedFolder;
                      String image1 = 'assets/images/$folder/${folder}광질1.png';
                      String image2 = 'assets/images/$folder/${folder}광질2.png';
                      double imageSize = timerModel.isAnimating ? 250.0 : 200.0;
                      return Positioned(
                        right: 20,
                        bottom: 140,
                        child: Image.asset(
                          timerModel.isAnimating
                              ? (timerModel.isFirstImage ? image1 : image2)
                              : timerModel.modifiedImage ?? selectedImageModel.selectedImage ?? 'assets/images/bear/곰돌기본채색.png',
=======
                  Consumer<TimerModel>(
                    builder: (context, timerModel, child) {
                      return Positioned(
                        bottom: 160,
                        child: Image.asset(
                          timerModel.stoneImage,
                          width: 300,
                          height: 400,
                        ),
                      );
                    },
                  ),
                  Consumer2<TimerModel, SelectedImageModel>(
                    builder: (context, timerModel, selectedImageModel, child) {
                      String? folder = selectedImageModel.selectedFolder ?? selectedImageModel.selectedImage?.split('/')[2];// String? folder = selectedImageModel.selectedFolder;
                      String image1 = 'assets/images/$folder/${folder}광질1.png';
                      String image2 = 'assets/images/$folder/${folder}광질2.png';
                      double imageSize = timerModel.isAnimating ? 250.0 : 200.0;

                      return Positioned(
                        right: 20,
                        bottom: 150,
                        child: Image.asset(
                          timerModel.isGemAnimating
                              ? (timerModel.isFirstImage ? timerModel.gemImage1! : timerModel.gemImage2!)
                              : (timerModel.isAnimating
                              ? (timerModel.isFirstImage ? image1 : image2)
                              : timerModel.modifiedImage ?? selectedImageModel.selectedImage ?? 'assets/images/bear/곰돌기본채색.png'),
>>>>>>> origin/rin213104
                          width: imageSize,
                          height: imageSize,
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 120, // 원하는 위치로 조정
                    child: buildDotsIndicator(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: MenuBottom(),
    );
  }

  Widget buildTopBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      height: MediaQuery.of(context).size.height / 8,
      alignment: Alignment.center,
      color: PRIMARY_COLOR,
      child: buildDateText(),
    );
  }

<<<<<<< HEAD
  Widget buildDateText() {
    final now = DateTime.now();
    final formattedDate = DateFormat('MM.dd.EEE').format(now);

    return Text(
      formattedDate,
      style: TextStyle(
        color: TIMER_COLOR,
        fontSize: 18,
=======
  // 타이머 날짜 -> 타이머 목표 타이틀
  Widget buildDateText() {
    return Text(
      widget.title, // title로 변경
      style: TextStyle(
        color: TIMER_COLOR,
        fontSize: 20,
>>>>>>> origin/rin213104
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildDotsIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFAFCBBF),
          ),
        ),
      ],
    );
  }
}
