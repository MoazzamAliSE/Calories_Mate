import 'dart:async';
import 'package:calories_mate/screens/dashboard_nutritionist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:calories_mate/screens/sign_up_page.dart';
import 'k_ten_scale/Tenscale.dart';

late User user;

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({Key? key}) : super(key: key);

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    user = auth.currentUser!;

    checkEmailVerified();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Get.off(() => const SignUpPage());
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser!;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('login_as') == "nutritionist") {
      Get.off(() => const NutritionistDashBoard());
    } else if (prefs.getString('login_as') == "patient") {
      Get.off(() => const TenScale());
    }
  }
}
