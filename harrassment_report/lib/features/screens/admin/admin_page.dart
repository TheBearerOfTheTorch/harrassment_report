import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../states/states.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  //setting the expansion function for the navigation rail
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
          children: [
            //Let's start by adding the Navigation Rail
            NavigationRail(
                extended: isExpanded,
                backgroundColor: Colors.deepPurple.shade400,
                unselectedIconTheme:
                    const IconThemeData(color: Colors.white, opacity: 1),
                unselectedLabelTextStyle: const TextStyle(
                  color: Colors.white,
                ),
                selectedIconTheme:
                    IconThemeData(color: Colors.deepPurple.shade900),
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text("Home"),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.bar_chart),
                    label: Text("Reports"),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.person),
                    label: Text("Profile"),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.settings),
                    label: Text("Settings"),
                  ),
                ],
                selectedIndex: 0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(60.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //let's add the navigation menu for this project
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              //let's trigger the navigation expansion
                              setState(() {
                                isExpanded = !isExpanded;
                              });
                            },
                            icon: const Icon(Icons.menu),
                          ),
                          const CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/logo-bw-sml.png"),
                            radius: 55.0,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      //Now let's start with the dashboard main rapports
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.article,
                                          size: 26.0,
                                        ),
                                        SizedBox(
                                          width: 15.0,
                                        ),
                                        Text(
                                          "Formal report",
                                          style: TextStyle(
                                            fontSize: 26.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    const Text(
                                      "6",
                                      style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.comment,
                                          size: 26.0,
                                          color: Colors.red,
                                        ),
                                        SizedBox(
                                          width: 15.0,
                                        ),
                                        Text(
                                          "Informal Reports",
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 26.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    const Text(
                                      "3",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.people,
                                          size: 26.0,
                                          color: Colors.amber,
                                        ),
                                        SizedBox(
                                          width: 15.0,
                                        ),
                                        Text(
                                          "Users",
                                          style: TextStyle(
                                            fontSize: 26.0,
                                            color: Colors.amber,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    const Text(
                                      "5+ Users",
                                      style: TextStyle(
                                        fontSize: 36,
                                        color: Colors.amber,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.cases,
                                          size: 26.0,
                                          color: Colors.green,
                                        ),
                                        SizedBox(
                                          width: 15.0,
                                        ),
                                        Text(
                                          "Solved Cases",
                                          style: TextStyle(
                                            fontSize: 26.0,
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    const Text(
                                      "0",
                                      style: TextStyle(
                                        fontSize: 36,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //Now let's set the article section
                      const SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: const [
                              Text(
                                "6 Articles",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28.0,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "3 new Articles",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Container(
                            width: 300.0,
                            child: const TextField(
                              decoration: InputDecoration(
                                hintText: "Type Article Title",
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black26,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),

                      //let's set the filter section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.deepPurple.shade400,
                            ),
                            label: Text(
                              "2022, July 14, July 15, July 16",
                              style: TextStyle(
                                color: Colors.deepPurple.shade400,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              DropdownButton(
                                  hint: const Text("Filter by"),
                                  items: const [
                                    DropdownMenuItem(
                                      value: "Date",
                                      child: Text("Date"),
                                    ),
                                    DropdownMenuItem(
                                      value: "Comments",
                                      child: Text("Comments"),
                                    ),
                                    DropdownMenuItem(
                                      value: "Views",
                                      child: Text("Views"),
                                    ),
                                  ],
                                  onChanged: (value) {}),
                              const SizedBox(
                                width: 20.0,
                              ),
                              DropdownButton(
                                  hint: const Text("Order by"),
                                  items: const [
                                    DropdownMenuItem(
                                      value: "Date",
                                      child: Text("Date"),
                                    ),
                                    DropdownMenuItem(
                                      value: "Comments",
                                      child: Text("Comments"),
                                    ),
                                    DropdownMenuItem(
                                      value: "Views",
                                      child: Text("Views"),
                                    ),
                                  ],
                                  onChanged: (value) {}),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      //Now let's add the Table
                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Center(
                                child: Text('An unknown error occured'),
                              );
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.hasData) {
                              return SizedBox(
                                height: MediaQuery.of(context).size.height / 2,
                                child: ListView(
                                  scrollDirection: Axis.vertical,
                                  children: snapshot.data!.docs.map((e) {
                                    Map<String, dynamic> data =
                                        e.data() as Map<String, dynamic>;

                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        DataTable(
                                            headingRowColor:
                                                MaterialStateProperty
                                                    .resolveWith((states) =>
                                                        Colors.grey.shade200),
                                            columns: const [
                                              DataColumn(label: Text("ID")),
                                              DataColumn(
                                                  label: Text("Offender name")),
                                              DataColumn(
                                                  label: Text("Location")),
                                              DataColumn(label: Text("Date")),
                                              DataColumn(label: Text("Phone")),
                                            ],
                                            rows: [
                                              DataRow(cells: [
                                                DataCell(Text('')),
                                                DataCell(Text(data['email'])),
                                                DataCell(
                                                    Text(data['firstname'])),
                                                DataCell(Text(data['gender'])),
                                                DataCell(
                                                    Text(data['userRole'])),
                                              ]),
                                            ]),
                                        //Now let's set the pagination
                                        const SizedBox(
                                          height: 40.0,
                                        ),
                                        Row(
                                          children: [
                                            TextButton(
                                              onPressed: () {},
                                              child: const Text(
                                                "1",
                                                style: TextStyle(
                                                    color: Colors.deepPurple),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {},
                                              child: const Text(
                                                "2",
                                                style: TextStyle(
                                                    color: Colors.deepPurple),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {},
                                              child: const Text(
                                                "3",
                                                style: TextStyle(
                                                    color: Colors.deepPurple),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {},
                                              child: const Text(
                                                "See All",
                                                style: TextStyle(
                                                    color: Colors.deepPurple),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    );
                                  }).toList(),
                                ),
                              );
                            }
                            return const Center(
                              child: Text('There are no reports at the moment'),
                            );
                          })
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        //let's add the floating action button
        floatingActionButton: FloatingActionButton(
          onPressed: () {
          },
          backgroundColor: Colors.deepPurple.shade400,
          child: const Icon(
            Icons.logout,
          ),
        ));
  }
}
