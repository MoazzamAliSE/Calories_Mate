import 'dart:typed_data';
import 'package:calories_mate/screens/chat/chat_with.dart';
import 'package:calories_mate/screens/patient_dashboard/fitness_app_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:calories_mate/screens/Nutritionist_Dashboard_Pages/appointments.dart';
import 'package:calories_mate/screens/Nutritionist_Dashboard_Pages/patients_data.dart';
import 'Nutritionist_Dashboard_Pages/edit_profile.dart';
import 'Settings_Pages/new_password.dart';
import 'Settings_Pages/settings.dart';

class NutritionistDashBoard extends StatefulWidget {
  const NutritionistDashBoard({Key? key}) : super(key: key);

  @override
  NutritionistDashBoardState createState() => NutritionistDashBoardState();
}

User activeNutritionist = auth.currentUser!;

class NutritionistDashBoardState extends State<NutritionistDashBoard> {
  String name = "";
  String specialization = "";
  String hospital = "";
  Uint8List? dashBytes;

  @override
  void initState() {
    super.initState();
    activeNutritionist = auth.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChatWith(),
                  ));
            },
            child: const CircleAvatar(
              radius: 30,
              backgroundColor: FitnessAppTheme.cyan,
              child: Center(
                child: Icon(
                  Icons.message,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text(
            'Nutritionist \'s Dashboard',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.cyan,
          elevation: 1,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('userdata').snapshots(),
            builder: (context, snapshot) {
              var sn = snapshot.data;
              if (sn != null) {
                for (var element in sn.docs) {
                  if (element.id == activeNutritionist.uid) {
                    try {
                      name = element.get("name");
                    } catch (e) {
                      name = "";
                    }
                    try {
                      specialization = element.get("specialization");
                    } catch (e) {
                      specialization = "";
                    }
                    try {
                      hospital = element.get("hospital");
                    } catch (e) {
                      hospital = "";
                    }
                  }
                }
              }
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        colors: [
                      Colors.cyan.shade700,
                      Colors.cyan.shade300,
                      Colors.cyanAccent
                    ])),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const NutritionistProfile()));
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Nutritionist: $name",
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text("$specialization   $hospital ",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    OptionsCreater()
                  ],
                ),
              );
            }));
  }

  // profilePic() async {
  //   final FirebaseStorage firebaseStorage = FirebaseStorage.instanceFor(
  //       bucket: "gs://mental-health-e175a.appspot.com");
  //   await firebaseStorage
  //       .ref()
  //       .child("user/profile/${activeNutritionist.uid}")
  //       .getData(100000000)
  //       .then((value) => {dashBytes = value!});
  //   return 1;
  // }
}

// ignore: must_be_immutable
class OptionsCreater extends StatelessWidget {
  // Items item1 = Items(
  //   title: "Patients Data",
  //   subtitle: "About assigned patients",
  //   img: "assets/images/patient.png",
  // );
  Items item2 = Items(
    title: "Appointments",
    subtitle: "Info about appointments ",
    img: "assets/images/appointment.png",
  );

  Items item4 = Items(
    title: "Chat",
    subtitle: "Chat with your patients",
    img: "assets/images/interaction.png",
  );

  Items item6 = Items(
    title: "Settings",
    subtitle: "Access different settings",
    img: "assets/images/settings.png",
  );

  OptionsCreater({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [
      // item1,
      item2,
      item4,
      item6,
    ];
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: const EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return InkWell(
              onTap: () {
                if (data.title == "Settings") {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const SettingsPage(role: "nutritionist")));
                } else if (data.title == "Appointments") {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const AppointmentsPage()));
                } else if (data.title == "Chat") {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => const ChatWith()));
                } else if (data.title == "Patients Data") {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const PatientsDataPage()));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 40,
                          offset: Offset(0, 8))
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      data.img,
                      width: 58,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(data.title,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(data.subtitle,
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(
                      height: 14,
                    ),
                  ],
                ),
              ),
            );
          }).toList()),
    );
  }
}

class Items {
  String title;
  String subtitle;
  String img;
  Items({required this.title, required this.subtitle, required this.img});
}
