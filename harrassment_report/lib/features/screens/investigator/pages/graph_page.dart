import 'package:flutter/material.dart';

class GraphPage extends StatelessWidget {
  const GraphPage({super.key});

  static MaterialPage page({LocalKey? key}) {
    return MaterialPage(key: key, child: GraphPage());
  }

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('THIS PAGE IS TILL UNDER DEVELOPMENT'));
  }
}
