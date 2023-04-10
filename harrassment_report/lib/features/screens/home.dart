import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../states/states.dart';
import '../features.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  static Page page({LocalKey? key}) {
    return MaterialPage(key: key, child: const Home());
  }

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static List<Widget> pages = [
    const HomePage(),
    const ReportPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<StateManager>(builder: (context, stateManager, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Dashboard"),
          actions: <Widget>[
            IconButton(
              onPressed: (){
                
              },
              icon: const Icon(Icons.notification_add),
            ),
            IconButton(
              onPressed: () => context.read<StateManager>().logout(),
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: SafeArea(
          child: IndexedStack(
            index: stateManager.selectedTab,
            children: pages,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: stateManager.selectedTab,
          onTap: stateManager.goToTab,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Report',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.safety_check),
              label: 'Report status',
            ),
          ],
        ),
      );
    });
  }
}
