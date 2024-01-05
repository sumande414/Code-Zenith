import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:friendz_code/models/codeforce_model.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

String handles = "";
late Future<Codeforces> friends;

class _FriendsScreenState extends State<FriendsScreen> {
  @override
  void initState() {
    print("object");
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('friends')
        .get()
        .then((value) {
      while (true) {
        print(value.docs.length);
        print(value.docs[0]['handle']);
        if (value.docs.isNotEmpty) {
          value.docs.map((e) => {handles = "$handles;${e['handle']}"}).toList();
          break;
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(handles);
  }
}
