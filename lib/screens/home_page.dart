import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:friendz_code/functions/database_functions.dart';
import 'package:friendz_code/widgets/coder_card.dart';
import 'package:friendz_code/widgets/form_container_widget.dart';
import 'package:friendz_code/widgets/handle_input_with_validator.dart';
import 'package:friendz_code/models/codeforce_model.dart';
import 'package:friendz_code/api/api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController handle = TextEditingController();
  TextEditingController nickname = TextEditingController();
  late Codeforces user;
  var currentUserEmail = FirebaseAuth.instance.currentUser!.email;
  final _formKey = GlobalKey<FormState>();
  Stream<DocumentSnapshot<Map<String, dynamic>>> fetchedStream =
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .snapshots();

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
                  handle: handle,
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
                    Navigator.pop(context);
                  }
                },
                child: Text("Confirm"))
          ],
        ),
      );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          "Dashboard",
          style: TextStyle(color: Colors.black, fontSize: 25),
        )),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: fetchedStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return FutureBuilder<Codeforces?>(
                      future: api.fetchHandle(snapshot.data!['handle']),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 78, 68, 68),
                            backgroundImage: NetworkImage(
                              snapshot.data!.results[0].avatar,
                            ),
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      });
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              icon: Icon(
                Icons.logout,
                color: Colors.green,
              ))
        ],
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: fetchedStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return FutureBuilder<Codeforces?>(
                future: api.fetchHandle(snapshot.data!['handle']),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var coder = snapshot.data!.results[0];
                    return CoderCard(
                      handle: coder.handle,
                      avatar: coder.avatar,
                      rank: coder.rank,
                      rating: coder.rating,
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          OpenDialog();
        },
        backgroundColor: Colors.green,
        label: Text(
          "Add Friends",
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
