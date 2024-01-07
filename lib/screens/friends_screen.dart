import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:friendz_code/functions/database_functions.dart';
import 'package:friendz_code/models/codeforce_model.dart';
import 'package:friendz_code/api/api.dart';
import 'package:friendz_code/screens/coder_info_screen.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key, required this.userHandle});
  final String? userHandle;
  static String handles = "";
  static Future<Codeforces>? friends;
  static void dbAndApiCall() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('friends')
        .get()
        .then((value) {
      do {
        value.docs.map((e) => {handles = "$handles;${e['handle']}"}).toList();
        if (handles != "") {
          friends = api.fetchHandle(handles);
        }
      } while (handles == "" && friends == null);
      handles = "";
    });
  }

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FriendsScreen.friends,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var friendsList = snapshot.data!.results;
          friendsList
              .sort((a, b) => ((b.rating ?? 0).compareTo(a.rating ?? 0)));
          return RefreshIndicator(
            child: ListView.builder(
              itemCount: friendsList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CoderInfoScreen(coder: friendsList[index], handle:friendsList[index].handle!)));
                  },
                  tileColor: widget.userHandle == friendsList[index].handle
                      ? Color.fromARGB(216, 255, 172, 7)
                      : Colors.transparent,
                  title: Text(
                    "${friendsList[index].handle}",
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(friendsList[index].avatar)),
                  subtitle: Text(
                    "${friendsList[index].rank}",
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Text(
                    "${friendsList[index].rating}",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
              physics: AlwaysScrollableScrollPhysics(),
            ),
            onRefresh: () {
              return Future.delayed(Duration(milliseconds: 300), () {
                setState(() {
                  FriendsScreen.dbAndApiCall();
                });
              });
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
