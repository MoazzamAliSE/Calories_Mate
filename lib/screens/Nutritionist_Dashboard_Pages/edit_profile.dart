import 'dart:io';
import 'package:calories_mate/screens/dashboard_nutritionist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:calories_mate/screens/patient_dashboard/fitness_app_theme.dart';
import 'package:calories_mate/services/database.dart';
import 'package:calories_mate/services/locator.dart';
import 'package:calories_mate/services/user_controller.dart';

class NutritionistProfile extends StatefulWidget {
  const NutritionistProfile({Key? key}) : super(key: key);

  @override
  _NutritionistProfileState createState() => _NutritionistProfileState();
}

XFile? image;

class _NutritionistProfileState extends State<NutritionistProfile> {
  String name = "";
  String specialization = "";
  String hospital = "";
  String email = "";
  String phoneNumber = "";
  String about = "";
  String username = "";
  // Uint8List? imageBytes;
  // Uint8List? newBytes;
  // bool picked = false;
  var nameController = TextEditingController();
  var specializationController = TextEditingController();
  var hospitalController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var aboutController = TextEditingController();
  var usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: FitnessAppTheme.background,
        appBar: AppBar(
          title: const Text(
            'Profile',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.cyan,
          elevation: 0.0,
          bottomOpacity: 0.0,
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
            stream:
                FirebaseFirestore.instance.collection('userdata').snapshots(),
            builder: (context, snapshot) {
              var sn = snapshot.data;
              if (sn != null) {
                for (var element in sn.docs) {
                  if (element.id == activeNutritionist.uid) {
                    try {
                      name = element.get("name");
                      email = element.get("email");
                      username = element.get("username");
                    } catch (e) {
                      name = "";
                      email = "";
                      username = "";
                    }
                    try {
                      specialization = element.get("specialization");
                    } catch (e) {
                      specialization = "";
                    }
                    try {
                      hospital = element.get("hospital");
                    } catch (e) {
                      hospital = "";
                    }
                    try {
                      about = element.get("about");
                    } catch (e) {
                      about = "";
                    }
                    try {
                      phoneNumber = element.get("phone");
                    } catch (e) {
                      phoneNumber = "";
                    }
                  }
                }
              }
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
                      elevation: 5,
                      color: Colors.cyan,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50)),
                      child: Container(
                        padding:
                            const EdgeInsets.only(left: 16, top: 6, right: 16),
                        child: Column(
                          children: <Widget>[
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Complete your Profile",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "Add your Name, Specification and Bio to let "
                                "people know who you are.",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     InkWell(
                            //       onTap: () async {
                            //         image = await picker.pickImage(
                            //             source: ImageSource.gallery,
                            //             imageQuality: 80);
                            //         if (image != null) {
                            //           newBytes = File(image!.path)
                            //               .readAsBytesSync();
                            //           setState(() {
                            //             picked = true;
                            //           });
                            //         }
                            //       },
                            //       child: (picked)
                            //           ? CircleAvatar(
                            //               radius: 60.0,
                            //               backgroundImage:
                            //                   Image.memory(newBytes!)
                            //                       .image,
                            //               child: addIcon(),
                            //             )
                            //           : (imageBytes != null)
                            //               ? CircleAvatar(
                            //                   radius: 60.0,
                            //                   backgroundImage:
                            //                       Image.memory(
                            //                               imageBytes!)
                            //                           .image,
                            //                   child: addIcon(),
                            //                 )
                            //               : const CircleAvatar(
                            //                   radius: 60.0,
                            //                   child: Icon(
                            //                       Icons.photo_camera),
                            //                 ),
                            //     ),
                            //   ],
                            // ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                child: TextField(
                                  controller: nameController..text = name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  decoration: const InputDecoration(
                                    fillColor: Colors.white,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    hintText: "Enter your full name",
                                    prefixText: "Dr. ",
                                    prefixStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                    icon: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 30),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Username"),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20))),
                            child: TextField(
                              controller: usernameController..text = username,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter you username"),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Specialization"),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20))),
                            child: TextField(
                              controller: specializationController
                                ..text = specialization,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter specialization",
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Hospital"),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20))),
                            child: TextField(
                              controller: hospitalController..text = hospital,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter hospital",
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("E-mail"),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20))),
                            child: TextField(
                              controller: emailController..text = email,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter email",
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Phone number"),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20))),
                            child: TextField(
                              controller: phoneController..text = phoneNumber,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter phone number",
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Bio"),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20))),
                            child: TextField(
                              controller: aboutController..text = about,
                              maxLines: 5,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText:
                                    "Tell us something about your experience",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              updateUser();
                              if (image != null) {
                                locator
                                    .get<UserController>()
                                    .uploadProfilePicture(File(image!.path));
                              }
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    WidgetStateProperty.all<Color>(Colors.cyan),
                                shape: WidgetStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: const BorderSide(
                                            color: Colors.cyan)))),
                            child: Text("Update Profile".toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.white))),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            }));
  }

  void updateUser() async {
    await DatabaseService(uid: activeNutritionist.uid)
        .updateNutritionistUserData(
      nameController.text,
      usernameController.text,
      emailController.text,
      specializationController.text,
      hospitalController.text,
      phoneController.text,
      aboutController.text,
      "nutritionist",
    );

    Get.back();
  }

  void rebuildAll(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  // loadProfilePic() async {
  //   final FirebaseStorage firebaseStorage = FirebaseStorage.instanceFor(
  //       bucket: "gs://mental-health-e175a.appspot.com");
  //   await firebaseStorage
  //       .ref()
  //       .child("user/profile/${activeNutritionist.uid}")
  //       .getData(100000000)
  //       .then((value) => {imageBytes = value!});
  //   return 1;
  // }

  Widget addIcon() {
    return const Align(
      alignment: Alignment.bottomRight,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 12.0,
        child: Icon(
          Icons.camera_alt,
          size: 15.0,
          color: Colors.black,
        ),
      ),
    );
  }
}
