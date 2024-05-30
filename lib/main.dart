import 'package:flutter/material.dart';
import 'package:tamibara/screen/to_do_list_screen.dart';
import 'package:provider/provider.dart';
import 'package:tamibara/model/todo_data_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // ignore: close_sinks
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ToDoDataModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
          home: ToDoScreen(),
      ),
    );
  }
}

