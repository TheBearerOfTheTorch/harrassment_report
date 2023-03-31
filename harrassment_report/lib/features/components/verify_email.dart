import 'package:flutter/material.dart';

class VerifyEmail extends StatelessWidget {
  const VerifyEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
            child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  //color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xFF05182D),
                        Color(0xFF092A45),
                        Color(0xFF0D2339)
                      ]), //border corner radius
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey, //color of shadow
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: Column(children: [
                  IconButton(
                      icon: const Icon(Icons.cancel),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  const SizedBox(height: 20),
                  const Center(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        'An email has been sent to your email. Click the link in the email to verify your email. Thank you!'),
                  ))
                ]))));
  }
}
