import 'package:calories_mate/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:calories_mate/services/locator.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:calories_mate/screens/splashscreen.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Splashscreen(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
