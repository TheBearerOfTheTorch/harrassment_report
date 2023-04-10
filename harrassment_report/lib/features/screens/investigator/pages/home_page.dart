import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../states/states.dart';

class HomePag extends StatefulWidget {
  HomePag({super.key});

  static MaterialPage page({LocalKey? key}) {
    return MaterialPage(key: key, child: HomePag());
  }

  @override
  State<HomePag> createState() => _HomePagState();
}

class _HomePagState extends State<HomePag> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  final formKey = GlobalKey<FormState>();

  var selectedCurrency, selectedType;

  List<String> _accountType = <String>['underreview', 'hearing', 'authority', 'cancelled'];

  @override
  Widget build(BuildContext context) {
    final stateProvider = Provider.of<StateManager>(context);
    Stream<QuerySnapshot> reports =
        FirebaseFirestore.instance.collection('report').snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: reports,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasData) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 200,
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Text(
                            'Reports',
                            style: TextStyle(fontSize: 30),
                          ),
                          Icon(
                            Icons.arrow_right,
                            size: 40,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 700.0,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: snapshot.data!.docs.map((e) {
                      Map<String, dynamic> data =
                          e.data() as Map<String, dynamic>;
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: 5.0,
                        ),
                        elevation: 1.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      children: [
                                        const CircleAvatar(),
                                        const SizedBox(width: 8.0),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data['email'],
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    '${data['phone']} • ',
                                                    style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontSize: 12.0,
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.public,
                                                    color: Colors.grey[600],
                                                    size: 12.0,
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.more_horiz),
                                          onPressed: () => print('More'),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4.0),
                                    Text(data['description']),
                                    const SizedBox.shrink(),
                                  ],
                                ),
                              ),
                              const SizedBox.shrink(),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Column(
                                  children: [
                                    const Divider(),
                                    Row(
                                      children: [
                                        const SizedBox(width: 10),
                                        const SizedBox(width: 10),
                                        InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        'TYPE:  ${data['harassmentType']}'),
                                                    content: Form(
                                                      key: formKey,
                                                      child: SizedBox(
                                                        height: 200,
                                                        child: Column(
                                                          children: [
                                                            const SizedBox(
                                                                height: 10),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                const Icon(
                                                                  Icons
                                                                      .pin_drop,
                                                                  size:
                                                                      25.0,
                                                                  color: Color.fromARGB(255, 183, 17, 17),
                                                                ),
                                                                const SizedBox(
                                                                    width:
                                                                        50.0),
                                                                DropdownButton(
                                                                  items: _accountType
                                                                      .map((value) => DropdownMenuItem(
                                                                            value: value,
                                                                            child: Text(
                                                                              value,
                                                                              style: const TextStyle(color: Color.fromARGB(255, 183, 17, 17)),
                                                                            )
                                                                          ))
                                                                      .toList(),
                                                                  onChanged:
                                                                      (selectedAccountType) {
                                                                    print(
                                                                        '$selectedAccountType');
                                                                    setState(
                                                                        () {
                                                                      selectedType =
                                                                          selectedAccountType;
                                                                    });
                                                                  },
                                                                  value:
                                                                      selectedType,
                                                                  isExpanded:
                                                                      false,
                                                                  hint:
                                                                      const Text(
                                                                    'Update status',
                                                                    style: TextStyle(
                                                                        color:
                                                                            Color.fromARGB(255, 183, 17, 17)),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            const SizedBox(height: 50),
                                                            ElevatedButton(onPressed: (){

                                                            }, child: const Text('Update status'))
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                          child: Container(
                                            padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 12.0),
                                            height: 25.0,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Icon(
                                                  MdiIcons.shareOutline,
                                                  color: Colors.red,
                                                  size: 25.0,
                                                ),
                                                SizedBox(width: 4.0),
                                                Text(
                                                    'Update report status'),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  width: 100,
                ),
              ],
            );
          }
          return const Center(
            child: Text('An unknown error has occured while loading data'),
          );
        });
  }
}

class _PostStats extends StatelessWidget {
  const _PostStats({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        Row(
          children: [
            const SizedBox(width: 10),
            const SizedBox(width: 10),
            Expanded(
              child: Material(
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    height: 25.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          MdiIcons.shareOutline,
                          color: Colors.red,
                          size: 25.0,
                        ),
                        SizedBox(width: 4.0),
                        Text('Update report status'),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
