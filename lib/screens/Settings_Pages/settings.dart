import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:calories_mate/screens/Nutritionist_Dashboard_Pages/edit_profile.dart';
import 'package:calories_mate/screens/Settings_Pages/new_password.dart';
import 'package:calories_mate/screens/patient_dashboard/fitness_app_home_screen.dart';
import 'package:calories_mate/screens/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:calories_mate/services/firebase_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  final String role;
  const SettingsPage({Key? key, required this.role}) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  User? user = FirebaseAuth.instance.currentUser;

  String name = "";

  @override
  Widget build(BuildContext context) {
    User activeuser = auth.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.cyan,
        elevation: 1,
        leading: IconButton(
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            if (prefs.getString('login_as') == "nutritionist") {
              Navigator.of(context).pop();
            } else {
              if (widget.role == "nutritionist") {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NutritionistProfile()));
              } else {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FitnessAppHomeScreen()));
              }
            }
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('userdata').snapshots(),
          builder: (context, snapshot) {
            var sn = snapshot.data;
            if (sn != null) {
              for (var element in sn.docs) {
                if (element.id == activeuser.uid) {
                  try {
                    name = element.get("name");
                  } catch (e) {
                    name = "";
                  }
                }
              }
            }
            return Container(
              padding: const EdgeInsets.only(left: 16, top: 6, right: 16),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "  Profile",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Card(
                        color: Colors.cyan,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ListTile(
                            title: Text(
                              name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                            subtitle: Text(
                              widget.role == "nutritionist"
                                  ? "WellCome Nutritionist"
                                  : "WellCome Dear Patient",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 10),
                            ),
                            trailing: widget.role == "nutritionist"
                                ? const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  )
                                : null,
                            onTap: widget.role == "nutritionist"
                                ? () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const NutritionistProfile()));

                                    //open edit profile
                                  }
                                : null,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 15,
                    thickness: 1,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const ChangePassPage()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Change Password",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.cyan,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    height: 15,
                    thickness: 1,
                  ),
                  GestureDetector(
                    onTap: () async {
                      FirebaseService service = FirebaseService();
                      await service.signOut();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const SignInPage()),
                        ModalRoute.withName(''),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Log out",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600],
                            ),
                          ),
                          const Icon(
                            Icons.exit_to_app,
                            color: Colors.cyan,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    height: 15,
                    thickness: 1,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
