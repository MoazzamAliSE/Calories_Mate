import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({Key? key, required this.showButtons}) : super(key: key);
  final bool showButtons;

  @override
  NutritionistDashBoardState createState() => NutritionistDashBoardState();
}

class NutritionistDashBoardState extends State<AppointmentsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Appointments',
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
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TabBar(tabs: [
              Tab(
                text: 'Pending',
              ),
              Tab(
                text: 'Approved',
              ),
              Tab(
                text: 'Rejected',
              ),
            ]),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: TabBarView(children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('userdata')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('appointments')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    );
                  }

                  List<Map<String, dynamic>>? data = snapshot.data?.docs
                      .map((e) => {
                            'key': e.get('key'),
                            'status': e.get('status'),
                            'name': e.get('name'),
                            'date': e.get('date'),
                            'time': e.get('time'),
                            'email': e.get('email'),
                            'uid': e.get('uid'),
                          })
                      .toList();

                  if (data == null || data.isEmpty) {
                    return const Center(
                      child: Text('No Appointment'),
                    );
                  }
                  data.removeWhere((element) => element['status'] != 'pending');
                  if (data.isEmpty) {
                    return const Center(
                      child: Text('No Appointment'),
                    );
                  }
                  return ListView.builder(
                    itemCount: data.length,
                    padding: const EdgeInsets.only(top: 20),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => PatientDetail(uid: data[index]['uid'].toString()),));
                        },
                        child: Card(
                          surfaceTintColor: Colors.white,
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 20),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.blue.withOpacity(.3),
                                  child: const Center(
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Patient : ${data[index]['name'].toString()}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Email : ${data[index]['email'].toString()}',
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                    Text(
                                      'Time : ${data[index]['date'].toString()} ${data[index]['time']}',
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                   if(widget.showButtons) Row(
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              showGeneralDialog(
                                                context: context,
                                                pageBuilder: (c, animation,
                                                    secondaryAnimation) {
                                                  return AlertDialog(
                                                    title: Text(
                                                      'Accept',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14),
                                                    ),
                                                    content: Text(
                                                      'Are you sure to accept this appointment request',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(c),
                                                          child:
                                                              Text('Cancel')),
                                                      TextButton(
                                                          onPressed: () async {
                                                            Navigator.pop(c);
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'userdata')
                                                                .doc(
                                                                  FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .uid,
                                                                )
                                                                .collection(
                                                                    'appointments')
                                                                .doc(data[index]
                                                                    ['key'])
                                                                .update({
                                                              'status':
                                                                  'approved'
                                                            });

                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'userdata')
                                                                .doc(data[index]
                                                                    ['uid'])
                                                                .collection(
                                                                    'appointments')
                                                                .doc(data[index]
                                                                    ['key'])
                                                                .update({
                                                              'status':
                                                                  'approved'
                                                            });

                                                            showGeneralDialog(
                                                              context: context,
                                                              pageBuilder: (context,
                                                                  animation,
                                                                  secondaryAnimation) {
                                                                return AlertDialog(
                                                                  title: Text(
                                                                    'Accept',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            14),
                                                                  ),
                                                                  content: Text(
                                                                    'Appointment is successfully booked',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                  actions: [
                                                                    TextButton(
                                                                        onPressed: () =>
                                                                            Navigator.pop(
                                                                                context),
                                                                        child: Text(
                                                                            'OK')),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          },
                                                          child:
                                                              Text('Accept')),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: Text(
                                              'Accept',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            )),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              showGeneralDialog(
                                                context: context,
                                                pageBuilder: (c, animation,
                                                    secondaryAnimation) {
                                                  return AlertDialog(
                                                    title: Text(
                                                      'Reject',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14),
                                                    ),
                                                    content: Text(
                                                      'Are you sure to reject this appointment request',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(c),
                                                          child:
                                                              Text('Cancel')),
                                                      TextButton(
                                                          onPressed: () async {
                                                            Navigator.pop(c);
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'userdata')
                                                                .doc(
                                                                  FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .uid,
                                                                )
                                                                .collection(
                                                                    'appointments')
                                                                .doc(data[index]
                                                                    ['key'])
                                                                .update({
                                                              'status':
                                                                  'rejected'
                                                            });

                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'userdata')
                                                                .doc(data[index]
                                                                    ['uid'])
                                                                .collection(
                                                                    'appointments')
                                                                .doc(data[index]
                                                                    ['key'])
                                                                .update({
                                                              'status':
                                                                  'rejected'
                                                            });

                                                            showGeneralDialog(
                                                              context: context,
                                                              pageBuilder: (context,
                                                                  animation,
                                                                  secondaryAnimation) {
                                                                return AlertDialog(
                                                                  title: Text(
                                                                    'Accept',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            14),
                                                                  ),
                                                                  content: Text(
                                                                    'This appointment request is rejected',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                  actions: [
                                                                    TextButton(
                                                                        onPressed: () =>
                                                                            Navigator.pop(
                                                                                context),
                                                                        child: Text(
                                                                            'OK')),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          },
                                                          child:
                                                              Text('Accept')),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: Text(
                                              'Reject',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('userdata')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('appointments')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    );
                  }

                  List<Map<String, dynamic>>? data = snapshot.data?.docs
                      .map((e) => {
                            'status': e.get('status'),
                            'name': e.get('name'),
                            'date': e.get('date'),
                            'time': e.get('time'),
                            'email': e.get('email'),
                            'uid': e.get('uid'),
                          })
                      .toList();

                  if (data == null || data.isEmpty) {
                    return const Center(
                      child: Text('No Appointment'),
                    );
                  }
                  data.removeWhere(
                      (element) => element['status'] != 'approved');
                  if (data.isEmpty) {
                    return const Center(
                      child: Text('No Appointment'),
                    );
                  }
                  return ListView.builder(
                    itemCount: data.length,
                    padding: const EdgeInsets.only(top: 20),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => PatientDetail(uid: data[index]['uid'].toString()),));
                        },
                        child: Card(
                          surfaceTintColor: Colors.white,
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 20),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.blue.withOpacity(.3),
                                  child: const Center(
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Patient : ${data[index]['name'].toString()}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Email : ${data[index]['email'].toString()}',
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                    Text(
                                      'Time : ${data[index]['date'].toString()} ${data[index]['time']}',
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('userdata')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('appointments')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    );
                  }

                  List<Map<String, dynamic>>? data = snapshot.data?.docs
                      .map((e) => {
                            'status': e.get('status'),
                            'name': e.get('name'),
                            'date': e.get('date'),
                            'time': e.get('time'),
                            'email': e.get('email'),
                            'uid': e.get('uid'),
                          })
                      .toList();

                  if (data == null || data.isEmpty) {
                    return const Center(
                      child: Text('No Appointment'),
                    );
                  }
                  data.removeWhere(
                      (element) => element['status'] != 'rejected');
                  if (data.isEmpty) {
                    return const Center(
                      child: Text('No Appointment'),
                    );
                  }
                  return ListView.builder(
                    itemCount: data.length,
                    padding: const EdgeInsets.only(top: 20),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => PatientDetail(uid: data[index]['uid'].toString()),));
                        },
                        child: Card(
                          surfaceTintColor: Colors.white,
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 20),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.blue.withOpacity(.3),
                                  child: const Center(
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Patient : ${data[index]['name'].toString()}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Email : ${data[index]['email'].toString()}',
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                    Text(
                                      'Time : ${data[index]['date'].toString()} ${data[index]['time']}',
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            ]))
          ],
        ),
      ),
    );
  }
}
