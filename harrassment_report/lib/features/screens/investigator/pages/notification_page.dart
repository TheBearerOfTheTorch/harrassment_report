import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  static MaterialPage page({LocalKey? key}) {
    return MaterialPage(key: key, child: const NotificationPage());
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> reports =
        FirebaseFirestore.instance.collection('report').snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: reports,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!.docs.map((e) {
                Map<String, dynamic> data = e.data as Map<String, dynamic>;

                return ListTile(
                  leading: Text(data['date']),
                  title: Text(data['harassmentType']),
                  trailing: Text(data['location']),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Card(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          icon: const Icon(Icons.clear))
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text(data['description']),
                                      ],
                                    ),
                                  )
                                ]),
                          );
                        });
                  },
                );
              }).toList(),
            );
          }

          return const Center(child: Text('Unknown error occured'));
        });
  }
}
