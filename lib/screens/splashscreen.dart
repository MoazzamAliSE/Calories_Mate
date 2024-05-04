import 'package:calories_mate/screens/dashboard_nutritionist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:calories_mate/screens/patient_dashboard/fitness_app_home_screen.dart';
import 'package:calories_mate/screens/sign_in_page.dart';
import 'package:calories_mate/screens/welcome_page.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

String? userName;
String? userEmail;

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  final auth = FirebaseAuth.instance;
  String nullCheckErrorMessage = "";

  checkLogin() async {
    try {
      user = auth.currentUser!;
    } catch (error) {
      nullCheckErrorMessage = error.toString();
      if (nullCheckErrorMessage == "Null check operator used on a null value") {
        Timer(const Duration(seconds: 1),
            () => Get.off(() => const WelcomePage()));
      }
    }
    if (FirebaseAuth.instance.currentUser?.uid == null) {
      // signed in
      Timer(
          const Duration(seconds: 1), () => Get.off(() => const WelcomePage()));
    } else {
      Timer(const Duration(seconds: 1), () => userExistAuth());
    }
  }

  userExistAuth() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final s = await FirebaseFirestore.instance
        .collection('userdata')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    try{
      userEmail = s.get('email');
    }catch(_){

    }
    try{
      userName = s.get('name');
    }catch(_){

    }

    if (pref.getString('login_as') == "nutritionist") {
      Get.off(() => const NutritionistDashBoard());
    } else if (pref.getString('login_as') == "patient") {
      Get.off(() => const FitnessAppHomeScreen());
    }
  }

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.cyan.shade700,
            Colors.cyan.shade300,
            Colors.cyanAccent
          ])),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(),
                  Image.asset(
                    "assets/images/Blue Black Funky Fitness Coach Logo_20240420_150138_0000.png",
                    width: double.infinity,
                  ),
                  const CircularProgressIndicator(
                    color: Colors.blue,
                  )
                ]),
          )),
    );
  }
}
