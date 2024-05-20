import 'package:calories_mate/screens/chat/chat_screen.dart';
import 'package:calories_mate/screens/patient_dashboard/fitness_app_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatWith extends StatelessWidget {
  const ChatWith({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: FitnessAppTheme.cyan,
        elevation: 3,
        centerTitle: true,
        title: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Chats',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
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
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 20,
                                backgroundColor:
                                    FitnessAppTheme.cyan.withOpacity(.2),
                                child: const Center(
                                  child: Icon(
                                    Icons.chat,
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
                            ),
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
