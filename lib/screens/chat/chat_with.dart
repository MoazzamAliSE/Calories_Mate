import 'package:calories_mate/screens/chat/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';

class ChatWith extends StatelessWidget {
  const ChatWith({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  Text(
                    'Chats',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(),
              ),
              Expanded(
                  child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('chatWith')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('chatWith')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    );
                  }
                  List<Map<String, dynamic>>? chats = snapshot.data?.docs
                      .map((e) => {
                            'name': e.get('name'),
                            'lastMsg': e.get('lastMsg'),
                            'uid': e.get('uid')
                          })
                      .toList();

                  if (chats == null || chats.isEmpty) {
                    return const Center(
                      child: Text('No chats yet'),
                    );
                  }

                  return ListView.builder(
                    itemCount: chats.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => ChatScreen(
                              name: chats[index]['name'] ?? "",
                              uid: chats[index]['uid'],
                              email: ''));
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.blue.withOpacity(.2),
                            child: const Center(
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          title: Text(
                            chats[index]['name'] != null
                                ? chats[index]['name'].toString()
                                : "No name",
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            chats[index]['lastMsg'].toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: const Icon(
                            Icons.more_vert_rounded,
                            color: Colors.black,
                          ),
                        ),
                      );
                    },
                  );
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
