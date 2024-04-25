import 'dart:typed_data';

import 'package:calories_mate/screens/chat/chat_screen.dart';
import 'package:calories_mate/screens/patient_dashboard/doctor_appointment/components/agora.config.dart';
import 'package:calories_mate/screens/patient_dashboard/doctor_appointment/components/schedule_card.dart';
import 'package:calories_mate/screens/splashscreen.dart';
import 'package:calories_mate/utils/load_profile_pic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
    return Scaffold(
      // floatingActionButton: GestureDetector(
      //   onTap: () {
      //     showGeneralDialog(context: context, pageBuilder: (context, animation, secondaryAnimation) {
      //       return AlertDialog(
      //         title: Text('Book Appointment',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14),),
      //         content: Text('Are you sure to book appointment',style: TextStyle(color: Colors.black,fontSize: 14),),
      //         actions: [
      //           TextButton(onPressed: () {
      //             Navigator.pop(context);
      //           }, child: Text('Cancel',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
      //           TextButton(onPressed: () {
      //             FirebaseFirestore.instance.collection('userdata').doc(widget._uid).collection('appointments').doc(
      //               FirebaseAuth.instance.currentUser!.uid,
      //             ).set(
      //               {
      //                 'name' : userName,
      //                 'email' : userEmail,
      //                 'uid' : FirebaseAuth.instance.currentUser!.uid,
      //                 'date' : DateFormat('dd MMM yyyy').format(DateTime.now()),
      //                 'time' :  DateFormat('hh:mm a').format(DateTime.now()),
      //               }
      //             );
      //           }, child: Text('Ok',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)),
      //         ],
      //       );
      //     },);
      //   },
      //   child: Container(
      //   height: 55,
      //       width: 150,
      //       margin: EdgeInsets.symmetric(horizontal: 20),
      //       decoration: BoxDecoration(
      //         color: Colors.blue,
      //         borderRadius: BorderRadius.circular(30)
      //       ),
      //       alignment: Alignment.center,
      //       child: const Text('Book Appointment',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
      // ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: loadProfilePic(widget._uid),
            builder: (context, AsyncSnapshot<Uint8List?> snapshot) {
              return Container(
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
                          SvgPicture.asset(
                            'assets/icons/3dots.svg',
                            height: 18,
                          ),
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
                                (snapshot.data != null)
                                    ? CircleAvatar(
                                        radius: 50,
                                        backgroundImage:
                                            Image.memory(snapshot.data!).image,
                                      )
                                    : Image.asset(
                                        'assets/images/doctor1.png',
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
                                    // Row(
                                    //   children: <Widget>[
                                    //     InkWell(
                                    //       onTap: () async {
                                    //         Navigator.push(
                                    //             context,
                                    //             MaterialPageRoute(
                                    //                 builder: (context) =>
                                    //                     Scaffold(
                                    //                       appBar: AppBar(
                                    //                         backgroundColor:
                                    //                             Colors.cyan,
                                    //                         title: const Text(
                                    //                             "Audio Calling"),
                                    //                       ),
                                    //                       body:
                                    //                           const JoinChannelAudio(),
                                    //                     )));
                                    //       },
                                    //       child: Container(
                                    //         padding: const EdgeInsets.all(10),
                                    //         decoration: BoxDecoration(
                                    //           color:
                                    //               kBlueColor.withOpacity(0.1),
                                    //           borderRadius:
                                    //               BorderRadius.circular(10),
                                    //         ),
                                    //         child: SvgPicture.asset(
                                    //           'assets/icons/phone.svg',
                                    //         ),
                                    //       ),
                                    //     ),
                                    //     const SizedBox(
                                    //       width: 16,
                                    //     ),
                                    //     Container(
                                    //       padding: const EdgeInsets.all(10),
                                    //       decoration: BoxDecoration(
                                    //         color:
                                    //             kYellowColor.withOpacity(0.1),
                                    //         borderRadius:
                                    //             BorderRadius.circular(10),
                                    //       ),
                                    //       child: SvgPicture.asset(
                                    //         'assets/icons/chat.svg',
                                    //       ),
                                    //     ),
                                    //     const SizedBox(
                                    //       width: 16,
                                    //     ),
                                    //     InkWell(
                                    //       onTap: () async {
                                    //         Navigator.push(
                                    //             context,
                                    //             MaterialPageRoute(
                                    //                 builder: (context) =>
                                    //                     Scaffold(
                                    //                       appBar: AppBar(
                                    //                         backgroundColor:
                                    //                             Colors.cyan,
                                    //                         title: const Text(
                                    //                             "Video Calling"),
                                    //                       ),
                                    //                       body:
                                    //                           const TokenMaker(),
                                    //                     )));
                                    //       },
                                    //       child: Container(
                                    //         padding: const EdgeInsets.all(10),
                                    //         decoration: BoxDecoration(
                                    //           color:
                                    //               kOrangeColor.withOpacity(0.1),
                                    //           borderRadius:
                                    //               BorderRadius.circular(10),
                                    //         ),
                                    //         child: SvgPicture.asset(
                                    //           'assets/icons/video.svg',
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                  ],
                                ),
                                Spacer(),
                                InkWell(
                                    onTap: () => Get.to(()=>ChatScreen(
                                      name: widget._name,
                                      uid: widget._uid,
                                      email: '',
                                    )),
                                    child: Icon(Icons.chat,color: Colors.blue,)),
                                SizedBox(width: 20,)
                              ],
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Text(
                              'About Doctor',
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
                            Text(
                              'Upcoming Schedules',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: kTitleTextColor,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ScheduleCard(
                              'Consultation',
                              'Sunday . 9am - 11am',
                              '12',
                              'Jan',
                              kBlueColor,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ScheduleCard(
                              'Consultation',
                              'Sunday . 9am - 11am',
                              '13',
                              'Jan',
                              kYellowColor,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ScheduleCard(
                              'Consultation',
                              'Sunday . 9am - 11am',
                              '14',
                              'Jan',
                              kOrangeColor,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
