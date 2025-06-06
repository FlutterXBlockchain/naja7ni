import 'package:flutter/material.dart';
import 'package:quizz/pages/qcm_choice_page/qcm_choice_page.dart';
import 'pages/login_test/login_screen.dart';
import 'core/helpers/detect_port.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //final backendService = BackendService.instance;

  // Try to find an already running backend server (e.g., from Visual Studio)
  
  //await backendService.detectPort();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const QcmChoicePage(),
    );
  }
}
