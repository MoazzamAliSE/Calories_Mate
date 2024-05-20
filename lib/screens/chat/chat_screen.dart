import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:calories_mate/file_services.dart';
import 'package:calories_mate/screens/patient_dashboard/fitness_app_theme.dart';
import 'package:calories_mate/screens/splashscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {super.key, required this.name, required this.uid, required this.email});

  final String name;
  final String uid;
  final String email;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
  }

  final ScrollController controller = ScrollController();

  final TextEditingController msg = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: FitnessAppTheme.cyan,
        elevation: 3,
        centerTitle: true,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection(widget.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                }
                List<Map<String, dynamic>>? messages = snapshot.data?.docs
                    .map((e) => {
                          'type': e.get('type'),
                          'status': e.get('status'),
                          'msg': e.get('msg'),
                          'time': e.get('time'),
                          'sender': e.get('sender')
                        })
                    .toList();

                if (messages == null || messages.isEmpty) {
                  return Container();
                }

                Timer(
                  const Duration(
                    milliseconds: 100,
                  ),
                  () {
                    controller.jumpTo(controller.position.maxScrollExtent);
                  },
                );

                return ListView.builder(
                  controller: controller,
                  padding: const EdgeInsets.only(top: 10),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return messages[index]['sender'] == widget.uid
                        ? Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 70, top: 10),
                              child: messages[index]['type'] == 'text'
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          messages[index]['msg'].toString(),
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        Text(
                                          messages[index]['time'].toString(),
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                      ],
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: messages[index]['type'] == 'image'
                                          ? messages[index]['status'] ==
                                                  'loading'
                                              ? Container(
                                                  height: 200,
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                      color: Colors.black
                                                          .withOpacity(.04),
                                                      border: Border.all(
                                                          color:
                                                              Colors.black12)),
                                                  alignment: Alignment.center,
                                                  child: const Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      CircularProgressIndicator(
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        'Loading',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : messages[index]['status'] ==
                                                      'error'
                                                  ? Container(
                                                      height: 200,
                                                      width: 200,
                                                      decoration: BoxDecoration(
                                                          color: Colors.black
                                                              .withOpacity(.04),
                                                          border: Border.all(
                                                              color: Colors
                                                                  .black12)),
                                                      alignment:
                                                          Alignment.center,
                                                      child: const Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            'Error! Please send again',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  : GestureDetector(
                                                      onTap: () {
                                                        showGeneralDialog(
                                                          barrierColor:
                                                              Colors.black,
                                                          transitionDuration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      100),
                                                          barrierDismissible:
                                                              true,
                                                          barrierLabel:
                                                              'Barrier',
                                                          context: context,
                                                          pageBuilder: (context,
                                                              animation,
                                                              secondaryAnimation) {
                                                            return Center(
                                                              child: Hero(
                                                                tag:
                                                                    'IMAGEVIEW',
                                                                child: Scaffold(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .black,
                                                                  body: Container(
                                                                      color: Colors.black,
                                                                      child: Center(
                                                                          child: CachedNetworkImage(
                                                                        imageUrl:
                                                                            messages[index]['msg'],
                                                                        imageBuilder:
                                                                            (context,
                                                                                imageProvider) {
                                                                          return PhotoView(
                                                                              imageProvider: imageProvider);
                                                                        },
                                                                      ))),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            messages[index]
                                                                ['msg'],
                                                        placeholder:
                                                            (context, url) {
                                                          return Container(
                                                            height: 200,
                                                            width: 200,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        .04),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black12)),
                                                            alignment: Alignment
                                                                .center,
                                                            child: const Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                CircularProgressIndicator(
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  'Loading',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                        imageBuilder: (context,
                                                            imageProvider) {
                                                          return Container(
                                                            height: 200,
                                                            width: 200,
                                                            decoration: BoxDecoration(
                                                                image: DecorationImage(
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    image:
                                                                        imageProvider),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black12)),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .bottomRight,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  bottom: 10,
                                                                  right: 10,
                                                                ),
                                                                child: Text(
                                                                  messages[
                                                                          index]
                                                                      ['time'],
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    )
                                          : const SizedBox(),
                                    ),
                            ),
                          )
                        : Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 70, top: 10),
                              child: messages[index]['type'] == 'text'
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          messages[index]['msg'].toString(),
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        Text(
                                          messages[index]['time'].toString(),
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                      ],
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: messages[index]['type'] == 'image'
                                          ? messages[index]['status'] ==
                                                  'loading'
                                              ? Container(
                                                  height: 200,
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                      color: Colors.black
                                                          .withOpacity(.04),
                                                      border: Border.all(
                                                          color:
                                                              Colors.black12)),
                                                  alignment: Alignment.center,
                                                  child: const Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      CircularProgressIndicator(
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        'Loading',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : messages[index]['status'] ==
                                                      'error'
                                                  ? Container(
                                                      height: 200,
                                                      width: 200,
                                                      decoration: BoxDecoration(
                                                          color: Colors.black
                                                              .withOpacity(.04),
                                                          border: Border.all(
                                                              color: Colors
                                                                  .black12)),
                                                      alignment:
                                                          Alignment.center,
                                                      child: const Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            'Error! Please send again',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  : GestureDetector(
                                                      onTap: () {
                                                        showGeneralDialog(
                                                          barrierColor:
                                                              Colors.black,
                                                          transitionDuration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      100),
                                                          barrierDismissible:
                                                              true,
                                                          barrierLabel:
                                                              'Barrier',
                                                          context: context,
                                                          pageBuilder: (context,
                                                              animation,
                                                              secondaryAnimation) {
                                                            return Center(
                                                              child: Hero(
                                                                tag:
                                                                    'IMAGEVIEW',
                                                                child: Scaffold(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .black,
                                                                  body: Container(
                                                                      color: Colors.black,
                                                                      child: Center(
                                                                          child: CachedNetworkImage(
                                                                        imageUrl:
                                                                            messages[index]['msg'],
                                                                        imageBuilder:
                                                                            (context,
                                                                                imageProvider) {
                                                                          return PhotoView(
                                                                              imageProvider: imageProvider);
                                                                        },
                                                                      ))),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            messages[index]
                                                                ['msg'],
                                                        placeholder:
                                                            (context, url) {
                                                          return Container(
                                                            height: 200,
                                                            width: 200,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        .04),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black12)),
                                                            alignment: Alignment
                                                                .center,
                                                            child: const Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                CircularProgressIndicator(
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  'Loading',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                        imageBuilder: (context,
                                                            imageProvider) {
                                                          return Container(
                                                            height: 200,
                                                            width: 200,
                                                            decoration: BoxDecoration(
                                                                image: DecorationImage(
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    image:
                                                                        imageProvider),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black12)),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .bottomRight,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  bottom: 10,
                                                                  right: 10,
                                                                ),
                                                                child: Text(
                                                                  messages[
                                                                          index]
                                                                      ['time'],
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    )
                                          : const SizedBox(),
                                    ),
                            ));
                  },
                );
              },
            ),
          )),
          Container(
            height: 60,
            width: MediaQuery.sizeOf(context).width,
            decoration:
                BoxDecoration(color: FitnessAppTheme.cyan.withOpacity(.2)),
            child: Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: TextFormField(
                  controller: msg,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type your Message',
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
                )),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                    onTap: () async {
                      final picker = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (picker != null) {
                        final key =
                            DateTime.now().microsecondsSinceEpoch.toString();
                        FirebaseFirestore.instance
                            .collection('chatWith')
                            .doc(widget.uid)
                            .collection('chatWith')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .set({
                          'type': 'image',
                          'name': userName,
                          'uid': FirebaseAuth.instance.currentUser!.uid,
                          'lastMsg': 'Image',
                        });
                        FirebaseFirestore.instance
                            .collection('chatWith')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('chatWith')
                            .doc(widget.uid)
                            .set({
                          'type': 'image',
                          'name': widget.name,
                          'uid': widget.uid,
                          'lastMsg': 'Image',
                        });

                        FirebaseFirestore.instance
                            .collection('chats')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection(widget.uid)
                            .doc(key)
                            .set({
                          'msg': '',
                          'type': 'image',
                          'status': 'loading',
                          'time': DateFormat('h:mm a').format(DateTime.now()),
                          'sender': FirebaseAuth.instance.currentUser!.uid,
                          'id': key
                        });

                        FirebaseFirestore.instance
                            .collection('chats')
                            .doc(widget.uid)
                            .collection(FirebaseAuth.instance.currentUser!.uid)
                            .doc(key)
                            .set({
                          'msg': '',
                          'type': 'image',
                          'status': 'complete',
                          'time': DateFormat('h:mm a').format(DateTime.now()),
                          'sender': FirebaseAuth.instance.currentUser!.uid,
                          'id': key
                        });

                        try {
                          String url = await FileServices.uploadFile(
                              filePath: picker.path,
                              uploadPath:
                                  '/Images/${DateTime.now().microsecondsSinceEpoch.toString()}');
                          await FirebaseFirestore.instance
                              .collection('chats')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection(widget.uid)
                              .doc(key)
                              .update({
                            'msg': url,
                            'type': 'image',
                            'status': 'complete',
                            'time': DateFormat('h:mm a').format(DateTime.now()),
                            'sender': FirebaseAuth.instance.currentUser!.uid,
                            'id': key
                          });
                          await FirebaseFirestore.instance
                              .collection('chats')
                              .doc(widget.uid)
                              .collection(
                                  FirebaseAuth.instance.currentUser!.uid)
                              .doc(key)
                              .update({
                            'msg': url,
                            'type': 'image',
                            'status': 'complete',
                            'time': DateFormat('h:mm a').format(DateTime.now()),
                            'sender': FirebaseAuth.instance.currentUser!.uid,
                            'id': key
                          });
                        } catch (_) {
                          FirebaseFirestore.instance
                              .collection('chats')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection(widget.uid)
                              .doc(key)
                              .set({
                            'msg': '_',
                            'type': 'image',
                            'status': 'error',
                            'time': DateFormat('h:mm a').format(DateTime.now()),
                            'sender': FirebaseAuth.instance.currentUser!.uid,
                            'id': key
                          });

                          FirebaseFirestore.instance
                              .collection('chats')
                              .doc(widget.uid)
                              .collection(
                                  FirebaseAuth.instance.currentUser!.uid)
                              .doc(key)
                              .set({
                            'msg': '_',
                            'type': 'image',
                            'status': 'status',
                            'time': DateFormat('h:mm a').format(DateTime.now()),
                            'sender': FirebaseAuth.instance.currentUser!.uid,
                            'id': key
                          });
                        }

                        Timer(const Duration(milliseconds: 50), () {
                          controller
                              .jumpTo(controller.position.maxScrollExtent);
                        });
                      }
                    },
                    child: const Icon(
                      Icons.image,
                      color: Colors.lightBlueAccent,
                      size: 30,
                    )),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    if (msg.value.text.toString().isNotEmpty) {
                      final key =
                          DateTime.now().microsecondsSinceEpoch.toString();
                      String s = msg.value.text.toString();
                      FirebaseFirestore.instance
                          .collection('chatWith')
                          .doc(widget.uid)
                          .collection('chatWith')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .set({
                        'type': 'text',
                        'name': userName,
                        'uid': FirebaseAuth.instance.currentUser!.uid,
                        'lastMsg': s,
                      });
                      FirebaseFirestore.instance
                          .collection('chatWith')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('chatWith')
                          .doc(widget.uid)
                          .set({
                        'type': 'text',
                        'name': widget.name,
                        'uid': widget.uid,
                        'lastMsg': s,
                      });
                      msg.clear();
                      await FirebaseFirestore.instance
                          .collection('chats')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection(widget.uid)
                          .doc(key)
                          .set({
                        'msg': s,
                        'type': 'text',
                        'status': '_',
                        'time': DateFormat('h:mm a').format(DateTime.now()),
                        'sender': FirebaseAuth.instance.currentUser!.uid,
                        'id': key
                      });
                      await FirebaseFirestore.instance
                          .collection('chats')
                          .doc(widget.uid)
                          .collection(FirebaseAuth.instance.currentUser!.uid)
                          .doc(key)
                          .set({
                        'msg': s,
                        'type': 'text',
                        'status': '_',
                        'time': DateFormat('h:mm a').format(DateTime.now()),
                        'sender': FirebaseAuth.instance.currentUser!.uid,
                        'id': key
                      });
                      Timer(const Duration(milliseconds: 50), () {
                        controller.jumpTo(controller.position.maxScrollExtent);
                      });
                    }
                  },
                  child: const CircleAvatar(
                    radius: 20,
                    backgroundColor: FitnessAppTheme.cyan,
                    child: Center(
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
