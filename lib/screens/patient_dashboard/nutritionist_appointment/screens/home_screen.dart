import 'package:calories_mate/screens/chat/chat_with.dart';
import 'package:calories_mate/screens/patient_dashboard/nutritionist_appointment/components/doctor_card.dart';
import 'package:calories_mate/screens/patient_dashboard/nutritionist_appointment/screens/nutritionist_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:calories_mate/screens/patient_dashboard/nutritionist_appointment/components/category_card.dart';
import 'package:calories_mate/screens/patient_dashboard/nutritionist_appointment/components/search_bar.dart';
import 'package:get/get.dart';
import '../constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nutritionist\'s Appointment',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.cyan,
        elevation: 1,
      ),
      floatingActionButton: SafeArea(
        child: GestureDetector(
          onTap: () {
            Get.to(() => const ChatWith());
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 70),
            padding: const EdgeInsets.all(15),
            decoration:
                const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
            child: const Icon(
              Icons.chat,
              color: Colors.white,
            ),
          ),
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Find Your Desired\nNutritionist',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: CustomSearchBar(),
              ),
              const SizedBox(
                height: 20,
              ),
              //  const SizedBox(
              //   height: 20,
              // ),
              // buildCategoryList(),
              // const SizedBox(
              //   height: 20,
              // ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Top Nutritionists',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              buildNutritionistList(),
            ],
          ),
        ),
      ),
    );
  }

  buildCategoryList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          const SizedBox(
            width: 30,
          ),
          CategoryCard('Psychiatrist', 'assets/icons/psychiatrist.png',
              kOrangeColor, 'Psychiatrist'),
          const SizedBox(
            width: 10,
          ),
          CategoryCard('Dental\nSurgeon', 'assets/icons/dental_surgeon.png',
              kBlueColor, 'Dental'),
          const SizedBox(
            width: 10,
          ),
          CategoryCard('Heart\nSurgeon', 'assets/icons/heart_surgeon.png',
              kYellowColor, 'Heart Surgeon'),
          const SizedBox(
            width: 10,
          ),
          CategoryCard('Eye\nSpecialist', 'assets/icons/eye_specialist.png',
              kOrangeColor, 'Eye Specialist'),
          const SizedBox(
            width: 30,
          ),
        ],
      ),
    );
  }

  List<NutritionistModel> nutritionists = [
    NutritionistModel("", "", "", "", "", "")
  ];
  buildNutritionistList() {
    nutritionists.removeAt(0);
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('userdata').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            for (var element in snapshot.data!.docs) {
              try {
                if (element['type'] == "nutritionist") {
                  nutritionists.add(NutritionistModel(
                      element.id,
                      element['name'],
                      element['specialization'],
                      element['phone'],
                      element['hospital'],
                      element['about']));
                }
              } catch (e) {
                continue;
              }
            }
          }
          return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Column(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount:
                        (nutritionists.length <= 3) ? nutritionists.length : 3,
                    itemBuilder: (context, index) {
                      return Column(
                        children: (snapshot.data != null)
                            ? ([
                                NutritionistCard(
                                  nutritionists[index].uid,
                                  nutritionists[index].displayName,
                                  "${nutritionists[index].specialization!}-${nutritionists[index].hospital!}",
                                  (index % 2 == 0) ? kBlueColor : kYellowColor,
                                  nutritionists[index].bio,
                                ),
                                const SizedBox(
                                  height: 10,
                                )
                              ])
                            : ([const CircularProgressIndicator()]),
                      );
                    },
                  ),
                  const SizedBox(height: 80),
                ],
              ));
        });
  }

  getNutritionists() async {
    setState(() {});
    FirebaseFirestore.instance
        .collection('userdata')
        .snapshots()
        .listen((event) {
      for (var element in event.docs) {
        try {
          if (element['type'] == "nutritionist") {
            nutritionists.add(NutritionistModel(
                element.id,
                element['name'],
                element['specialization'],
                element['phone'],
                element['hospital'],
                element['about']));
          }
        } catch (e) {
          continue;
        }
      }
    });
  }
}
