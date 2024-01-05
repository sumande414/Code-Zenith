import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:friendz_code/models/codeforce_model.dart';

import '../widgets/coder_card.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    super.key,
    required this.user,
    required this.username
  });

  final Future<Codeforces>? user;
  final String? username;
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            FutureBuilder<Codeforces?>(
              future: widget.user,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var coder = snapshot.data!.results[0];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 1, 15, 1),
                        child: Text(
                          "Welcome, ${widget.username}.\nHere are your stats as fetched from codeforces.com.",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      CoderCard(user: coder),
                    ],
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            )
          ],
        );
  }
}