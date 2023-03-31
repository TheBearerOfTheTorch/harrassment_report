import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../states/states.dart';
import '../features.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static MaterialPage page({LocalKey? key}) {
    return MaterialPage(key: key, child: const LoginScreen());
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //show error
  bool showErrorWithTime = false;
  @override
  Widget build(BuildContext context) {
    //variables
    final size = MediaQuery.of(context).size;
    final _formKey = GlobalKey<FormState>();

    //providers
    final _authState = Provider.of<StateManager>(context);
    final _loading = Provider.of<LoadingStateManager>(context);
    final _error = Provider.of<ErrorStateManager>(context);
    final _auth = Provider.of<AuthenticationStateManager>(context);

    ScrollController scroll = ScrollController();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Scrollbar(
        controller: scroll,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 400,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(5.0),
                          gradient: const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color(0xFF05182D),
                                Color(0xFF092A45),
                                Color(0xFF0D2339)
                              ]),
                          //border corner radius
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              //color of shadow
                              blurRadius: 3,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Consumer<FieldsStateManager>(
                              builder: (context, fieldStateManager, child) {
                            return Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: size.height / 50,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Center(
                                            child: Text(
                                          "Log in",
                                          style: TextStyle(
                                            color: Color(0xFF4481A6),
                                            fontSize: 30,
                                          ),
                                        )),
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Icon(Icons.cancel))
                                      ],
                                    ),
                                    SizedBox(
                                      height: size.height / 25,
                                    ),
                                    SizedBox(
                                      width: 350,
                                      height: 40,
                                      child: TextFormField(
                                        controller:
                                            fieldStateManager.emailController,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            Provider.of<FieldsStateManager>(
                                                    context,
                                                    listen: false)
                                                .emailFilled = false;
                                            return "Email or phone required";
                                          } else {
                                            Provider.of<FieldsStateManager>(
                                                    context,
                                                    listen: false)
                                                .emailFilled = true;
                                          }
                                        },
                                        decoration: InputDecoration(
                                          fillColor: const Color(0xFF05182D),
                                          focusColor: const Color(0xFF05182D),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xFF707070),
                                                      width: .5)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              borderSide: const BorderSide(
                                                  color: Color(0xFF707070),
                                                  width: .5)),
                                          hintText: "Email or Phone number",
                                          hintStyle:
                                              const TextStyle(height: 0.5),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height / 60,
                                    ),
                                    SizedBox(
                                      width: 350.0,
                                      height: 40.0,
                                      child: TextFormField(
                                        controller: fieldStateManager
                                            .passwordController,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            Provider.of<FieldsStateManager>(
                                                    context,
                                                    listen: false)
                                                .passwordFilled = false;
                                            return "Password required";
                                          } else {
                                            Provider.of<FieldsStateManager>(
                                                    context,
                                                    listen: false)
                                                .passwordFilled = true;
                                          }
                                        },
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          focusedBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xFF707070),
                                                      width: .5)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              borderSide: const BorderSide(
                                                  color: Color(0xFF707070),
                                                  width: .5)),
                                          hintText: "Password",
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height / 55,
                                    ),
                                    SizedBox(
                                      width: 350,
                                      height: 40,
                                      child: _loading.loadingRequest
                                          ? MaterialButton(
                                              mouseCursor:
                                                  MouseCursor.uncontrolled,
                                              onPressed: () {},
                                              child:
                                                  const CircularProgressIndicator
                                                      .adaptive())
                                          : MaterialButton(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                              child: const Text(
                                                'Log in',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              onPressed: () async {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  //start loading spinner
                                                  _loading.isLoadingRequired =
                                                      true;

                                                  //log in and get error
                                                  var errorValue = await _auth
                                                      .signInWithEmail(
                                                          email: fieldStateManager
                                                              .emailController
                                                              .text,
                                                          password:
                                                              fieldStateManager
                                                                  .passwordController
                                                                  .text);

                                                  //check error
                                                  if (errorValue != null) {
                                                    _error.setIsAuthErrorFound =
                                                        true;
                                                    _error.setAuthErrorToErrorValue =
                                                        errorValue;

                                                    //printing out the error
                                                    print(errorValue);
                                                  } else {
                                                    //updating loggin state
                                                    _authState.userLoggedIn =
                                                        true;
                                                  }
                                                  _loading.isLoadingRequired =
                                                      false;
                                                }
                                              },
                                            ),
                                    ),
                                    SizedBox(
                                      height: size.height / 50,
                                    ),
                                    TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          "Forgot password?",
                                          style: TextStyle(color: Colors.red),
                                        )),
                                    const Divider(
                                      indent: 2,
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      height: 38,
                                      child: MaterialButton(
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  const RegisterScreen(),
                                            );
                                          },
                                          child: const Text(
                                            "Create a new account",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          )),
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ));
                          }),
                        ),
                      ),
                      _error.isAuthErrorFound
                          ? Positioned(
                              top: 10,
                              left: 110,
                              child: ShowErrorAlert(
                                errorValue: _error.getAuthErrorValue,
                              ))
                          : const Text(""),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
