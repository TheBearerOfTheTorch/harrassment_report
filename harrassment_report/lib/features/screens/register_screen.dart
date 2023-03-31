import 'package:flutter/material.dart';
// import 'package:iithindi/components/components.dart';
// import 'package:iithindi/models/models.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';
import '../../states/states.dart';
import '../features.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  static MaterialPage page({LocalKey? key}) {
    return MaterialPage(key: key, child: const RegisterScreen());
  }

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //light
  final theme = AppTheme.lightTextTheme;

  //dark
  final theme2 = AppTheme.darkTextTheme;

  //formKey
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //providers
    final auth = Provider.of<AuthenticationStateManager>(context);
    final loading = Provider.of<LoadingStateManager>(context);
    final error = Provider.of<ErrorStateManager>(context);
    final field = Provider.of<FieldsStateManager>(context);

    ScrollController scroll = ScrollController();

    final Shader iphoneShader =
        const LinearGradient(colors: [Color(0xff070D14), Color(0xff85D1EE)])
            .createShader(const Rect.fromLTWH(0, 100, 50, 2));

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SingleChildScrollView(
          controller: scroll,
          clipBehavior: Clip.hardEdge,
          child: Container(
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
            width: 450,
            height: 450,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Color(0xFF4481A6),
                          fontSize: 30,
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            field.setIsGenderNull = false;
                            Navigator.of(context).pop();
                          },
                          child: const Icon(Icons.cancel)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Few easy steps",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Consumer<FieldsStateManager>(
                    builder: (context, fieldStateManager, child) {
                  return Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    width: 205.0,
                                    height: 39.0,
                                    child: customTextField(context,
                                        hintText: " First name",
                                        obscureText: false,
                                        controller: fieldStateManager
                                            .regFirstnameController,
                                        validation: "Firstname is required")),
                                SizedBox(
                                    width: 205.0,
                                    height: 39.0,
                                    child: customTextField(context,
                                        hintText: " Last name",
                                        obscureText: false,
                                        controller: fieldStateManager
                                            .regLastnameController,
                                        validation: "Lastname is required")),
                              ],
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            SizedBox(
                                width: 440.0,
                                height: 39.0,
                                child: customTextField(context,
                                    hintText: " Email or Phone number",
                                    obscureText: false,
                                    controller: fieldStateManager
                                        .regMobileNumberController,
                                    validation: "Email or phone required")),
                            const SizedBox(
                              height: 11,
                            ),
                            SizedBox(
                                width: 440.0,
                                height: 39.0,
                                child: customTextField(context,
                                    hintText: "Password",
                                    obscureText: true,
                                    controller:
                                        fieldStateManager.regPasswordController,
                                    validation: "password missing")),
                            const SizedBox(
                              height: 11,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Gender",
                                  style: theme.subtitle2,
                                ),
                                IconButton(
                                    color: Colors.black,
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.assignment_late_outlined,
                                      size: 15,
                                    ))
                              ],
                            ),
                            //Gender picker will come here
                            customGenderPicker(context),
                            const SizedBox(
                              height: 18,
                            ),
                            //showing the terms line
                            Text(
                              "By clicking Sign Up, you agree to our Terms, "
                              "Privacy Policy and Cookie Policy. You may receive SMS "
                              "notifications from us that may come at any time.",
                              style: theme.subtitle2,
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            SizedBox(
                              height: 38,
                              width: 135,
                              child: loading.loadingRequest
                                  ? MaterialButton(
                                      mouseCursor: MouseCursor.uncontrolled,
                                      onPressed: () {},
                                      child: const CircularProgressIndicator(),
                                    )
                                  : MaterialButton(
                                      color: Theme.of(context).primaryColorDark,
                                      onPressed: () async {
                                        if (fieldStateManager
                                                .regGenderController ==
                                            null) {
                                          fieldStateManager.setIsGenderNull =
                                              true;
                                        } else {
                                          field.setIsGenderNull = false;
                                        }

                                        ///form validation
                                        if (_formKey.currentState!.validate()) {
                                          //checking birthday
                                          if (fieldStateManager
                                                  .regGenderController ==
                                              null) {
                                            field.setIsGenderNull = true;
                                          } else {
                                            //laoding spinner to true
                                            loading.isLoadingRequired = true;

                                            var errorValue =
                                                await auth.signUpWithEmail(
                                              firstname: fieldStateManager
                                                  .regFirstnameController.text,
                                              lastname: fieldStateManager
                                                  .regLastnameController.text,
                                              emailOrPhone: fieldStateManager
                                                  .regMobileNumberController
                                                  .text,
                                              gender: fieldStateManager
                                                  .regGenderController,
                                              role: "user",
                                              password: fieldStateManager
                                                  .regPasswordController.text,
                                            );

                                            //checking if theres an error
                                            if (errorValue != null) {
                                              error.setIsAuthErrorFound = true;
                                              error.setAuthErrorToErrorValue =
                                                  errorValue;
                                            }

                                            loading.isLoadingRequired = false;
                                          }
                                        }
                                      },
                                      child: Text(
                                        "Sign Up",
                                        style: theme2.headline2,
                                      )),
                            ),
                          ],
                        )),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
