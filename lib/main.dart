import 'package:api/home/auth_with_apis/login.dart';
import 'package:api/home/auth_with_apis/sign_up.dart';
import 'package:api/home/example_four.dart';
import 'package:api/home/example_three.dart';
import 'package:api/home/example_two.dart';
import 'package:api/home/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  Login()
    );
  }
}
