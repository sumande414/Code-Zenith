import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:friendz_code/models/codeforce_model.dart';
import 'package:friendz_code/api/api.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

String handles = "";
Future<Codeforces>? friends;

class _FriendsScreenState extends State<FriendsScreen> {
  void dbAndApiCall() {
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
  void initState() {
    dbAndApiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: friends,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var friendsList = snapshot.data!.results;
          friendsList = friendsList.toSet().toList();
          friendsList
              .sort((a, b) => ((b.rating ?? 0).compareTo(a.rating ?? 0)));
          return RefreshIndicator(
            child: ListView.builder(
              itemCount: friendsList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("${friendsList[index].handle}"),
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(friendsList[index].avatar)),
                  subtitle: Text("${friendsList[index].rank}"),
                  trailing: Text("${friendsList[index].rating}"),
                );
              },
              physics: AlwaysScrollableScrollPhysics(),
            ),
            onRefresh: () {
              return Future.delayed(Duration(seconds: 1), () {
                setState(() {
                  dbAndApiCall();
                });
              });
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
