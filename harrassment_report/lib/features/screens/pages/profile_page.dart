import 'package:auto_size_text/auto_size_text.dart';
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
        FirebaseFirestore.instance.collection('users').doc(currentUser!.uid).collection('report').snapshots();
    
    return StreamBuilder<QuerySnapshot>(
        stream: _providerPick,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 218,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: const [
                      Text('Notifications', style: TextStyle(fontSize: 30)),
                      Icon(Icons.arrow_right,size: 25,)
                    ],
                  ),
                ),
                ),
                SizedBox(
                  width: 600,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: snapshot.data!.docs.map((e) {
                      Map<String, dynamic> data =
                          e.data() as Map<String, dynamic>;
                  
                      return Card(
                        child: ListTile(
                          onTap: (){
                            showDialog(context: context, builder: (context){
                              return AlertDialog(
                                title: const Text('Report details'),
                                content: SizedBox(
                                  height: 400,
                                  width: 400,
                                  child: Column(
                                    children: [
                                    const SizedBox(height: 30),
                                    Row(
                                      children: [
                                        const Text('Offender: ',style: TextStyle(fontWeight: FontWeight.bold),),
                                        AutoSizeText(
                                      data['offender'],
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                      ],
                                    ),
                                    
                                    const SizedBox(height: 15),

                                    Row(
                                      children: [
                                        const Text('Location: ',style: TextStyle(fontWeight: FontWeight.bold),),
                                        AutoSizeText(
                                      data['location'],
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                      ],
                                    ),
                                    
                                    const SizedBox(height: 15),
                                    Row(
                                      children: [
                                        const Text('Harassment type: ',style: TextStyle(fontWeight: FontWeight.bold),),
                                        AutoSizeText(
                                      data['harassmentType'],
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                      ],
                                    ),
                                    
                                    const SizedBox(height: 15),
                                    Row(
                                      children: [
                                        const Text('Date: ',style: TextStyle(fontWeight: FontWeight.bold),),
                                        AutoSizeText(
                                      data['date'],
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                      ],
                                    ),
                                    
                                    const SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Status: ',style: TextStyle(fontWeight: FontWeight.bold),),
                                        Container(
                                          height: 50,
                                          width: 100,
                                          color: data['status'] == 'submitted'? 
                                          Colors.grey: data['status'] == 'underreview'?Colors.orange: 
                                          data['status'] == 'hearing'?Colors.green: data['status'] == 'authority'?
                                          Colors.blue: Colors.red,
                                          child: Center(child: Text(data['status'])),
                                    ),
                                      ],
                                    ),
                                    
                                    const SizedBox(height: 15),
                                    const Text('Harassment Decription: ',style: TextStyle(fontWeight: FontWeight.bold),),
                                    AutoSizeText(
                                      data['description'],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 8,
                                    ),
                                    const SizedBox(height: 15),
                                  ]),
                                ),
                              );
                            });
                          },
                          leading: Container(
                            height: 40,
                            width: 80,
                            color: data['status'] == 'submitted'? 
                                  Colors.grey: data['status'] == 'underreview'?Colors.orange: 
                                  data['status'] == 'hearing'?Colors.green: data['status'] == 'authority'?
                                  Colors.blue: Colors.red,
                            child: Center(child: Text(data['status']))),
                          title: Text(data['harassmentType']),
                          subtitle: Text(data['offender']),
                          trailing: Text(data['location']),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(width: 50),
              ],
            );
          }
          return const Center(
              child: Text('Theres an error fetching profile date'));
        });
  }
}
