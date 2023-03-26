import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});
  static Page page({LocalKey? key}) {
    return MaterialPage(key: key, child: const ErrorScreen());
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('An error occured'),
    );
  }
}
