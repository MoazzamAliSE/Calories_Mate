import 'package:flutter/material.dart';
import '../fitness_app_theme.dart';

class AreaListView extends StatelessWidget {
  AreaListView({Key? key}) : super(key: key);

  final List<String> areaListData = [
    'assets/fitness_app/area1.png',
    'assets/fitness_app/area2.png',
    'assets/fitness_app/area3.png',
    'assets/fitness_app/area1.png',
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: GridView(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: 16,
          ),
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 24.0,
            crossAxisSpacing: 24.0,
            childAspectRatio: 1.0,
          ),
          children: List<Widget>.generate(
            areaListData.length,
            (int index) {
              return AreaView(imagepath: areaListData[index]);
            },
          ),
        ),
      ),
    );
  }
}

class AreaView extends StatelessWidget {
  const AreaView({Key? key, this.imagepath}) : super(key: key);

  final String? imagepath;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FitnessAppTheme.white,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: FitnessAppTheme.grey.withOpacity(0.4),
            offset: const Offset(1.1, 1.1),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          splashColor: FitnessAppTheme.nearlyDarkBlue.withOpacity(0.2),
          onTap: () {},
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: Image.asset(imagepath!),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
