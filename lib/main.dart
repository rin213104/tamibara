import 'package:asd/action/nickNameProvider.dart';
import 'package:asd/action/selectedImageModel.dart';
import 'package:asd/screen/error.dart';
import 'package:asd/screen/loading.dart';
import 'package:asd/screen/option.dart';
import 'package:asd/screen/profile.dart';
import 'package:asd/screen/startSet_2.dart';
import 'package:asd/screen/startSet_3.dart';
import 'package:asd/screen/welcome.dart';
import 'package:asd/shared/menu_bottom.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SelectedImageModel()),
          ChangeNotifierProvider(create: (_) => nickNameProvider()),
        ],
        child:MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: NickNameScreen(),
        bottomNavigationBar: MenuBottom(),
      )
    );
  }
}
