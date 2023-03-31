import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFF05182D),
                Color(0xFF092A45),
                Color(0xFF0D2339)
              ]),
        ),
        child: Column(children: [
          
        ]));
  }
}
