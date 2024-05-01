import 'package:calories_mate/screens/patient_dashboard/nutritionist_appointment/components/doctor_card.dart';
import 'package:calories_mate/screens/patient_dashboard/nutritionist_appointment/screens/nutritionist_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../constant.dart';

class NutritionistsList extends StatefulWidget {
  final String role;
  const NutritionistsList({Key? key, required this.role}) : super(key: key);

  @override
  _NutritionistsListState createState() => _NutritionistsListState();
}

class _NutritionistsListState extends State<NutritionistsList> {
  List<NutritionistModel> nutritionistsCategory = [
    NutritionistModel("", "", "", "", "", "")
  ];
  @override
  Widget build(BuildContext context) {
    nutritionistsCategory.removeAt(0);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.role),
        backgroundColor: Colors.cyan,
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('userdata').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  for (var element in snapshot.data!.docs) {
                    try {
                      if (element['type'] == "nutritionist" &&
                          element['specialization'] == widget.role) {
                        nutritionistsCategory.add(NutritionistModel(
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
                return Column(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: nutritionistsCategory.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: (snapshot.data != null)
                              ? ([
                                  NutritionistCard(
                                    nutritionistsCategory[index].uid,
                                    nutritionistsCategory[index].displayName,
                                    "${nutritionistsCategory[index].specialization!}-${nutritionistsCategory[index].hospital!}",
                                    (index % 2 == 0)
                                        ? kBlueColor
                                        : kYellowColor,
                                    nutritionistsCategory[index].bio,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  )
                                ])
                              : ([const CircularProgressIndicator()]),
                        );
                      },
                    ),
                    const SizedBox(height: 70),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
