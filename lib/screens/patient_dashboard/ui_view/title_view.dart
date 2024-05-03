import 'package:flutter/material.dart';
import 'package:calories_mate/screens/patient_dashboard/BodyMesurment/input.dart';
import 'package:calories_mate/screens/patient_dashboard/Meals/meals_today.dart';
import 'package:calories_mate/screens/patient_dashboard/MediterranDiet/diet.dart';
import 'package:calories_mate/screens/patient_dashboard/water/water_taken.dart';
import '../fitness_app_theme.dart';

class TitleView extends StatelessWidget {
  final String titleTxt;
  final String subTxt;
  final int index;

  const TitleView({
    Key? key,
    this.titleTxt = "",
    this.subTxt = "",
    this.index = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              titleTxt,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontFamily: FitnessAppTheme.fontName,
                fontWeight: FontWeight.w500,
                fontSize: 18,
                letterSpacing: 0.5,
                color: FitnessAppTheme.lightText,
              ),
            ),
          ),
          InkWell(
            highlightColor: Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                switch (index) {
                  case 0:
                    return const Diet();
                  case 1:
                    return const Meals();
                  case 2:
                    return const InputPage();
                  default:
                    return const WaterTaken();
                }
              }));
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                children: <Widget>[
                  Text(
                    subTxt,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontFamily: FitnessAppTheme.fontName,
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      letterSpacing: 0.5,
                      color: FitnessAppTheme.nearlyDarkBlue,
                    ),
                  ),
                  const SizedBox(
                    height: 38,
                    width: 26,
                    child: Icon(
                      Icons.arrow_forward,
                      color: FitnessAppTheme.darkText,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
