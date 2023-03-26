import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  static Page page({LocalKey? key}) {
    return MaterialPage(key: key, child: const Home());
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Home screen'),
    );
  }
}
