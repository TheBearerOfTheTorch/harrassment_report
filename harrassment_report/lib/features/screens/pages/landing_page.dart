import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/link.dart';

import '../../../states/states.dart';
import '../../features.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key? key}) : super(key: key);
  static MaterialPage page({LocalKey? key}) {
    return MaterialPage(key: key, child: LandingPage());
  }

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  TextEditingController phone = TextEditingController();
  TextEditingController harassmentType = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController progressController = TextEditingController();
  TextEditingController offender = TextEditingController();

  bool loading = false;
  final key = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final stateManagement = Provider.of<StateManager>(context);

    ///
    ///stream
    ///
    //final Future<DocumentSnapshot> report = FirebaseFirestore.instance.collection('report').doc(progressController.text).get();
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        Container(
            height: 300,
            width: size.width,
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 147, 218, 252)),
            child: Column(children: [
              Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: Row(
                    children: [
                      Image.asset('assets/images/logo.jpeg'),
                      Text('Report Harassment',style: Theme.of(context).textTheme.headlineLarge,)
                    ],
                  )),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      label: const Text(
                        'about us',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 65, 90, 117),
                        ),
                      ),
                      icon: const Icon(Icons.arrow_drop_down_sharp,color: Color.fromARGB(255, 65, 90, 117),size: 33,),
                    ),
                    const SizedBox(width: 40),
                    TextButton.icon(
                      icon: const Icon(Icons.arrow_drop_down_sharp,color: Color.fromARGB(255, 65, 90, 117),size: 33),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => const LoginScreen(),
                        );
                      },
                      label: const Text(
                        'signin',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 4, 32, 61),
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                    TextButton.icon(
                      icon: const Icon(Icons.arrow_drop_down_sharp,color: Color.fromARGB(255, 65, 90, 117), size: 33),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                const RegisterScreen(),
                          );
                        },
                        label: const Text(
                          'sign up',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 4, 32, 61),
                          ),
                        )),
                  ],
                ),
              ),
            ])),
        Container(
            height: 600,
            width: size.width,
            color: const Color.fromARGB(255, 36, 2, 43),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 80.0, left: 140.0),
                  child: SizedBox(
                    width: size.width/3.3,
                    child: Column(
                      children: [
                        const Center(
                          child: Text('Office for UB Counseling',
                              style: TextStyle(fontSize: 30,color: Colors.white)),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                        
                          "Want to speak to someone? there are people in our community who can help you.UB counselling have specialized experience in responding to disclosures of sexual harassment and other sexual misconduct. They serve in a neutral role, support all members of the UB community, and are expert resources around the Universitys policies, procedures, and resources in the realm of sexual harassment and other sexual misconduct. Resource Coordinators serve as the primary point of contact for individuals seeking supportive measures, individualized supports that enable UB community members impacted by sexual harassment or other sexual misconduct to access their work or studies.",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {},
                              child: const Text('LEARN MORE ABOUT US')),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 60.0),
                  child: Image.asset('assets/images/ocean.jpg',
                  height: 500,
                  width: 700),
                )
              ],
            )),
        Container(
            margin: const EdgeInsets.all(23),
            width: size.width,
            child: Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 300,
                      width: 530,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 63, 58, 107),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: TextButton(
                        child: const Text('Report Anonymously',style: TextStyle(color: Colors.white, fontSize: 30)),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(title: formContainer(context));
                              });
                        })),
                    customContainer(
                        title: 'Policies',
                        color: Color.fromARGB(255, 117, 66, 40),
                        url: 'https://view.officeapps.live.com/op/view.aspx?src=https%3A%2F%2Ffirebasestorage.googleapis.com%2Fv0%2Fb%2Fharrassment-report.appspot.com%2Fo%2FSEXUAL%2520HARASSMENT.docx%3Falt%3Dmedia%26token%3Dd8270a8e-ed32-40bb-a3ea-762f91bcdff6&wdOrigin=BROWSELINK'
                        ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 300,
                      width: 530,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 129, 84, 61),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: TextButton(
                        child: const Text('Check Progress report',style: TextStyle(color: Colors.white, fontSize: 30)),
                        onPressed: () {
                          ///
                          ///
                          ///
                          ///
                          ///
                          ///
                          ///
                          ///
                          ///
                          ///
                          ///
                          ///
                          ///
                          ///
                          ///
                          ///
                          ///Im herer now
                          ///
                          ///
                          ///
                          ///progressController
                          ///
                          ///
                          ///
                          ///
                          ///
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    title: Text('Check progress on Report',style: Theme.of(context).textTheme.headlineMedium,),
                                    content: Form(
                                      key: formKey,
                                      child: Column(children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 260,
                                              height: 35,
                                              child: TextFormField(
                                                controller: phone,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Phone required";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                  focusedBorder: const OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide(color: Color(0xFF707070), width: .5)),
                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(4),
                                                      borderSide: const BorderSide(
                                                          color: Color.fromARGB(255, 247, 244, 244),
                                                          width: .5)),
                                                  hintText: "Number used to report",
                                                  hintStyle: const TextStyle(height: 0.5),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 30),
                                            ElevatedButton(
                                              child: const Text('Check'),
                                              onPressed: (){
                                                if(formKey.currentState!.validate()){

                                                }
                                              },
                                            )
                                          ],
                                        ),
                                      ],)),);
                              });
                        })),
                        Container(
                      height: 300,
                      width: 530,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 88, 59, 90),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: TextButton(
                        child: const Text('File formal Complaint',style: TextStyle(color: Colors.white, fontSize: 30)),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const AlertDialog(
                              title: Text('FILE FORMAL COMPLAINT'),
                              content: Text(
                                  'The file formal complaint functionality is not avaliable at the moment. We are working to ensure that this functionality is available as soon as posible'));
                              });
                        })),
                    
                  ],
                )
              ],
            )),
        const SizedBox(height: 13),
        footer(size.width)
      ],
    )));
  }

  //footer
  Widget footer(size) {
    return Container(
      padding: const EdgeInsets.only(top: 80),
        height: 400,
        width: size,
        color: const Color.fromARGB(255, 10, 26, 34),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          SizedBox(
              width: 200,
              child: Column(
                children: [
                  TextButton.icon(
                      icon: const Icon(Icons.lock),
                      onPressed: () {},
                      label: const Text('UB LOGIN',
                          style: TextStyle(fontSize: 30))),
                  Image.asset(
                    'assets/images/logo-bw-sml.png',
                  ),
                  const Text('Private Bag UB 0022'),
                  const Text('Gaborone, Botswana'),
                  const Text('+(267) 355 0000'),
                  const Text('Plot 4775 Notwane Rd.')
                ],
              )),
          SizedBox(
              width: 200,
              child: Column(
                children: [
                  const Text('Departments',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: Colors.grey)),
                  const SizedBox(
                    height: 15,
                  ),
                  Link(
                    uri: Uri.parse(
                        'https://www.ub.bw/discover/faculties-and-departments/departments-a-z'),
                    target: LinkTarget.blank,
                    builder: (BuildContext ctx, FollowLink? openLink) {
                      return TextButton(
                        onPressed: openLink,
                        child: const Text(
                          'Academic A-Z', style: TextStyle(color: Colors.grey)
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 5),
                  Link(
                    uri: Uri.parse(
                        'https://www.ub.bw/discover/administration-and-support'),
                    target: LinkTarget.blank,
                    builder: (BuildContext ctx, FollowLink? openLink) {
                      return TextButton(
                        onPressed: openLink,
                        child: const Text(
                          'Administration and Support', style: TextStyle(color: Colors.grey)
                        ),
                      );
                    },
                  ),
                ],
              )),
          SizedBox(
              width: 300,
              child: Column(
                children: [
                  const Text('Online Systems',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: Colors.grey)),
                  const SizedBox(
                    height: 15,
                  ),
                  Link(
                    uri: Uri.parse(
                        'https://login.microsoftonline.com/222fdcbc-d8fd-45ec-a507-5999b5c5a72f/oauth2/authorize?client%5Fid=00000003%2D0000%2D0ff1%2Dce00%2D000000000000&response%5Fmode=form%5Fpost&response%5Ftype=code%20id%5Ftoken&resource=00000003%2D0000%2D0ff1%2Dce00%2D000000000000&scope=openid&nonce=DEA3D7AB74C917C6459EEA17FCA454BC85D279B359C830A8%2D333D8950C878C0D6DCB833A2A8A8FBCC4CD51ABBD10848FBA15F02B15BB10C12&redirect%5Furi=https%3A%2F%2Funibots%2Esharepoint%2Ecom%2F%5Fforms%2Fdefault%2Easpx&state=OD0w&claims=%7B%22id%5Ftoken%22%3A%7B%22xms%5Fcc%22%3A%7B%22values%22%3A%5B%22CP1%22%5D%7D%7D%7D&wsucxt=1&cobrandid=11bd8083%2D87e0%2D41b5%2Dbb78%2D0bc43c8a8e8a&client%2Drequest%2Did=7184a7a0%2Dd0ad%2D6000%2D7236%2Dbc748ebd8c16'),
                    target: LinkTarget.blank,
                    builder: (BuildContext ctx, FollowLink? openLink) {
                      return TextButton(
                        onPressed: openLink,
                        child: const Text(
                          'My Mmadikolo', style: TextStyle(color: Colors.grey)
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 5),
                  Link(
                    uri: Uri.parse(
                        'http://morojwa.ub.bw:7001/psp/cs9prod/?cmd=login&languageCd=ENG&'),
                    target: LinkTarget.blank,
                    builder: (BuildContext ctx, FollowLink? openLink) {
                      return TextButton(
                        onPressed: openLink,
                        child: const Text(
                          'Student Administration System (ASAS)', style: TextStyle(color: Colors.grey)
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 5),
                  Link(
                    uri: Uri.parse(
                        'https://moithuti-web1.ub.ac.bw/login/index.php'),
                    target: LinkTarget.blank,
                    builder: (BuildContext ctx, FollowLink? openLink) {
                      return TextButton(
                        onPressed: openLink,
                        child: const Text(
                          'Moodle Classes', style: TextStyle(color: Colors.grey)
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 5),
                  Link(
                    uri: Uri.parse('https://linyanti.ub.bw/'),
                    target: LinkTarget.blank,
                    builder: (BuildContext ctx, FollowLink? openLink) {
                      return TextButton(
                        onPressed: openLink,
                        child: const Text(
                          'Library Catalogue', style: TextStyle(color: Colors.grey)
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 5),
                  Link(
                    uri: Uri.parse(
                        'https://converis.ub.bw/converis/portal/overview?lang=en_GB'),
                    target: LinkTarget.blank,
                    builder: (BuildContext ctx, FollowLink? openLink) {
                      return TextButton(
                        onPressed: openLink,
                        child: const Text(
                          'Research Management System', style: TextStyle(color: Colors.grey)
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 5),
                  Link(
                    uri: Uri.parse(
                        'https://bonno.ub.bw/RunFeature/RunFeature?ftl=X38027bb9be764d4f80b7573d8ed8a975'),
                    target: LinkTarget.blank,
                    builder: (BuildContext ctx, FollowLink? openLink) {
                      return TextButton(
                        onPressed: openLink,
                        child: const Text(
                          'Residence Management System', style: TextStyle(color: Colors.grey)
                        ),
                      );
                    },
                  ),
                ],
              )),
        ]));
  }

  Widget customContainer({title,required Color color,required String url}) {
    return Container(
        height: 300,
        width: 530,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: Link(
                            uri: Uri.parse(
                                url),
                            target: LinkTarget.blank,
                            builder: (BuildContext ctx, FollowLink? openLink) {
                              return TextButton(
                                onPressed: openLink,
                                child: Text(title,
                                    style: const TextStyle(color: Colors.white, fontSize: 30)),
                              );
                            },
                          ),
        ));
  }

  Widget formContainer(context) {
    final stateManager = Provider.of<StateManager>(context);
    return Form(
        key: key,
        child: Column(
          children: [
            Text('Report Anonymously',style: Theme.of(context).textTheme.headlineMedium,),
            const SizedBox(height: 20),
            SizedBox(
              width: 300,
              height: 35,
              child: TextFormField(
                controller: offender,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "offender name required";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF707070), width: .5)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 247, 244, 244),
                          width: .5)),
                  hintText: "Offendrs name",
                  hintStyle: const TextStyle(height: 0.5),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 300,
              height: 35,
              child: TextFormField(
                controller: location,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Location required";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF707070), width: .5)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 247, 244, 244),
                          width: .5)),
                  hintText: "Harassment location",
                  hintStyle: const TextStyle(height: 0.5),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 300,
              height: 35,
              child: TextFormField(
                controller: phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Phone required";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF707070), width: .5)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 247, 244, 244),
                          width: .5)),
                  hintText: "Phone number",
                  hintStyle: const TextStyle(height: 0.5),
                ),
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
                height: 35,
                width: 300,
                child: TextFormField(
                  controller: harassmentType,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Harassment type required";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0xFF707070), width: .5)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 247, 244, 244),
                            width: .5)),
                    hintText: "Harassment type",
                    hintStyle: const TextStyle(height: 0.5),
                  ),
                )),
            const SizedBox(height: 14),
            SizedBox(
              width: 300,
              child: TextFormField(
                controller: dateController,
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF707070), width: .5)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 247, 244, 244),
                          width: .5)),
                  hintText: "Select date",
                  hintStyle: const TextStyle(height: 0.5),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Date not set";
                  } else {
                    return null;
                  }
                },
                onTap: () async {
                  DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    dateController.text = date.toString();
                  }
                },
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: 300,
              height: 100,
              child: TextFormField(
                controller: description,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "* required field";
                  } else {
                    return null;
                  }
                },
                minLines: 2,
                maxLines: 5,
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF707070), width: .5)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: const BorderSide(
                          color: Color(0xFF707070), width: .5)),
                  hintText: "DESCRIPTION",
                  hintStyle: const TextStyle(height: 0.5),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 40,
              width: 150,
              child: loading
                  ? const Center(child: CircularProgressIndicator())
                  : MaterialButton(
                      onPressed: () async {
                        if (key.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });

                          stateManager.submitAnonymousReport(
                              location: location.text,
                              offender: offender.text,
                                phone: phone.text,
                                harassmentType: harassmentType.text,
                                date: dateController.text,
                                description: description.text);

                          //sending report to the database
                          Future.delayed(const Duration(seconds: 4), () {

                            
                          
                          setState(() {
                            loading = false;
                          });
                          
                            //alert when the report has been sent
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Alert"),
                                content: const Text(
                                    "The report has been submitted successfully"),
                                actions: [
                                  TextButton(
                                    child: const Text("Close"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                          });

                        }
                      },
                      child: const Text('Submit report')),
            )
          ],
        ));
  }
}
