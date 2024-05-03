import 'package:calories_mate/screens/patient_dashboard/my_diary/water_view.dart';
import 'package:calories_mate/screens/patient_dashboard/ui_view/body_measurement.dart';
import 'package:calories_mate/screens/patient_dashboard/ui_view/glass_view.dart';
import 'package:calories_mate/screens/patient_dashboard/ui_view/mediterranean_diet_view.dart';
import 'package:calories_mate/screens/patient_dashboard/ui_view/title_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../fitness_app_theme.dart';
import 'meals_list_view.dart';

var now = DateTime.now();
var formatter = DateFormat('yyyy-MM-dd');
String formattedDate = formatter.format(now);

class MyDiaryScreen extends StatefulWidget {
  const MyDiaryScreen({
    Key? key,
  }) : super(key: key);

  @override
  _MyDiaryScreenState createState() => _MyDiaryScreenState();
}

class _MyDiaryScreenState extends State<MyDiaryScreen> {
  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;
  final df = DateFormat('dd-MMM-yyyy');

  @override
  void initState() {
    addAllListData();

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });

    super.initState();
    formattedDate = formatter.format(now);
  }

  void addAllListData() {
    const int count = 9;

    listViews.add(
      const MediterranesnDietView(),
    );
    listViews.add(
      const TitleView(
        titleTxt: 'Meals today',
        subTxt: 'Set Target',
        index: 1,
      ),
    );

    listViews.add(
      const MealsListView(),
    );

    listViews.add(
      const TitleView(
        titleTxt: 'Body measurement',
        subTxt: 'Today',
        index: 2,
      ),
    );

    listViews.add(
      const BodyMeasurementView(),
    );
    listViews.add(
      const TitleView(
        titleTxt: 'Water',
        subTxt: 'Aqua SmartBottle',
        index: 3,
      ),
    );

    listViews.add(
      const WaterView(),
    );
    listViews.add(
      const GlassView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            getAppBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return ListView.builder(
      controller: scrollController,
      padding: EdgeInsets.only(
        top: AppBar().preferredSize.height +
            MediaQuery.of(context).padding.top +
            24,
        bottom: 62 + MediaQuery.of(context).padding.bottom,
      ),
      itemCount: listViews.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return listViews[index];
      },
    );
  }

  Widget getAppBarUI() {
    DateTime added;
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: FitnessAppTheme.white.withOpacity(topBarOpacity),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(32.0),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: FitnessAppTheme.grey.withOpacity(0.4 * topBarOpacity),
                  offset: const Offset(1.1, 1.1),
                  blurRadius: 10.0),
            ],
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16 - 8.0 * topBarOpacity,
                    bottom: 12 - 8.0 * topBarOpacity),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'My Diary',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: FitnessAppTheme.fontName,
                            fontWeight: FontWeight.w700,
                            fontSize: 22 + 6 - 6 * topBarOpacity,
                            letterSpacing: 1.2,
                            color: FitnessAppTheme.darkerText,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 38,
                      width: 38,
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(32.0)),
                        onTap: () {
                          added = DateFormat('yyyy-MM-dd').parse(formattedDate);
                          formattedDate = DateFormat('yyyy-MM-dd').format(
                              DateTime(added.year, added.month, added.day - 1));
                          rebuildAllChildren(context);
                        },
                        child: const Center(
                          child: Icon(
                            Icons.keyboard_arrow_left,
                            color: FitnessAppTheme.grey,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                        right: 8,
                      ),
                      child: InkWell(
                        onTap: () {
                          showDatePicker(
                            context: context,
                            builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  primaryColor: Colors.cyan,
                                  buttonTheme: const ButtonThemeData(
                                      textTheme: ButtonTextTheme.primary),
                                  colorScheme: const ColorScheme.light(
                                    primary: Colors.cyan,
                                  ).copyWith(secondary: Colors.cyan),
                                ),
                                child: child!,
                              );
                            },
                            initialDate:
                                DateFormat('yyyy-MM-dd').parse(formattedDate),
                            firstDate: DateTime(2019, 1),
                            lastDate: DateTime.now(),
                          ).then((date) {
                            setState(() {
                              if (date != null) {
                                formattedDate =
                                    DateFormat('yyyy-MM-dd').format(date!);
                                rebuildAllChildren(context);
                              } else {
                                date = DateFormat('yyyy-MM-dd')
                                    .parse(formattedDate);
                                rebuildAllChildren(context);
                              }
                            });
                          });
                        },
                        child: Row(
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Icon(
                                Icons.calendar_today,
                                color: FitnessAppTheme.grey,
                                size: 18,
                              ),
                            ),
                            Text(
                              " ${DateFormat('yyyy-MM-dd').parse(formattedDate).day} ${df.format(DateFormat('yyyy-MM-dd').parse(formattedDate)).substring(3, 6)}",
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontFamily: FitnessAppTheme.fontName,
                                fontWeight: FontWeight.normal,
                                fontSize: 18,
                                letterSpacing: -0.2,
                                color: FitnessAppTheme.darkerText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 38,
                      width: 38,
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(32.0)),
                        onTap: () {
                          if (formattedDate != formatter.format(now)) {
                            added =
                                DateFormat('yyyy-MM-dd').parse(formattedDate);
                            formattedDate = DateFormat('yyyy-MM-dd').format(
                                DateTime(
                                    added.year, added.month, added.day + 1));
                            rebuildAllChildren(context);
                          }
                        },
                        child: Center(
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            color: (formattedDate != formatter.format(now))
                                ? FitnessAppTheme.grey
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }
}
