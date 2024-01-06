import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:friendz_code/models/codeforce_model.dart';
import 'package:friendz_code/models/participated_contests.dart';

import '../widgets/participated_contest_card.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key, required this.participatedContests, required this.username});

  final Future<ParticipatedContests>? participatedContests;
  final String? username;
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return ParticipatedContestsCard(participatedContests: widget.participatedContests);
  }
}
