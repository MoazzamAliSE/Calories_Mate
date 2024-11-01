import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:calories_mate/screens/Settings_Pages/new_password.dart';
import 'package:calories_mate/screens/patient_dashboard/my_diary/my_diary_screen.dart';
import 'package:calories_mate/services/database.dart';

Response? response;
var dio = Dio();
String carbo = "";
String protein = "";
String fat = "";
String calories = "";
String cholesterol = "";
String sugars = "";
String foodName = "";
String quantity = "";

//ignore: must_be_immutable
class AddNewFoodPage extends StatefulWidget {
  String callingText;
  AddNewFoodPage({Key? key, required this.callingText}) : super(key: key);
  @override
  _AddNewFoodPageState createState() => _AddNewFoodPageState();
}

class _AddNewFoodPageState extends State<AddNewFoodPage> {
  String dropdownValue = 'piece';
  final foodnameController = TextEditingController();
  final carboController = TextEditingController();
  final proteinController = TextEditingController();
  final fatController = TextEditingController();
  final servingsController = TextEditingController();
  final caloriesController = TextEditingController();
  final sugarsController = TextEditingController();
  final cholesterolController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text("Add New Food"),
        backgroundColor: Colors.cyan,
        elevation: 1,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.white54),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.all(1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[],
              ),
            ),
            const SizedBox(height: 13),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.text,
                                      controller: foodnameController,
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.fastfood),
                                        hintText: "Enter Food Name",
                                        hintStyle:
                                            TextStyle(color: Colors.black45),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: const EdgeInsets.all(0),
                                        child: TextFormField(
                                          controller: servingsController,
                                          keyboardType: TextInputType.text,
                                          decoration: const InputDecoration(
                                            prefixIcon: Icon(Icons.food_bank),
                                            hintText: 'Servings',
                                            hintStyle: TextStyle(
                                                color: Colors.black45),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 8.0),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: DropdownButton<String>(
                                    value: dropdownValue,
                                    icon: const Icon(
                                        Icons.arrow_drop_down_circle_outlined),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.black),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownValue = newValue!;
                                      });
                                    },
                                    items: <String>['piece', 'cups']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () async {
                                // httprequest("1 cup rice");// for test
                                httprequest(
                                    "${servingsController.text} $dropdownValue ${foodnameController.text}");
                              },
                              child: Container(
                                height: 50,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 75),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.cyan.shade500,
                                    border: Border.all(color: Colors.black12),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black26,
                                          spreadRadius: 1,
                                          blurRadius: 4)
                                    ]),
                                child: const Center(
                                  child: Text(
                                    "Get Data",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(0),
                                    child: TextFormField(
                                      controller: caloriesController,
                                      keyboardType: const TextInputType
                                          .numberWithOptions(),
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.rice_bowl),
                                        hintText:
                                            'Enter Calories Intake (in Kcal)',
                                        hintStyle:
                                            TextStyle(color: Colors.black45),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(0),
                                    child: TextFormField(
                                      controller: carboController,
                                      keyboardType: const TextInputType
                                          .numberWithOptions(),
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.rice_bowl),
                                        hintText:
                                            'Enter Carbohydrate (in grams)',
                                        hintStyle:
                                            TextStyle(color: Colors.black45),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(0),
                                    child: TextFormField(
                                      controller: proteinController,
                                      keyboardType: const TextInputType
                                          .numberWithOptions(),
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.rice_bowl),
                                        hintText: 'Enter Protein (in grams)',
                                        hintStyle:
                                            TextStyle(color: Colors.black45),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(0),
                                    child: TextFormField(
                                      controller: fatController,
                                      keyboardType: const TextInputType
                                          .numberWithOptions(),
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.rice_bowl),
                                        hintText: 'Enter Fat (in grams)',
                                        hintStyle:
                                            TextStyle(color: Colors.black45),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(0),
                                    child: TextFormField(
                                      controller: cholesterolController,
                                      keyboardType: const TextInputType
                                          .numberWithOptions(),
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.rice_bowl),
                                        hintText:
                                            'Enter Cholesterol (in grams)',
                                        hintStyle:
                                            TextStyle(color: Colors.black45),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(0),
                                    child: TextFormField(
                                      controller: sugarsController,
                                      keyboardType: const TextInputType
                                          .numberWithOptions(),
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.rice_bowl),
                                        hintText: 'Enter Sugars (in grams)',
                                        hintStyle:
                                            TextStyle(color: Colors.black45),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          updateData();
                          user = auth.currentUser!;
                          FirebaseFirestore.instance
                              .collection('userdata')
                              .doc(user.uid)
                              .collection('food_track')
                              .doc(formattedDate)
                              .collection(widget.callingText)
                              .get()
                              .then((querySnapshot) {
                            for (var result in querySnapshot.docs) {
                              result = result;
                            }
                          });
                          Fluttertoast.showToast(
                              msg: "Saved Food Nutrients Data",
                              gravity: ToastGravity.TOP);
                        },
                        child: Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 75),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.cyan.shade500,
                              border: Border.all(color: Colors.black12),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black26,
                                    spreadRadius: 1,
                                    blurRadius: 4)
                              ]),
                          child: const Center(
                            child: Text(
                              "Save",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> httprequest(String name) async {
    log("request is $name");
    // dio.options.headers['x-app-id'] = dotenv.env['APP_ID'];
    // dio.options.headers["x-app-key"] = dotenv.env['APP_KEY'];
    dio.options.headers['x-app-id'] = "8b70f96e";
    dio.options.headers["x-app-key"] = "b6f1d1b83b52aafd7af6f59690f94724";
    try {
      response = await dio.post(
          'https://trackapi.nutritionix.com/v2/natural/nutrients',
          data: {'query': name});
      log("response is $response");
      log("response is ${response!.data}");
      log("response is ${response!.statusCode}");
    } catch (e) {
      log("Error: $e");
      log("response is $response");
      log("response is $response");

      log("response is ${response?.data}");
      log("response is ${response?.statusCode}");
      Fluttertoast.showToast(
          msg: 'Food not found. Please enter the data yourself',
          gravity: ToastGravity.TOP);
      return;
    }
    foodName = response?.data['foods'][0]['food_name'].toString() ?? "";
    calories = response?.data['foods'][0]['nf_calories'].toString() ?? "1";
    carbo =
        response?.data['foods'][0]['nf_total_carbohydrate'].toString() ?? "1";
    protein = response?.data['foods'][0]['nf_protein'].toString() ?? "1";
    fat = response?.data['foods'][0]['nf_total_fat'].toString() ?? "1";
    cholesterol = (double.parse(
                response?.data['foods'][0]['nf_cholesterol'].toString() ??
                    "1") /
            1000)
        .toString();
    sugars = response?.data['foods'][0]['nf_sugars'].toString() ?? "1";
    if (response?.statusCode == 200) {
      setState(() {
        foodName = foodnameController.text;
        quantity = servingsController.text;
        carboController.text = carbo;
        proteinController.text = protein;
        fatController.text = fat;
        caloriesController.text = calories;
        sugarsController.text = sugars;
        cholesterolController.text = cholesterol;
      });
    }
  }

  Future<void> updateData() async {
    user = auth.currentUser!;
    if (widget.callingText == "dinner") {
      await DatabaseService(uid: user.uid).updateFoodDataDinner(foodName,
          calories, carbo, protein, fat, sugars, cholesterol, quantity);
    }
    if (widget.callingText == "lunch") {
      await DatabaseService(uid: user.uid).updateFoodDataLunch(foodName,
          calories, carbo, protein, fat, sugars, cholesterol, quantity);
    }
    if (widget.callingText == "snack") {
      await DatabaseService(uid: user.uid).updateFoodDataSnack(foodName,
          calories, carbo, protein, fat, sugars, cholesterol, quantity);
    }
    if (widget.callingText == "breakfast") {
      await DatabaseService(uid: user.uid).updateFoodDataBreakfast(foodName,
          calories, carbo, protein, fat, sugars, cholesterol, quantity);
    }
  }
}
