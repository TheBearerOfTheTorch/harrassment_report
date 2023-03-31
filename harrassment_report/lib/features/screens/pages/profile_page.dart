import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  ScrollController scroll = ScrollController();
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
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color(0xFF05182D),
                                Color(0xFF092A45),
                                Color(0xFF0D2339)
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

                            return Text(data['firstname']);
                          }).toList(),
                        ))));
          }
          return const Center(
              child: Text('Theres an error fetching profile date'));
        });
  }
}
