import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:friendz_code/functions/firebase_auth.dart';
import 'package:friendz_code/widgets/form_container_widget.dart';
import 'package:friendz_code/widgets/handle_input_with_validator.dart';
import 'package:friendz_code/functions/database_functions.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen(
      {super.key, required this.handle, required this.username});
  final String handle;
  final String username;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController _oldPass = TextEditingController();
  TextEditingController _newPass = TextEditingController();
  TextEditingController _retypedNewPass = TextEditingController();
  TextEditingController _deletePass = TextEditingController();
  TextEditingController _newHandle = TextEditingController();

  var _changepasskey = GlobalKey<FormState>();
  var _changehandlekey = GlobalKey<FormState>();
  TextStyle style = const TextStyle(
      fontSize: 15, color: Colors.white, fontWeight: FontWeight.w800);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Color.fromARGB(255, 42, 5, 71),
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Color.fromARGB(255, 110, 59, 142),
            child: Form(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(children: [
                      Text("Email:", style: style),
                      Text(
                        "\t\t${FirebaseAuth.instance.currentUser!.email}",
                        style: style,
                      )
                    ]),
                    Row(
                      children: [
                        Text(
                          "Codeforces Handle:",
                          style: style,
                        ),
                        Text(
                          "\t\t${widget.handle}",
                          style: style,
                        ),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: ((context) => AlertDialog(
                                        title: Text("Change Handle"),
                                        actions: [
                                          Column(
                                            children: [
                                              Form(
                                                  key: _changehandlekey,
                                                  child:
                                                      HandleInputWithValidator(
                                                          handleController:
                                                              _newHandle,
                                                          scale: 0.8)),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    if (_changehandlekey
                                                        .currentState!
                                                        .validate()) {
                                                      editUserHandle(
                                                          newHandle:
                                                              _newHandle.text,
                                                          email: FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .email!);
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "Handle changed. Sign in again to see the changes");
                                                      FirebaseAuth.instance
                                                          .signOut();
                                                    }
                                                  },
                                                  child: Text("Confirm"))
                                            ],
                                          )
                                        ],
                                      )));
                            },
                            icon: Icon(
                              Icons.edit_square,
                              color: Colors.white,
                            ))
                      ],
                    ),
                    ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text("Change Password"),
                                    actions: [
                                      Form(
                                        key: _changepasskey,
                                        child: Column(children: [
                                          FormContainerWidget(
                                            controller: _oldPass,
                                            hintText: "Old Password",
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          FormContainerWidget(
                                            controller: _newPass,
                                            hintText: "New Password",
                                            validator: (value) {
                                              if (value == null ||
                                                  value.length < 6) {
                                                return "Minimum length should be 6";
                                              }
                                            },
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          FormContainerWidget(
                                            controller: _retypedNewPass,
                                            hintText: "Retype New Password",
                                            validator: (value) {
                                              if (value != _newPass.text) {
                                                return "Does not match previous field";
                                              }
                                            },
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          ElevatedButton(
                                              onPressed: () {
                                                if (_changepasskey.currentState!
                                                    .validate()) {
                                                  changePassword(
                                                      oldPass: _oldPass.text,
                                                      newPass: _newPass.text);
                                                }
                                              },
                                              child: Text("Confirm"))
                                        ]),
                                      )
                                    ],
                                  ));
                        },
                        icon: Icon(Icons.change_circle_outlined),
                        label: Text("Change Password")),
                    ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text("Delete Account"),
                                    actions: [
                                      Text(
                                          "This is a destructive action. All data will be deleted and it can't be retrieved."),
                                      FormContainerWidget(
                                        controller: _deletePass,
                                        hintText: "Password",
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            deleteAccount(
                                                password: _deletePass.text);
                                          },
                                          child: Text("Confirm"))
                                    ],
                                  ));
                        },
                        icon: Icon(Icons.delete_forever_outlined),
                        label: Text("Delete Account"))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
