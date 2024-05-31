import 'package:flutter/material.dart';
import '../screen/option.dart';
import '../screen/timerSetup.dart';
import '../screen/to_do_list_screen.dart';
import '../screen/profile.dart';
import '../screen/goal.dart';
import '../screen/startSet_1.dart'; // startSet_1 화면 import 추가

class MenuBottom extends StatelessWidget {
  const MenuBottom({
    Key? key,
  }) : super(key: key);

  // 타이머, 목표설정, 캐릭터, 설정 누르면 해당 화면으로 이동
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (int index) {
        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TimerSetup(),
              ),
            );
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ToDoScreen(),
              ),
            );
            break;
          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => optionScreen(),
              ),
            );
            break;
          default:
        }
      },
      type: BottomNavigationBarType.fixed, // 요소 4개 이상일 경우
      selectedItemColor: Color(0xFF304C49), // 선택된 아이템의 아이콘 및 레이블 색상 변경
      unselectedItemColor: Color(0xFF304C49), // 선택되지 않은 아이템의 아이콘 및 레이블 색상 변경
      selectedLabelStyle: TextStyle(color: Color(0xFF304C49)), // 선택된 아이템의 레이블 색상 변경
      unselectedLabelStyle: TextStyle(color: Color(0xFF304C49)), // 선택되지 않은 아이템의 레이블 색상 변경
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.watch_later), label: '타이머'),
        BottomNavigationBarItem(icon: Icon(Icons.format_list_bulleted), label: '목표설정'),
        BottomNavigationBarItem(icon: Icon(Icons.pets), label: '캐릭터'),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: '설정'),
      ],
    );
  }
}
