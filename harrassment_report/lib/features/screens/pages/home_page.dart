import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xFF092A45), Color(0xFF0D2339)]),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            const Center(
              child: Text('RESOURCE CENTER',
                  style: TextStyle(fontSize: 30, color: Colors.white)),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width / 3.6,
                  decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF21A3E2)),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: Column(
                        children: const [
                          Text('Preamble',
                              style:
                                  TextStyle(fontSize: 35, color: Colors.white)),
                          SizedBox(height: 30),
                          Text(
                              'The University of Botswana Safe Environment and Sexual Harassment Policy (The Policy)is approved by the University Council and is applicable to all students and empolyee,contractors and theri employees and agents providing services on the University campus,job applicants, suppliers and any other person dealing with the University.',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width / 3.6,
                  decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF21A3E2)),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: Column(
                        children: const [
                          Text('Interpretation',
                              style:
                                  TextStyle(fontSize: 35, color: Colors.white)),
                          SizedBox(height: 30),
                          Text(
                              'Authority for interpretation of this policy is vested in the Vice Chancellor.',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width / 3.6,
                  decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF21A3E2)),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: Column(
                        children: const [
                          Text('Definitions',
                              style:
                                  TextStyle(fontSize: 35, color: Colors.white)),
                          SizedBox(height: 30),
                          Text(
                              'In this policy, any refernce to the singular shall include the plural and vice versa and the following words and epressions shall carry the meanings ascribed to them respectively as follows:',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Link(
              uri: Uri.parse(
                  'https://firebasestorage.googleapis.com/v0/b/harrassment-report.appspot.com/o/Sexual%20Harassment%20Policy%202022%20(3).pdf?alt=media&token=1a7f8e69-faef-42bf-a829-4cd99bd44b3c'),
              target: LinkTarget.blank,
              builder: (BuildContext ctx, FollowLink? openLink) {
                return TextButton.icon(
                  onPressed: openLink,
                  label: const Text('To read more of the policies click here'),
                  icon: const Icon(Icons.read_more),
                );
              },
            ),
          ]),
        ));
  }

  // void _launchURL() async {
  //   const url =
  //       'https://firebasestorage.googleapis.com/v0/b/harrassment-report.appspot.com/o/Sexual%20Harassment%20Policy%202022%20(3).pdf?alt=media&token=1a7f8e69-faef-42bf-a829-4cd99bd44b3c';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
}
