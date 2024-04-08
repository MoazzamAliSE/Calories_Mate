import 'package:calories_mate/screens/splashscreen.dart';
import 'package:calories_mate/screens/patient_dashboard/fitness_app_home_screen.dart';
import 'package:calories_mate/screens/sign_in_page.dart';
import 'package:calories_mate/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:calories_mate/screens/sign_up_page.dart';

class Navigate {
  static Map<String, Widget Function(BuildContext)> routes =   {
    '/initial-screen' : (context) => const Splashscreen(),
    '/sign-in' : (context) => const SignInPage(),
    '/sign-up' : (context) => const SignUpPage(),
    '/home'  : (context) => const FitnessAppHomeScreen(),
  };
}