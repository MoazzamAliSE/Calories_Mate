
import 'package:flutter/material.dart';
import 'package:calories_mate/screens/patient_dashboard/nutritionist_appointment/screens/detail_screen.dart';

import '../constant.dart';
BuildContext? cardContext;
//ignore: must_be_immutable
class NutritionistCard extends StatelessWidget {
  final String? _uid;
  final String? _name;
  final String? _description;
  final String? _bio;
  final dynamic _bgColor;

  const NutritionistCard(
      this._uid, this._name, this._description, this._bgColor, this._bio,
      {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                DetailScreen(_name, _description, _uid, _bio)));
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _bgColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            leading: Image.asset('assets/images/nutritionist1.png'),
            title: Text(
              _name!,
              style: TextStyle(
                color: kTitleTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              _description!,
              style: TextStyle(
                color: kTitleTextColor.withOpacity(0.7),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
