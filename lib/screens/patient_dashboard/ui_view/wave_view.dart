import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../fitness_app_theme.dart';

class WaveView extends StatelessWidget {
  final double percentageValue;

  const WaveView({Key? key, this.percentageValue = 100.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: WaveClipper(),
            child: Container(
              decoration: BoxDecoration(
                color: FitnessAppTheme.nearlyDarkBlue.withOpacity(0.5),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(80.0),
                  bottomLeft: Radius.circular(80.0),
                  bottomRight: Radius.circular(80.0),
                  topRight: Radius.circular(80.0),
                ),
                gradient: LinearGradient(
                  colors: [
                    FitnessAppTheme.nearlyDarkBlue.withOpacity(0.2),
                    FitnessAppTheme.nearlyDarkBlue.withOpacity(0.5),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          ClipPath(
            clipper: WaveClipper(),
            child: Container(
              decoration: BoxDecoration(
                color: FitnessAppTheme.nearlyDarkBlue,
                gradient: LinearGradient(
                  colors: [
                    FitnessAppTheme.nearlyDarkBlue.withOpacity(0.4),
                    FitnessAppTheme.nearlyDarkBlue,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(80.0),
                  bottomLeft: Radius.circular(80.0),
                  bottomRight: Radius.circular(80.0),
                  topRight: Radius.circular(80.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 48),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  (percentageValue.round() >= 100)
                      ? const Icon(
                          Icons.check_circle,
                          color: CupertinoColors.white,
                          size: 30,
                        )
                      : Text(
                          (percentageValue.round() >= 100)
                              ? "100"
                              : percentageValue.round().toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: FitnessAppTheme.fontName,
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                            letterSpacing: 0.0,
                            color: FitnessAppTheme.white,
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: Text(
                      (percentageValue.round() >= 100) ? "" : '%',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: FitnessAppTheme.fontName,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        letterSpacing: 0.0,
                        color: FitnessAppTheme.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 6,
            bottom: 8,
            child: Container(
              width: 2,
              height: 2,
              decoration: BoxDecoration(
                color: FitnessAppTheme.white.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: 24,
            right: 0,
            bottom: 16,
            child: Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color: FitnessAppTheme.white.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 24,
            bottom: 32,
            child: Container(
              width: 3,
              height: 3,
              decoration: BoxDecoration(
                color: FitnessAppTheme.white.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 20,
            bottom: 0,
            child: Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color: FitnessAppTheme.white.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1,
                child: Image.asset("assets/fitness_app/bottle.png"),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0.0, size.height);
    path.lineTo(0.0, size.height * 0.5);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.25,
      size.width * 0.5,
      size.height * 0.5,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.75,
      size.width,
      size.height * 0.5,
    );
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(WaveClipper oldClipper) => false;
}
