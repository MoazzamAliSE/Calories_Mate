import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:calories_mate/screens/Settings_Pages/new_password.dart';
import 'package:calories_mate/screens/patient_dashboard/BodyMesurment/input.dart';
import 'package:calories_mate/screens/patient_dashboard/BodyMesurment/models.dart';
import 'package:calories_mate/screens/patient_dashboard/fitness_app_home_screen.dart';
import 'package:calories_mate/screens/patient_dashboard/BodyMesurment/body_m_shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:calories_mate/services/database.dart';

late User user;

class Result extends StatefulWidget {
  final String status, msg;
  final String statusNumber,
      currentCalorie,
      goalCalorie,
      bmr,
      heightCm,
      weight,
      age,
      gender;
  const Result(
      {Key? key,
      required this.status,
      required this.msg,
      required this.statusNumber,
      required this.currentCalorie,
      required this.goalCalorie,
      required this.bmr,
      required this.heightCm,
      required this.weight,
      required this.age,
      required this.gender})
      : super(key: key);

  @override
  State<Result> createState() => ResultState();
}

class ResultState extends State<Result> {
  String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  final _preferencesService = PreferencesService();
  var _bMW = "";
  var _status = '';
  var _bMR = "";
  var _height = "";
  var _weight = "";
  var _date = "";
  var _age = "";
  var _gender = "";
  @override
  Widget build(BuildContext context) {
    setState(() {
      _bMW = widget.statusNumber;
      _status = widget.status;
      _bMR = widget.bmr;
      _height = widget.heightCm;
      _weight = widget.weight;
      _date = formattedDate;
      _age = widget.age;
      _gender = widget.gender;
    });
    user = auth.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Result"),
        // centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      backgroundColor: const Color(0xFFF2F3F8),
      body: ListView(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  height: 180,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black45.withOpacity(0.2),
                          offset: const Offset(1.1, 4.0),
                          blurRadius: 8.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Body Mass Weight",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.cyan,
                          ),
                        ),
                      ),
                      const Divider(
                        height: 2,
                        thickness: 1,
                        color: Colors.grey,
                        indent: 25,
                        endIndent: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                const Text(
                                  "Your Status: ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    // fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  _status,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                const Text(
                                  "BMW Value: ",
                                  style: TextStyle(
                                    fontSize: 18,

                                    // fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  _bMW.toString(),
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: <Widget>[
                            Text(
                              widget.msg,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  height: 260,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black45.withOpacity(0.2),
                          offset: const Offset(1.1, 4.0),
                          blurRadius: 8.0),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Basal Metabolic Rate",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.cyan,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Divider(
                              height: 2,
                              thickness: 1,
                              color: Colors.grey,
                              indent: 25,
                              endIndent: 25,
                            ),
                            Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    const Text(
                                      "BMR Value: ",
                                      style: TextStyle(
                                        fontSize: 18,

                                        // fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      _bMR.toString(),
                                      style: const TextStyle(
                                        fontSize: 27,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),

                            const Text(
                              "Current Calories",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.cyan,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            // Divider(height: 2,thickness: 1,color: Colors.grey,indent: 25,endIndent: 25,),
                            Text(
                              widget.currentCalorie,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Text(
                              "(As per Activity)",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Text(
                              "Daily Calories Required",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.cyan,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            // Divider(height: 2,thickness: 1,color: Colors.grey,indent: 25,endIndent: 25,),
                            Text(
                              widget.goalCalorie,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Text(
                              "(As per Activity)",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const InputPage()),
                (Route<dynamic> route) => false,
              );
            },
            child: Container(
              height: 50,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              constraints: const BoxConstraints(minWidth: 50, maxWidth: 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.cyan,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black45.withOpacity(0.2),
                      offset: const Offset(1.1, 4.0),
                      blurRadius: 8.0),
                ],
              ),
              child: const Column(
                children: <Widget>[
                  Text(
                    'Recalculate',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _saveDetails();
              DatabaseService(uid: user.uid).updateBodyMesurmentData(
                  int.parse(_height),
                  int.parse(_weight),
                  double.parse(_bMR),
                  double.parse(_bMW),
                  _status,
                  _date,
                  _age,
                  _gender);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const FitnessAppHomeScreen()),
                (Route<dynamic> route) => false,
              );
            },
            child: Container(
              height: 50,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              constraints: const BoxConstraints(minWidth: 50, maxWidth: 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.red,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black45.withOpacity(0.2),
                      offset: const Offset(1.1, 4.0),
                      blurRadius: 8.0),
                ],
              ),
              child: const Column(
                children: <Widget>[
                  Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
        ],
      ),
    );
  }

  void _saveDetails() {
    final newDetails = BodyM(
        height: _height.toString(),
        weight: _weight.toString(),
        bMW: _bMW.toString(),
        bMR: _bMR.toString(),
        status: _status,
        time: _date);
    _preferencesService.saveFinalDetails(newDetails);
  }
}
