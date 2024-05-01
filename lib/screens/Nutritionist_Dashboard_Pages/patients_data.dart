import 'package:flutter/material.dart';

class PatientsDataPage extends StatefulWidget {
  const PatientsDataPage({Key? key}) : super(key: key);

  @override
  NutritionistDashBoardState createState() => NutritionistDashBoardState();
}

class NutritionistDashBoardState extends State<PatientsDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Patients Data',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.cyan,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
