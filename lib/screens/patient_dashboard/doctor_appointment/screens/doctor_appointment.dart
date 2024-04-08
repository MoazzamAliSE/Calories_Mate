import 'package:flutter/material.dart';
import 'home_screen.dart';

class DoctorAppointment extends StatelessWidget {
  const DoctorAppointment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      home: const HomeScreen(),
    );
  }
}