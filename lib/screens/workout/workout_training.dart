import 'package:calories_mate/screens/workout/workout_details_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 18.0,bottom: 10),
          child: Text("Workout Screen",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
        ),
        backgroundColor: Color.fromARGB(255, 4, 34, 66),
      ),
      backgroundColor: Color.fromARGB(255, 107, 136, 166),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: workoutCategories.length,
          itemExtent: 120.0, // Set the height of each item (container) to 120
          itemBuilder: (context, index) {
            final categoryName = workoutCategories[index];
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0), // Add vertical padding between containers
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
    );
  }
}

class WorkoutButton extends StatelessWidget {
  final String categoryName;
  final VoidCallback onPressed;

  WorkoutButton({required this.categoryName, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3.0,
      borderRadius: BorderRadius.circular(8.0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 2),
                blurRadius: 6.0,
              ),
            ],
          ),
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                categoryName,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Image.asset(
                'assets/images/${categoryName}.png',
                width: 100.0,
                height: 100.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
