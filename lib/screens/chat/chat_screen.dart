import 'dart:async';

import 'package:calories_mate/screens/splashscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen(
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
    // TODO: implement initState
    super.initState();
  }
  final ScrollController controller = ScrollController();

  final TextEditingController msg = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 3,
        centerTitle: true,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Center(
                child: Icon(
                  Icons.person,
                  color: Colors.black26,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ],
              ),
            ),
            Spacer(),
            Icon(Icons.more_vert_rounded, color: Colors.white)
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
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                }
                List<Map<String, dynamic>>? messages = snapshot.data?.docs
                    .map((e) => {
                          'msg': e.get('msg'),
                          'time': e.get('time'),
                          'sender': e.get('sender')
                        })
                    .toList();
                if (messages == null || messages.isEmpty) {
                  return Container();
                }

                Timer(Duration(milliseconds: 100,),() {
                  controller.jumpTo(controller.position.maxScrollExtent);

                },);

                return ListView.builder(
                  controller: controller,
                  padding: EdgeInsets.only(top: 10),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return messages[index]['sender'] == widget.uid
                        ? Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 70, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    messages[index]['msg'].toString(),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Text(
                                    messages[index]['time'].toString(),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 70, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    messages[index]['msg'].toString(),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Text(
                                    messages[index]['time'].toString(),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          );
                  },
                );
              },
            ),
          )),
          Container(
            height: 60,
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(color: Colors.blue.withOpacity(.2)),
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: TextFormField(
                  controller: msg,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type your Message',
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
                )),
                SizedBox(
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
                        'time': DateFormat('h:mm a').format(DateTime.now()),
                        'sender': FirebaseAuth.instance.currentUser!.uid,
                        'id': key
                      });



                      Timer(Duration(milliseconds: 50), () {
                        controller.jumpTo(controller.position.maxScrollExtent);
                      });


                    }
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.blue,
                    child: Center(
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
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
