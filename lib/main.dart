import 'package:flutter/material.dart';
import 'package:training_test2/screeens/home_screen.dart';
import 'package:training_test2/screeens/login_page.dart';
import 'package:training_test2/screeens/register.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'training test2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange),
      home: LoginPage(),
    );
  }
}
