import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timer/shared/menu_bottom.dart';
import '../action/timerModel.dart';
import '../action/selectedImageModel.dart';
import '../const/colors.dart';

class TimerGamePage extends StatefulWidget {
  @override
  _TimerGamePageState createState() => _TimerGamePageState();
}

class _TimerGamePageState extends State<TimerGamePage> {
  @override
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

  Widget buildDateText() {
    final now = DateTime.now();
    final formattedDate = DateFormat('MM.dd.EEE').format(now);

    return Text(
      formattedDate,
      style: TextStyle(
        color: TIMER_COLOR,
        fontSize: 18,
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
