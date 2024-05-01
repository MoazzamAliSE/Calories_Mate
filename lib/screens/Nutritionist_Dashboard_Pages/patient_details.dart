import 'package:flutter/material.dart';

class PatientDetail extends StatefulWidget {
  const PatientDetail({super.key, required this.uid});
  final String uid;
  @override
  State<PatientDetail> createState() => _PatientDetailState();
}

class _PatientDetailState extends State<PatientDetail> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [

        ],
      ),
    );
  }
}
