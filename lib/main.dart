import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
<<<<<<< HEAD
import '../action/timerModel.dart';
import '../action/timerSlide.dart';
import '../screen/timerSetup.dart';
import '../screen/login.dart';
import '../action/selectedImageModel.dart';
=======
import 'package:timer/action/timerModel.dart';
import 'package:timer/action/timerSlide.dart';
import 'package:timer/screen/timerSetup.dart';
import 'package:timer/screen/login.dart';
import 'package:timer/action/selectedImageModel.dart';
>>>>>>> origin/rin213104
import '../screen/to_do_list_screen.dart';
import 'action/todo_data_model.dart';
import '../action/nickNameProvider.dart';
import '../screen/welcome.dart';
<<<<<<< HEAD
import '../action/gaming_data_model.dart';
import '../action/selected_todo_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => TimerModel()),  // TimerModel을 Provider로 등록하여 전역 상태 관리
        ChangeNotifierProvider(create: (_) => SelectedImageModel()),  // SelectedImageModel을 Provider로 등록
=======
import 'package:timer/action/gaming_data_model.dart';
import '../action/selected_todo_model.dart';
import '../database/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isFirstRun = await checkFirstRun();
  final selectedImageModel = SelectedImageModel();
  await selectedImageModel.initializeSelectedImage();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => selectedImageModel),
>>>>>>> origin/rin213104
        ChangeNotifierProvider(create: (_) => ToDoDataModel()),
        ChangeNotifierProvider(create: (_) => nickNameProvider()),
        ChangeNotifierProvider(create: (_) => TimerModel()),
        ChangeNotifierProvider(create: (_) => GamingDataModel()),
        ChangeNotifierProvider(create: (_) => SelectedTodoModel()),
      ],
<<<<<<< HEAD
      child: MyApp(),
=======
      child: MyApp(isFirstRun: isFirstRun, selectedImageModel: selectedImageModel),
>>>>>>> origin/rin213104
    ),
  );
}

<<<<<<< HEAD
/*class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        TimerModel();
        ToDoDataModel();
      },

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/todolist': (context) => ToDoScreen(),
          '/timerSetup': (context) => TimerSetup(),
          '/timerSlide': (context) => timerSlideExample(),
        },
      ),
    );
  }
}

 */

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        TimerModel();
        //ToDoDataModel();
      },

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/todolist': (context) => ToDoScreen(),
          '/timerSetup': (context) => TimerSetup(),
          '/timerSlide': (context) => timerSlideExample(),
          '/welcomeScreen': (context) => WelcomeScreen(selectedImage: 'assets/images/selected_image.png'),
        },
      ),
=======
Future<bool> checkFirstRun() async {
  final dbHelper = DatabaseHelper();
  final isFirstRun = await dbHelper.getFirstRun();

  if (isFirstRun == null || isFirstRun == 1) {
    await dbHelper.insertFirstRun(0);
    return true;
  }
  return false;
}

class MyApp extends StatelessWidget {
  final bool isFirstRun;
  final SelectedImageModel selectedImageModel;

  const MyApp({required this.isFirstRun, required this.selectedImageModel});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: isFirstRun ? '/' : '/todolist',
      routes: {
        '/': (context) => LoginScreen(),
        '/todolist': (context) => ToDoScreen(),
        '/timerSetup': (context) => TimerSetup(),
        '/timerSlide': (context) => timerSlideExample(todoTitle: '기본 타이머'),
        '/welcomeScreen': (context) => WelcomeScreen(selectedImage: selectedImageModel.selectedImage ?? 'assets/images/capybara/카피바라성년'),
      },
>>>>>>> origin/rin213104
    );
  }
}