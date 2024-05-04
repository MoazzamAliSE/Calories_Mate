import 'dart:io';
import 'package:calories_mate/screens/Settings_Pages/settings.dart';
import 'package:calories_mate/screens/chat/chat_with.dart';
import 'package:calories_mate/screens/patient_dashboard/nutritionist_appointment/screens/nutritionist_appointment.dart';
import 'package:calories_mate/screens/patient_dashboard/training/training_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'fitness_app_theme.dart';
import 'models/tab_icon_data.dart';
import 'my_diary/my_diary_screen.dart';

class FitnessAppHomeScreen extends StatefulWidget {
  const FitnessAppHomeScreen({Key? key}) : super(key: key);

  @override
  _FitnessAppHomeScreenState createState() => _FitnessAppHomeScreenState();
}

class _FitnessAppHomeScreenState extends State<FitnessAppHomeScreen> {
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  int indexAdopted = 0;
   Widget tabBody=MyDiaryScreen();

  @override
  void initState() {
    super.initState();
    initializeTabBody();
  }

  void initializeTabBody() {
    for (var tab in tabIconsList) {
      tab.isSelected = false;
    }
    tabBody = const MyDiaryScreen();
    tabIconsList[0].isSelected = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (indexAdopted == 0) {
            if (Platform.isAndroid) {
              SystemNavigator.pop();
            } else if (Platform.isIOS) {
              exit(0);
            }
          } else {
            Get.off(() => const FitnessAppHomeScreen());
          }
          return false;
        },
        child: Stack(
          children: <Widget>[
            tabBody,
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 62 + MediaQuery.of(context).padding.bottom,
                decoration: BoxDecoration(
                  color: FitnessAppTheme.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(0, -2),
                      blurRadius: 8.0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      tabIconsList.length,
                      (index) {
                        final tabIconData = tabIconsList[index];
                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                indexAdopted = index;
                                tabBody = _getSelectedTabBody(index);
                              });
                            },
                            child: TabIcon(
                              tabIconData: tabIconData,
                              isSelected: index == indexAdopted,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 28.0,
              left: MediaQuery.of(context).size.width / 2 - 28.0,
              child: GestureDetector(
                onTap: () {
                  Get.to(() => const ChatWith());
                },
                child: Container(
                  width: 56.0,
                  height: 56.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: FitnessAppTheme.nearlyDarkBlue,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        offset: const Offset(0, 4),
                        blurRadius: 8.0,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.message,
                    color: FitnessAppTheme.white,
                    size: 32.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getSelectedTabBody(int index) {
    switch (index) {
      case 0:
        return const MyDiaryScreen();
      case 1:
        return const TrainingScreen();
      case 2:
        return const NutritionistAppointment();
      case 3:
        return const SettingsPage(role: "patient");
      default:
        return const SizedBox();
    }
  }
}

class TabIcon extends StatelessWidget {
  final TabIconData tabIconData;
  final bool isSelected;

  const TabIcon({
    Key? key,
    required this.tabIconData,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          isSelected ? tabIconData.selectedImagePath : tabIconData.imagePath,
          width: 30.0,
          height: 30.0,
          color: isSelected ? FitnessAppTheme.nearlyDarkBlue : null,
        ),
      ],
    );
  }
}
