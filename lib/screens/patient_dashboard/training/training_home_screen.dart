import 'package:calories_mate/screens/patient_dashboard/training/components/diff_styles.dart';
import 'package:calories_mate/screens/patient_dashboard/training/components/video_suggestions.dart';
import 'package:calories_mate/screens/workout/workout_training.dart';
import 'package:flutter/material.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({key}) : super(key: key);

  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text(
          "Training",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const VideoSuggestions(),
              const DiffStyles(),
              // const Courses(),
              WorkoutTrainingScreen(),
              const SizedBox(
                height: 80,
              )
            ],
          ),
        ),
      ),
    );
  }
}
