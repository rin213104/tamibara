import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../action/timerModel.dart';
import '../action/timerSlide.dart';
import '../screen/timerSetup.dart';
import '../screen/login.dart';
import '../action/selectedImageModel.dart';
import '../screen/to_do_list_screen.dart';
import 'action/todo_data_model.dart';
import '../action/nickNameProvider.dart';
import '../screen/welcome.dart';
import '../action/gaming_data_model.dart';
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
        ChangeNotifierProvider(create: (_) => ToDoDataModel()),
        ChangeNotifierProvider(create: (_) => nickNameProvider()),
        ChangeNotifierProvider(create: (_) => TimerModel()),
        ChangeNotifierProvider(create: (_) => GamingDataModel()),
        ChangeNotifierProvider(create: (_) => SelectedTodoModel()),
      ],
      child: MyApp(isFirstRun: isFirstRun, selectedImageModel: selectedImageModel),
    ),
  );
}

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
      initialRoute: '/',
      routes: {
        '/': (context) => isFirstRun ? LoginScreen() : ToDoScreen(),
        '/todolist': (context) => ToDoScreen(),
        '/timerSetup': (context) => TimerSetup(),
        '/timerSlide': (context) => timerSlideExample(todoTitle: '기본 타이머'),
        '/welcomeScreen': (context) => WelcomeScreen(selectedImage: selectedImageModel.selectedImage ?? 'assets/images/capybara/카피바라성년'),
      },
      builder: (context, child) {
        if (!isFirstRun) {
          Future.microtask(() {
            Navigator.pushReplacementNamed(context, '/todolist');
          });
        }
        return child!;
      },
    );
  }
}
