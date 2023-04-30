import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../states/states.dart';
import '../../features.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  TextEditingController phone = TextEditingController();
  TextEditingController harassmentType = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController offender = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController location = TextEditingController();

  final key = GlobalKey<FormState>();
  var dropItem;
  List items = [
    'Unwanted and deliberate physical contact',
    'Offensive gestures or actions of a sexual nature including indecent exposure',
    'Gratuitous display of sexually explicit written or audio visual materials',
    'Sexual favouritism',
    'Quid pro qou harassment',
    'Unwanted verbal comments of a sexual nature',
    'Display of offensive email,screen savers or pornographic electronic images',
    'Subtle or explicit verbal demands for,or offfers of, sexual favours',
    'Verbal or written comments with sexual overtones,sex-related jokes or insults',
    'Unwelcome and inappropriate enquiries about a once sex life',
    'Verbal sexual harassment such as unwelcome innuedos,suggestions and hints',
    'Persistent unwanted attention',
    'Other'
  ];

  bool loading = false;
  bool checkBox = false;
  int currentstep = 1;

  bool checkbox1 = false;
  bool checkbox2 = false;
  bool checkbox3 = false;

  bool checkboxClear1 = false;
  bool checkboxClear2 = false;

  bool priority = false;

  @override
  Widget build(BuildContext context) {
    //final loading = Provider.of<LoadingStateManager>(context);
    final stateManagement = Provider.of<StateManager>(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Form(
        key: key,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Center(
                        child: Text('Disclaimer',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 23))),
                    const Text(
                        'THE UB REPORTING PORTAL IS NOT AN EMERGENCY SERVICE. Do not use this form to report immediate threats to life. If you require emergency assistance, please contact the university protection services or contact the local authorities. Disclosures of sexual harassment and/or other sexual misconduct submitted through this service may not receive immediate response.',
                        maxLines: 3),
                    const SizedBox(height: 15),
                    CheckboxListTile(
                        value: checkBox,
                        title: const Text(
                            'I agree to the University sexual harassment policy and understand what it entails'),
                        onChanged: (value) {
                          setState(() {
                            checkBox = value!;
                          });
                        })
                  ],
                ),
              ),
            ),
            const Divider(),

            ///Form input begins here
            ///
            Stepper(
                currentStep: currentstep - 1,
                onStepContinue: () {
                  if (checkbox2 || checkbox3) {
                    if (currentstep < 4) {
                      setState(() {
                        currentstep += 1;
                      });
                    }
                    if(currentstep == 4){
                      //submit the Form
                      if (key.currentState!.validate()) {
                                            setState(() {
                                              loading = true;
                                            });

                                            stateManagement.submitReport(
                                                once: checkbox1,
                                                twice: checkbox2,
                                                more: checkbox3,
                                                offender: offender.text,
                                                phone: phone.text,
                                                location: location.text,
                                                harassmentType: dropItem,
                                                date: dateController.text,
                                                description: description.text);

                                            //sending report to the database
                                            Future.delayed(
                                                const Duration(seconds: 4), () {
                                              setState(() {
                                                loading = false;
                                              });
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text("Alert"),
                                                    content: const Text(
                                                        "The report has been submitted successfully"),
                                                    actions: [
                                                      TextButton(
                                                        child:
                                                            const Text("Close"),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            });
                                          }
                    }
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Priority alert'),
                            content: const Text(
                                'The system has identified this to not be a sexual harassmnet according to UB policies'),
                            actions: [
                              TextButton(
                                child: const Text("Close"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                  }
                },
                onStepCancel: () {
                  if (currentstep > 1) {
                    setState(() {
                      currentstep -= 1;
                    });
                  }
                },
                steps: [
                  Step(
                      title: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 1.1,
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Although not limited to, please choose the sexual harassment conduct that you have experienced or close enough what you have experienced:',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      content: Column(
                        children: [
                          DropdownButton(
                            items: items
                                .map((value) => DropdownMenuItem(
                                      value: value,
                                      child: Text(
                                        value,
                                      ),
                                    ))
                                .toList(),
                            onChanged: (onchangedValue) {
                              setState(() {
                                dropItem = onchangedValue;
                              });
                            },
                            value: dropItem,
                            isExpanded: false,
                            hint: const Text(
                              'Please select sexual harassment conduct you have experienced ',
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                              'How many times has an accident of sexual harassment occurred?',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),

                          ///
                          ///The checkboxes
                          SizedBox(
                            width: 300,
                            child: CheckboxListTile(
                              title: const Text('Once'),
                              value: checkbox1,
                              onChanged: (value) {
                                setState(() {
                                  checkbox1 = value!;
                                  checkbox2 = false;
                                  checkbox3 = false;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: 300,
                            child: CheckboxListTile(
                              title: const Text('Twice'),
                              value: checkbox2,
                              onChanged: (value) {
                                setState(() {
                                  checkbox1 = false;
                                  checkbox3 = false;
                                  checkbox2 = value!;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: 300,
                            child: CheckboxListTile(
                              title: const Text('More than two times'),
                              value: checkbox3,
                              onChanged: (value) {
                                setState(() {
                                  checkbox1 = false;
                                  checkbox2 = false;
                                  checkbox3 = value!;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 20),

                          ///
                          ///Second checkboxes
                          const Text(
                              'Have you made it clear to the person(s) engaged in the incident(s) or conduct that the sexual advancement is unacceptable?',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 110,
                            child: CheckboxListTile(
                              title: const Text('Yes'),
                              value: checkboxClear1,
                              onChanged: (value) {
                                setState(() {
                                  checkboxClear1 = value!;
                                  checkboxClear2 = false;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: 110,
                            child: CheckboxListTile(
                              title: const Text('No'),
                              value: checkboxClear2,
                              onChanged: (value) {
                                setState(() {
                                  checkboxClear2 = value!;
                                  checkboxClear1 = false;
                                });
                              },
                            ),
                          ),
                        ],
                      )),
                  Step(
                      title: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 1.1,
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Provide the bellow information to ensure you get to proceed to the other stage',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      content: Column(
                        children: [
                          const Text(
                              'Please provide the date(s) when the incident occurred?',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 600,
                            child: TextFormField(
                              controller: dateController,
                              decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFF707070), width: .5)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 247, 244, 244),
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
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                              'Please provide additional detail where the incident(s) or conduct occurred. We recognise that the incident(s) or conduct may have not occurred in a particular or single location. You may indicate if the incident(s) or conduct occurred online(e.g email, social media',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 600,
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
                                    borderSide: BorderSide(
                                        color: Color(0xFF707070), width: .5)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 247, 244, 244),
                                        width: .5)),
                                hintText: "Location required",
                                hintStyle: const TextStyle(height: 0.5),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                              'Please describe in your own words the sexual harassment you have experienced',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 600,
                            child: TextFormField(
                              controller: description,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "* required field";
                                } else {
                                  return null;
                                }
                              },
                              minLines: 6,
                              maxLines: 6,
                              decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFF707070), width: .5)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: const BorderSide(
                                        color: Color(0xFF707070), width: .5)),
                                hintText: "DESCRIPTION",
                                hintStyle: const TextStyle(height: 0.5),
                              ),
                            ),
                          ),
                        ],
                      )),
                  Step(
                      title: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 1.1,
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)),
                            child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Provide the offenders details. Example Their full names, and Their contact details',style: TextStyle(color: Colors.white),),
                            ),
                          ),
                      ),
                      content: Column(
                        children: [
                          SizedBox(
                                width: 600,
                                child: TextFormField(
                                  controller: offender,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Name required";
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF707070),
                                            width: .5)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                255, 247, 244, 244),
                                            width: .5)),
                                    hintText: "Offenders name",
                                    hintStyle: const TextStyle(height: 0.5),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: 600,
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
                                        borderSide: BorderSide(
                                            color: Color(0xFF707070),
                                            width: .5)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                255, 247, 244, 244),
                                            width: .5)),
                                    hintText: "Phone number",
                                    hintStyle: const TextStyle(height: 0.5),
                                  ),
                                ),
                              ),

                        ],
                      )),
                      Step(
                      title: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 1.1,
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Uploads evidence that supports your accusations if any',style: TextStyle(color: Colors.white),),
                            ),
                      ),
                      content: Column(
                        children: [
                          FilesDragDrop(passListEmpty: (vallsd){

                          },)
                          //ImagePickHelper()
                        ],
                      ))
                ]),
          ],
        ),
      ),
    );
  }
}
