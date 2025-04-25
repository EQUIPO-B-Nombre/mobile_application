import 'package:flutter/material.dart';
import 'package:mobile_application/app/home/home.dart';
import 'package:mobile_application/app/medical/medical_consultation_list.dart';
import 'package:mobile_application/app/menu/menu.dart';
import 'package:mobile_application/app/menu/menu_doctor.dart';
import 'package:mobile_application/app/profile/profile.dart';
import 'package:mobile_application/hub/register/register.dart';
import 'package:mobile_application/app/home/home_doctor.dart';

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
        '/profile': (context) => ProfilePage(),
        '/menu_doctor': (context) => MenuDoctorPage(),
        '/home_doctor': (context) => HomePageDoctor(),
        '/medical_list': (context) => MedicalConsultationListPage(),
      },
    );
  }
}
