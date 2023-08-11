import 'package:flutter/material.dart';
import '../screens/doctor_detail.dart';
import '../screens/welcome/welcome_screen.dart';
import '/screens/home.dart';
import '../screens/auth/sign_in_screen.dart';
import '../presentation/doctor_app.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/new': (context) => WelcomeScreen(),
  '/signin': (context) => SignInScreen(),
  '/home': (context) => Home(),
  '/detail': (context) => SliverDoctorDetail(),
  '/': (context) => DoctorScreen(),
};
