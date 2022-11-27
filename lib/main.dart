import 'package:flutter/material.dart';
import 'package:hmw3/screens/Login_Page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homework 3',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const Login_Page(),
    );
  }
}
