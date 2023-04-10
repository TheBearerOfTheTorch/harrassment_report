import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../states/states.dart';

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
  String dropItem = 'Select harassment type';
  List items = [
    'Unwanted touching',
    'Sexually explicit gestures',
    'Requests for sexual favors',
    'Catcalling'
  ];

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    //final loading = Provider.of<LoadingStateManager>(context);
    final stateManagement = Provider.of<StateManager>(context);
    return Center(
        child: Container(
            margin: const EdgeInsets.only(top: 30),
            width: 400,
            height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all()
            ),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Report Harassment",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 35),
              Form(
                  key: key,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 300,
                        height: 35,
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
                                    color: Color(0xFF707070), width: .5)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 247, 244, 244),
                                    width: .5)),
                            hintText: "Offenders name",
                            hintStyle: const TextStyle(height: 0.5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
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
                                borderSide: BorderSide(
                                    color: Color(0xFF707070), width: .5)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 247, 244, 244),
                                    width: .5)),
                            hintText: "Location required",
                            hintStyle: const TextStyle(height: 0.5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
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
                                borderSide: BorderSide(
                                    color: Color(0xFF707070), width: .5)),
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
                                borderSide: BorderSide(
                                    color: Color(0xFF707070), width: .5)),
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

                                    stateManagement.submitReport(
                                        offender: offender.text,
                                          phone: phone.text,
                                          location: location.text,
                                          harassmentType: harassmentType.text,
                                          date: dateController.text,
                                          description: description.text);

                                    //sending report to the database
                                    Future.delayed(const Duration(seconds: 4),
                                        () {
                                          setState(() {
                                      loading = false;
                                    });
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
                                color: Colors.red,
                                child: const Text('Submit report')),
                      )
                    ],
                  )),
            ])));
  }
}
