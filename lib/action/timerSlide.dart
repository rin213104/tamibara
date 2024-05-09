import 'package:flutter/material.dart';
/*import '../screen/timerAnalog.dart';
import '../screen/timerDigital.dart';*/
// import '../screen/startSet2.dart';

void main() {
  runApp(
    const MaterialApp(
      home: PageSlideExample(),
    ),
  );
}

class PageSlideExample extends StatefulWidget {
  const PageSlideExample({Key? key}) : super(key: key);

  @override
  PageSlideExampleState createState() => PageSlideExampleState();
}

class PageSlideExampleState extends State<PageSlideExample> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [

        ],
      ),
    );
  }
}
