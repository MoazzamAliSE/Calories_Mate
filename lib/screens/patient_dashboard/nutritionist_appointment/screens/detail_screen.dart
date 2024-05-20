import 'package:calories_mate/screens/chat/chat_screen.dart';
import 'package:calories_mate/screens/patient_dashboard/fitness_app_theme.dart';
import 'package:calories_mate/screens/patient_dashboard/nutritionist_appointment/components/schedule_card.dart';
import 'package:calories_mate/screens/splashscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../components/doctor_card.dart';
import '../constant.dart';

//ignore: must_be_immutable
class DetailScreen extends StatefulWidget {
  final dynamic _name;
  final dynamic _description;
  final dynamic _uid;
  final dynamic _bio;

  const DetailScreen(this._name, this._description, this._uid, this._bio,
      {Key? key})
      : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    cardContext = context;
    return Scaffold(
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 60),
        child: GestureDetector(
          onTap: () async {
            final date = await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 7)));
            if (date != null) {
              final time = await showTimePicker(
                  context: context, initialTime: TimeOfDay.now());
              if (time != null) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text(
                        'Book Appointment',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      content: const Text(
                        'Are you sure to book appointment',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )),
                        TextButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              try {
                                final key = DateTime.now()
                                    .microsecondsSinceEpoch
                                    .toString();
                                await FirebaseFirestore.instance
                                    .collection('userdata')
                                    .doc(widget._uid)
                                    .collection('appointments')
                                    .doc(
                                        // FirebaseAuth.instance.currentUser!.uid,
                                        key)
                                    .set({
                                  'key': key,
                                  'status': 'pending',
                                  'name': userName,
                                  'email': userEmail,
                                  'uid': FirebaseAuth.instance.currentUser!.uid,
                                  'date':
                                      DateFormat('dd MMM yyyy').format(date),
                                  'time':
                                      '${time.hour}:${time.minute} ${time.period.name}',
                                });

                                await FirebaseFirestore.instance
                                    .collection('userdata')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .collection('appointments')
                                    .doc(key)
                                    .set({
                                  'key': key,
                                  'status': 'pending',
                                  'name': widget._name,
                                  'email': '',
                                  'uid': widget._uid,
                                  'date':
                                      DateFormat('dd MMM yyyy').format(date),
                                  'time':
                                      '${time.hour}:${time.minute} ${time.period.name}',
                                });

                                showDialog(
                                  context: cardContext!,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text(
                                        'Book Appointment',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                      content: const Text(
                                        'Your request for booking is successfully send to doctor',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              'Ok',
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ))
                                      ],
                                    );
                                  },
                                );
                              } catch (_) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text(
                                        'Book Appointment',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                      content: Text(
                                        _.toString(),
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              'Ok',
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ))
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: const Text(
                              'Ok',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    );
                  },
                );
              }
            }
          },
          child: Container(
              height: 55,
              width: 150,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: FitnessAppTheme.cyan,
                  borderRadius: BorderRadius.circular(30)),
              alignment: Alignment.center,
              child: const Text(
                'Book Appointment',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/detail_illustration.png'),
              alignment: Alignment.topCenter,
              fit: BoxFit.fitWidth,
            ),
          ),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        'assets/icons/back.svg',
                        height: 18,
                      ),
                    ),
                    // SvgPicture.asset(
                    //   'assets/icons/3dots.svg',
                    //   height: 18,
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.24,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image.asset(
                            'assets/images/nutritionist1.png',
                            scale: 5,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget._name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: kTitleTextColor,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                widget._description,
                                style: TextStyle(
                                  color: kTitleTextColor.withOpacity(0.7),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          const Spacer(),
                          InkWell(
                              onTap: () => Get.to(() => ChatScreen(
                                    name: widget._name,
                                    uid: widget._uid,
                                    email: '',
                                  )),
                              child: const Icon(
                                Icons.chat,
                                color: FitnessAppTheme.cyan,
                              )),
                          const SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        'About Nutritionist',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: kTitleTextColor,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget._bio,
                        style: TextStyle(
                          height: 1.6,
                          color: kTitleTextColor.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Upcoming Schedules',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: kTitleTextColor,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Generate ScheduleCards for the next 7 days
                          for (int i = 0; i < 7; i++)
                            ScheduleCard(
                              title: 'Consultation',
                              description: '9am - 6pm',
                              date: DateTime.now().add(Duration(
                                  days: i)), // Get date for next 7 days
                              bgColor: i % 2 == 0
                                  ? kBlueColor
                                  : kYellowColor, // Alternate colors
                            ),
                        ],
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
