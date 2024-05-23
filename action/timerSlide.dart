import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screen/timerAnalog.dart';
import '../screen/timerDigital.dart';
import '../action/timerModel.dart';

// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (_) => TimerModel(),
//       child: const MaterialApp(
//         home: PageSlideExample(),
//         debugShowCheckedModeBanner: false,
//       ),
//     ),
//   );
// }

class PageSlideExample extends StatefulWidget {
  const PageSlideExample({Key? key}) : super(key: key);

  @override
  PageSlideExampleState createState() => PageSlideExampleState();  // 페이지 컨트롤러 설정
}

class PageSlideExampleState extends State<PageSlideExample> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          TimerAnalogPage(),  // 아날로그 타이머 페이지
          TimerDigitalPage()  // 디지털 타이머 페이지
        ],
      ),
    );
  }
}
