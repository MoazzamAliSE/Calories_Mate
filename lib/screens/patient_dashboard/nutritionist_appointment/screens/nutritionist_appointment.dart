import 'package:flutter/material.dart';
import 'home_screen.dart';

class NutritionistAppointment extends StatelessWidget {
  const NutritionistAppointment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
