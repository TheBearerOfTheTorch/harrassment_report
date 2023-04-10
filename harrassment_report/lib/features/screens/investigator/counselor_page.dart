import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../../states/states.dart';
import '../../features.dart';

class Counselor extends StatelessWidget {
  Counselor({super.key});

  static MaterialPage page({LocalKey? key}) {
    return MaterialPage(key: key, child: Counselor());
  }

  final List<IconData> tabs = [
    Icons.home,
    Icons.notifications,
    Icons.auto_graph
  ];
  List<Widget> pages = [HomePag(), NotificationPage(), GraphPage()];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final stateProvider = Provider.of<StateManager>(context);
    final Stream<QuerySnapshot> reports =
        FirebaseFirestore.instance.collection('report').snapshots();

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: PreferredSize(
        preferredSize: Size(size.width, 60),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Image.asset('assets/images/logo-bw-sml.png'),
          SizedBox(
            height: double.infinity,
            width: 600,
            child: DefaultTabController(
              length: pages.length,
              child: TabBar(
                indicator: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 3.0,
                  ),
                )),
                tabs: tabs
                    .asMap()
                    .map((index, iconData) => MapEntry(
                          iconData,
                          Tab(
                            icon: Icon(iconData,
                                //Portion 2---------------------------------------------
                                color: stateProvider.investigatorTab == index
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).unselectedWidgetColor,
                                size: Theme.of(context).iconTheme.size),
                            //----------------------------------------------------------
                          ),
                        ))
                    .values
                    .toList(),
                onTap: (index) {
                  stateProvider.goToIvestigatorTab(index);
                },
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              stateProvider.logout();
              stateProvider.loggedOut();
            },
          ),
        ]),
      ),
      body: SafeArea(
        child: IndexedStack(
          index: stateProvider.investigatorTab,
          children: pages,
        ),
      ),
    );
  }
}
