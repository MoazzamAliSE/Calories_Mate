import 'package:calories_mate/screens/patient_dashboard/nutritionist_appointment/components/doctor_card.dart';
import 'package:calories_mate/screens/patient_dashboard/nutritionist_appointment/screens/nutritionist_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constant.dart';

class SearchResult extends StatefulWidget {
  final String searchText;
  const SearchResult({Key? key, required this.searchText}) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  String searchText = "";
  var searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    searchText = widget.searchText;
  }

  List<NutritionistModel> nutritionists = [
    NutritionistModel("", "", "", "", "", "")
  ];
  List<NutritionistModel> filteredNutritionistsList = [
    NutritionistModel("", "", "", "", "", "")
  ];
  dynamic dataList;
  @override
  Widget build(BuildContext context) {
    filteredNutritionistsList.removeAt(0);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search results"),
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
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('userdata').snapshots(),
          builder: (context, snapshot) {
            nutritionists.clear();
            filteredNutritionistsList.clear();
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
            dataList = nutritionists.where((row) => (row.displayName!
                .toLowerCase()
                .contains(searchText.toLowerCase())));
            dataList.forEach((element) {
              filteredNutritionistsList.add(element);
            });
            return SingleChildScrollView(
              child: Column(
                children: [
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: 52,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: kSearchBackgroundColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextField(
                            controller: searchController..text = searchText,
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Search for nutritionists',
                            ),
                            onChanged: (value) {
                              searchText = value;
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: MaterialButton(
                            onPressed: () {
                              search(searchText);
                            },
                            color: Colors.cyan,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: SvgPicture.asset('assets/icons/search.svg'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: filteredNutritionistsList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: (snapshot.data != null)
                            ? ([
                                NutritionistCard(
                                  filteredNutritionistsList[index].uid,
                                  filteredNutritionistsList[index].displayName,
                                  "${filteredNutritionistsList[index].specialization!}-${filteredNutritionistsList[index].hospital!}",
                                  (index % 2 == 0) ? kBlueColor : kYellowColor,
                                  filteredNutritionistsList[index].bio,
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
              ),
            );
          }),
    );
  }

  void search(String text) {
    nutritionists = [NutritionistModel("", "", "", "", "", "")];
    filteredNutritionistsList = [NutritionistModel("", "", "", "", "", "")];
    setState(() {
      searchText = text;
    });
  }
}
