import 'package:flutter/material.dart';
import 'package:mobile_application/app/home/home.dart';
import 'package:mobile_application/app/menu/menu.dart';
import 'package:mobile_application/app/patient_list/presentation/pages/patient_list.dart';
import 'package:mobile_application/hub/register/register.dart';

import 'hub/login/login.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
      ),
      home: LoginPage(),
      initialRoute: '/',
      routes: {
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePage(),
        '/menu': (context) => MenuPage(),
        'patient_list': (context) => PatientList(),
      },
    );
  }
}
