import 'dart:math';

import 'package:calories_mate/screens/workout/workout_details_screen.dart';
import 'package:calories_mate/utils/constants.dart';
import 'package:flutter/material.dart';

class WorkoutTrainingScreen extends StatelessWidget {
  final List<String> workoutCategories = [
    'ABS',
    'Shoulder',
    'Biceps',
    'Chest',
    'Triceps',
    'Back',
    'Cardio',
    'Leg',
    'Calf',
  ];

  WorkoutTrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Constants.appPadding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Exercises',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 1100,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: workoutCategories.length,
            itemExtent: 120.0,
            itemBuilder: (context, index) {
              final categoryName = workoutCategories[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 8.0),
                child: WorkoutButton(
                  categoryName: categoryName,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WorkoutDetailsScreen(
                          categoryName: categoryName,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class WorkoutButton extends StatelessWidget {
  final String categoryName;
  final VoidCallback onPressed;

  WorkoutButton(
      {super.key, required this.categoryName, required this.onPressed});
// Define a list of colors to choose from
  final List<Color> gradientColors = [
    Colors.grey,
  ];

  @override
  Widget build(BuildContext context) {
    final Random random = Random();

    Color randomColor = gradientColors[random.nextInt(gradientColors.length)];

    final gradient = LinearGradient(
      colors: [
        randomColor.withOpacity(0.3),
        randomColor.withOpacity(0.8),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
    return Material(
      elevation: 3.0,
      borderRadius: BorderRadius.circular(32.0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 2),
                blurRadius: 6.0,
              ),
            ],
          ),
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: gradient,
                  boxShadow: const [BoxShadow(offset: Offset(2, 2))],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Image.asset(
                  'assets/images/$categoryName.png',
                  width: 100.0,
                  height: 100.0,
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              Text(
                categoryName,
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
