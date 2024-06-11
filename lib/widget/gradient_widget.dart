import 'package:flutter/material.dart';

class GradientWidget extends StatelessWidget {
  final Widget child;

  const GradientWidget({Key? key, required this.child}) : super(key: key); // 생성자 수정

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFD3F3EF), // 단색 배경색으로 변경
      child: child,
    );
  }
}
