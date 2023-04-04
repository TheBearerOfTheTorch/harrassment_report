import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Counselor extends StatelessWidget {
  const Counselor({super.key});

  static MaterialPage page({LocalKey? key}) {
    return MaterialPage(key: key, child: const Counselor());
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> reports =
        FirebaseFirestore.instance.collection('report').snapshots();
    return Scaffold(
        appBar: AppBar(
          leading: const Text('Counsellors Dashboard'),
          title: IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () {},
          ),
        ),
        body: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 1.5,
            height: MediaQuery.of(context).size.height / 1.2,
            child: StreamBuilder<QuerySnapshot>(builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                return ListView(
                  children: snapshot.data!.docs.map((e) {
                    Map<String, dynamic> data =
                        e.data() as Map<String, dynamic>;
                    return Card(
                      child: ListTile(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Container(
                                  height: 150,
                                  width: 100,
                                  decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          colors: [
                                        Color.fromARGB(255, 61, 96, 136),
                                        Color.fromARGB(255, 99, 120, 138),
                                        Color.fromARGB(255, 160, 199, 238)
                                      ])),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(data['email'] +
                                                'Report Information'),
                                            IconButton(
                                              icon: const Icon(Icons.clear),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 14),
                                        Row(
                                          children: [
                                            const Text('UserEmail: '),
                                            Text(data['email'])
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            const Text('User Phone number: '),
                                            Text(data['phone']),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            const Text('Harassment type: '),
                                            Text(data['harassmentType']),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            const Text('Harassment Date: '),
                                            Text(data['date']),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            const Text('location: '),
                                            Text(data['location']),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            const Text('Description: '),
                                            Text(data['description']),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        leading: const Icon(Icons.report),
                        title: data['harassmentType'],
                        trailing: data['date'],
                      ),
                    );
                  }).toList(),
                );
              }
              return const Center(
                  child: Text('Theres an error loading reports'));
            }),
          ),
        ));
  }
}
