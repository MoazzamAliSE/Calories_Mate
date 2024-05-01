import 'package:calories_mate/screens/patient_dashboard/training/models/course.dart';
import 'package:calories_mate/screens/patient_dashboard/training/models/style.dart';
 



final _standStyle = Style(
  imageUrl: 'assets/images/pose2.png',
  name: 'Standing Style',
  time: 5,
  description: '1. Stand with feet shoulder-width apart.\n'
      '2. Keep your back straight and engage your core.\n'
      '3. Relax your shoulders.\n'
      '4. Hold this position for 5 minutes.',
);
final _sittingStyle = Style(
  imageUrl: 'assets/images/pose1.png',
  name: 'Sitting Style',
  time: 8,
  description: '1. Sit on a chair with your back straight.\n'
      '2. Place your feet flat on the floor.\n'
      '3. Relax your shoulders and keep them away from your ears.\n'
      '4. Hold this position for 8 minutes.',
);
final _legCrossStyle = Style(
  imageUrl: 'assets/images/pose3.png',
  name: 'Leg Cross Style',
  time: 6,
  description: '1. Sit on the floor with your legs extended in front of you.\n'
      '2. Cross one leg over the other, placing the foot flat on the floor.\n'
      '3. Keep your back straight and engage your core.\n'
      '4. Hold this position for 6 minutes, then switch legs.',
);
final styles = [
  _standStyle,
  _sittingStyle,
  _legCrossStyle,
  _sittingStyle,
  _standStyle,
];

final _course1 = Course(
    imageUrl: 'assets/images/course5.jpg',
    name: 'Cardio Exercises',
    time: 20,
    students: 'Beginner');

final _course2 = Course(
    imageUrl: 'assets/images/course4.jpg',
    name: 'Exercises',
    time: 20,
    students: 'Beginner');

final _course3 = Course(
    imageUrl: 'assets/images/course3.jpg',
    name: 'Meditation',
    time: 20,
    students: 'Beginner');
final _course4 = Course(
    imageUrl: 'assets/images/course2.jpg',
    name: 'Daily Yoga',
    time: 30,
    students: 'Intermediate');
final _course5 = Course(
    imageUrl: 'assets/images/course1.jpg',
    name: 'Advance Stretching',
    time: 45,
    students: 'Advanced');

final List<Course> courses = [_course1, _course3, _course2, _course4, _course5];
