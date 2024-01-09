import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:friendz_code/functions/database_functions.dart';
import 'package:friendz_code/widgets/form_container_widget.dart';
import 'package:friendz_code/widgets/handle_input_with_validator.dart';

class AddFriendWizard extends StatefulWidget {
  AddFriendWizard({
    super.key,
  });

  @override
  State<AddFriendWizard> createState() => _AddFriendWizardState();
}

class _AddFriendWizardState extends State<AddFriendWizard> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController handle = TextEditingController();
  TextEditingController nickname = TextEditingController();

  OpenDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Add Friend"),
          actions: [
            Form(
              key: _formKey,
              child: Column(children: [
                FormContainerWidget(
                    hintText: "Nickname",
                    controller: nickname,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Nickname cannot be empty";
                      }
                    }),
                SizedBox(
                  height: 10,
                ),
                HandleInputWithValidator(
                  handleController: handle,
                  scale: 0.8,
                )
              ]),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    addFriend(
                        email: FirebaseAuth.instance.currentUser!.email!,
                        handle: handle.text,
                        nickname: nickname.text);
                    Fluttertoast.showToast(
                        msg: "Friend Added", toastLength: Toast.LENGTH_SHORT);
                    Fluttertoast.showToast(
                        msg:
                            "Swipe Down to Refresh");
                    Navigator.pop(context);
                  }
                },
                child: Text("Confirm"))
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        OpenDialog();
      },
      backgroundColor: Color.fromARGB(255, 255, 187, 0),
      label: Text(
        "Add Friends",
        style: TextStyle(color: Colors.black),
      ),
      icon: Icon(
        Icons.add,
        color: Colors.black,
      ),
    );
  }
}
