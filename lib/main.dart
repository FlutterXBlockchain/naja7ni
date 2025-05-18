import 'package:flutter/material.dart';
import 'package:naja7ni/core/helpers/style_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Naja7ni App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CenteredTextPage(),
    );
  }
}

class CenteredTextPage extends StatelessWidget {
  const CenteredTextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'naja7ni',
          style: StyleHelper.titleStyle,
        ),
      ),
    );
  }
}