import 'package:diabeta_app/components/constants.dart';
import 'package:diabeta_app/screens/main_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  get kPrimaryColor => null;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Image.asset(
                  "assets/images/frontlogo.png",
                  width: 300,
                  height: 350,
                ),
              ),
              const Center(
                child: Text(
                  "DiaBeta",
                  style: TextStyle(fontSize: 40, color: Colors.teal),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: TextField(
                      controller: _userNameController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        labelText: 'Username',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: TextField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                    ),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints.tightFor(height: 45),
                      child: ElevatedButton(
                        onPressed: () {
                          // if (_userNameController.text == "amal" &&
                          //     _passwordController.text == "1234") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainScreen()),
                            );
                          // } else {
                          //   const snackBar = SnackBar(
                          //       content: Text("Invalid username or password."),
                          //       backgroundColor: Colors.red);
                          //   ScaffoldMessenger.of(context)
                          //       .showSnackBar(snackBar);
                          // }
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          elevation: 0,
                          primary: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical:8.0),
                    child: Center(
                        child: Text(
                      "- or -",
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                    ),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints.tightFor(height: 40),
                      child: ElevatedButton(
                        onPressed: () {

                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          elevation: 0,
                          primary: kSecondaryColor,
                        ),
                      ),
                    ),
                  ),
                  // FutureBuilder(
                  //   future: Authentication.initializeFirebase(context),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.hasError) {
                  //       return const Text('Error initializing Firebase');
                  //     } else if (snapshot.connectionState ==
                  //         ConnectionState.done) {
                  //       return const Padding(
                  //         padding: EdgeInsets.symmetric(horizontal: 40),
                  //         child: GoogleSignInButton(),
                  //       );
                  //     }
                  //     return Container(
                  //       width: 20,
                  //       child: const CircularProgressIndicator(
                  //         valueColor: AlwaysStoppedAnimation<Color>(
                  //           Colors.blue,
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}