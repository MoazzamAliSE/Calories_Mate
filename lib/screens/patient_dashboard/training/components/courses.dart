// import 'package:flutter/material.dart';
// import 'package:calories_mate/screens/patient_dashboard/training/data/data.dart';
// import 'package:calories_mate/screens/patient_dashboard/training/models/course.dart';
// import 'package:calories_mate/utils/constants.dart';

// class Courses extends StatelessWidget {
//   const Courses({Key? key}) : super(key: key);

//   Widget _buildCourses(BuildContext context, int index) {
//     Size size = MediaQuery.of(context).size;
//     Course course = courses[index];

//     return Padding(
//       padding: const EdgeInsets.symmetric(
//           horizontal: 10, vertical: Constants.appPadding / 3),
//       child: Container(
//         height: size.height * 0.205,
//         decoration: BoxDecoration(
//             color: Constants.white,
//             borderRadius: BorderRadius.circular(30.0),
//             boxShadow: [
//               BoxShadow(
//                   color: Constants.black.withOpacity(0.1),
//                   blurRadius: 5.0,
//                   offset: const Offset(-1, 5))
//             ]),
//         child: Padding(
//           padding: const EdgeInsets.all(13),
//           child: Row(
//             children: [
//               SizedBox(
//                 width: size.width * 0.35,
//                 height: size.height * 0.2,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(20.0),
//                   child: Image(
//                     image: AssetImage(course.imageUrl),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: size.width * 0.4,
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                       left: Constants.appPadding / 2,
//                       top: Constants.appPadding / 1.5),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         course.name,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                         maxLines: 2,
//                       ),
//                       SizedBox(
//                         height: size.height * 0.01,
//                       ),
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.folder_open_rounded,
//                             color: Constants.black.withOpacity(0.3),
//                           ),
//                           SizedBox(
//                             width: size.width * 0.01,
//                           ),
//                           Text(
//                             course.students,
//                             style: TextStyle(
//                               color: Constants.black.withOpacity(0.3),
//                             ),
//                           )
//                         ],
//                       ),
//                       SizedBox(
//                         height: size.height * 0.01,
//                       ),
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.access_time_outlined,
//                             color: Constants.black.withOpacity(0.3),
//                           ),
//                           SizedBox(
//                             width: size.width * 0.01,
//                           ),
//                           Text(
//                             '${course.time} min',
//                             style: TextStyle(
//                               color: Constants.black.withOpacity(0.3),
//                             ),
//                           )
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Column(
//       children: [
//         const Padding(
//           padding: EdgeInsets.symmetric(
//             horizontal: Constants.appPadding,
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Exercises',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Padding(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 5,
//             ),
//             child: SizedBox(
//                 height: size.height * 0.22 * courses.length,
//                 child: ListView.builder(
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: courses.length,
//                   itemBuilder: (context, index) {
//                     return _buildCourses(context, index);
//                   },
//                 ))),
//       ],
//     );
//   }
// }
