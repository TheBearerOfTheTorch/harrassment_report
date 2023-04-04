import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

import '../../features.dart';

class LandingPage extends StatelessWidget {
  LandingPage({Key? key}) : super(key: key);
  static MaterialPage page({LocalKey? key}) {
    return MaterialPage(key: key, child: LandingPage());
  }

  final Shader iphoneShader =
      const LinearGradient(colors: [Color(0xff070D14), Color(0xff85D1EE)])
          .createShader(const Rect.fromLTWH(0, 100, 50, 2));

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
            ])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 40),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Sexual Harassment Report',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'about us',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 40),
                        TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  const LoginScreen(),
                            );
                          },
                          child: const Text(
                            'signin',
                            style: TextStyle(
                              color: Color(0xFF6F92B6),
                            ),
                          ),
                        ),
                        const SizedBox(width: 40),
                        TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    const RegisterScreen(),
                              );
                            },
                            child: const Text(
                              'sign up',
                              style: TextStyle(
                                color: Color(0xFF6F92B6),
                              ),
                            )),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 100),
                        Text(
                          'Sexual Harassment',
                          style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()..shader = iphoneShader,
                              shadows: const [
                                Shadow(
                                    offset: Offset(10, 10),
                                    blurRadius: 20,
                                    color: Colors.black),
                                Shadow(
                                    offset: Offset(10, 10),
                                    blurRadius: 20,
                                    color: Colors.black12),
                              ]),
                        ),
                        const SizedBox(height: 20),
                        const SizedBox(
                          width: 450,
                          child: Text(
                            "Sexual harassment is a type of harassment "
                            "involving the use of explicit or implicit sexual "
                            "overtones, including the unwelcome and "
                            "inappropriate promises of rewards in exchange for"
                            " sexual favors. We design this site to be a "
                            "comprehensive to report this types of harassments at the university",
                            style: TextStyle(
                                color: Color(0xFF4481A6), fontSize: 20),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const SizedBox(height: 50),
                        Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xFF21A3E2)),
                              borderRadius: BorderRadius.circular(50)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.login,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Sign up',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    //im here bro
                    SizedBox(
                      width: 520,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 120),
                            height: 350,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xFF21A3E2)),
                                borderRadius: BorderRadius.circular(50)),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: const [
                                  Text(
                                    'WHAT CONSTITUES OF SEXUAL HARASSMENT?',
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                              offset: Offset(10, 10),
                                              blurRadius: 20,
                                              color: Colors.black),
                                          Shadow(
                                              offset: Offset(10, 10),
                                              blurRadius: 20,
                                              color: Colors.black12),
                                        ]),
                                  ),
                                  SizedBox(height: 30),
                                  Text(
                                      'Failure to promote an employee or pass student who may have refused you a date. Inviting a subordinate out on a date after failure to get him/her to love you(particularly if the subordinate believes that the rejection may result in adverse actions',
                                      style: TextStyle(
                                          color: Color(0xFF4481A6),
                                          fontSize: 20)),
                                ],
                              ),
                            ),
                          ),
                          Link(
                            uri: Uri.parse(
                                'https://view.officeapps.live.com/op/view.aspx?src=https%3A%2F%2Ffirebasestorage.googleapis.com%2Fv0%2Fb%2Fharrassment-report.appspot.com%2Fo%2FSEXUAL%2520HARASSMENT.docx%3Falt%3Dmedia%26token%3Dd8270a8e-ed32-40bb-a3ea-762f91bcdff6&wdOrigin=BROWSELINK'),
                            target: LinkTarget.blank,
                            builder: (BuildContext ctx, FollowLink? openLink) {
                              return TextButton.icon(
                                onPressed: openLink,
                                label: const Text('Read More....',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 166, 68, 68),
                                        fontSize: 20)),
                                icon: const Icon(Icons.read_more),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
