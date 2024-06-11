import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget{
  final String text;
  final Color color;
  final Color backgroundColor;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    this.color = Colors.white,
    this.backgroundColor = const Color(0xFF5B9A90),
    required this.onClicked,
}) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      padding: EdgeInsets.symmetric(horizontal:30, vertical: 15),
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 20, color: color),
    ),
    onPressed: onClicked,
  );
}