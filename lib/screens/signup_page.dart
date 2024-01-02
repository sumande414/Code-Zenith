import 'package:flutter/material.dart';
import 'package:friendz_code/functions/firebase_auth.dart';
import 'package:friendz_code/models/codeforce_model.dart';
import 'package:friendz_code/widgets/form_container_widget.dart';
import 'package:friendz_code/api/api.dart';
import 'package:friendz_code/widgets/lookup_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController username = TextEditingController();
  final TextEditingController handle = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool login = false;
  final _formKey = GlobalKey<FormState>();
  late Future<Codeforces?> user;
  bool isHandleValidated = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 93, 176, 117),
      body: Column(
        children: [
          Spacer(),
          Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            height: 490,
            width: double.infinity,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(login ? "Sign in" : "Sign up",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  login
                      ? Container()
                      : Container(
                          width: 350,
                          child: FormContainerWidget(
                            controller: username,
                            hintText: "Username",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "username cannot be empty";
                              }
                            },
                          )),
                  SizedBox(height: 10),
                  login
                      ? Container()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: 200,
                                child: FormContainerWidget(
                                  controller: handle,
                                  hintText: "Codeforces Handle",
                                  onChanged: (str) {
                                    isHandleValidated = false;
                                  },
                                  validator: (value) {
                                    if (!isHandleValidated) {
                                      return "Click on lookup and confirm";
                                    }
                                  },
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 140,
                              height: 50,
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  try {
                                    user = api.fetchHandle(handle.text);
                                  } catch (e) {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Problem fetching handle. Try again");
                                  }
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      actions: [
                                        FutureBuilder<Codeforces?>(
                                            future: user,
                                            builder: (context, snapshot) {
                                              print(
                                                  "Snapshot data: ${snapshot.data}");
                                              if (snapshot.hasData) {
                                                return Column(
                                                  children: [
                                                    LookupCard(
                                                        user: snapshot
                                                            .data!.results[0]),
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          isHandleValidated =
                                                              true;
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text("Confirm"))
                                                  ],
                                                );
                                              } else {
                                                return CircularProgressIndicator();
                                              }
                                            })
                                      ],
                                    ),
                                  );
                                },
                                icon: Icon(Icons.search),
                                label: Text("Lookup"),
                              ),
                            )
                          ],
                        ),
                  SizedBox(height: 10),
                  Container(
                      width: 350,
                      child: FormContainerWidget(
                        controller: email,
                        hintText: "Email",
                        validator: (value) {
                          if (value == null || !value.contains('@')) {
                            return "email is incorrect";
                          }
                        },
                      )),
                  SizedBox(height: 10),
                  Container(
                      width: 350,
                      child: FormContainerWidget(
                        controller: password,
                        hintText: "Password",
                        isPasswordField: true,
                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return "minimum characters is 6";
                          }
                        },
                      )),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        login
                            ? signin(email.text, password.text)
                            : signup(email.text, password.text, handle.text,
                                username.text);
                      }
                    },
                    child: Container(
                      height: 40,
                      width: 350,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 93, 176, 117),
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                          child: Text(
                        login ? "Sign In" : "Get Started",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(login ? "Not Signed up?" : "Already Signed up?"),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              login = !login;
                            });
                          },
                          child: Text(login ? "Sign Up" : "Sign In"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
