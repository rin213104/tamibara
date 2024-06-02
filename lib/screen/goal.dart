import 'package:flutter/material.dart';
import 'package:timer/shared/menu_bottom.dart'; // 메뉴바텀 파일 경로 확인 필요

// 목표 기능
class GoalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD3F3EF),
      body: Center(
        child: Text(
          'Goal Test Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: MenuBottom(),
    );
  }
}
