import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final ScrollController scroll = ScrollController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    User? currentUser = _firebaseAuth.currentUser;
    final Stream<QuerySnapshot> _providerPick =
        FirebaseFirestore.instance.collection('users').snapshots();
    var userId = currentUser!.uid;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return Center(
                child: SingleChildScrollView(
                    controller: scroll,
                    clipBehavior: Clip.hardEdge,
                    child: Container(
                        width: 400,
                        height: 500,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color.fromARGB(255, 26, 43, 61),
                                Color.fromARGB(255, 3, 67, 119),
                                Color.fromARGB(255, 17, 45, 73)
                              ]),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey, //color of shadow
                              blurRadius: 3,
                            ),
                          ],
                        ),
                        child: ListView(
                          children: snapshot.data!.docs.map((e) {
                            Map<String, dynamic> data =
                                e.data() as Map<String, dynamic>;

                            return Card(
                                margin: const EdgeInsets.all(10),
                                elevation: 3,
                                child: Column(
                                  children: [
                                    const Text(
                                      'PROFILE INFORMATION',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          data['firstname'],
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        Text(data['lastname'],
                                            style: const TextStyle(
                                                color: Colors.black)),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Text(data['gender'],
                                        style: const TextStyle(
                                            color: Colors.black)),
                                    const SizedBox(height: 10),
                                    Text(data['email'],
                                        style: const TextStyle(
                                            color: Colors.black)),
                                  ],
                                ));
                          }).toList(),
                        ))));
          }
          return const Center(
              child: Text('Theres an error fetching profile date'));
        });
  }
}
