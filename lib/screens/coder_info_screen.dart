import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:friendz_code/functions/database_functions.dart';
import 'package:friendz_code/models/codeforce_model.dart' as cf;
import 'package:friendz_code/api/api.dart';
import 'package:friendz_code/widgets/participated_contest_card.dart';
import '../models/participated_contests.dart';

class CoderInfoScreen extends StatefulWidget {
  const CoderInfoScreen({super.key, required this.coder, required this.handle, required this.userHandle});
  final cf.Result coder;
  final String handle;
  final userHandle;

  @override
  State<CoderInfoScreen> createState() => _CoderInfoScreenState();
}

class _CoderInfoScreenState extends State<CoderInfoScreen> {
  Future<ParticipatedContests>? participatedContests;

  TextStyle coderInfoTextStyle =
      TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold);

  @override
  void initState() {
    participatedContests = api.fetchParticipatedContests(widget.handle);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Fluttertoast.showToast(
                      msg:
                          "This feature is not ready yet and will be included in future builds",
                      toastLength: Toast.LENGTH_LONG);
                },
                icon: Icon(
                  Icons.message_rounded,
                  color: Colors.yellow,
                )),
            IconButton(
                onPressed: (widget.handle != widget.userHandle)? () {
                  Fluttertoast.showToast(msg: "Removing ${widget.handle}");

                  removeFriend(
                      email: FirebaseAuth.instance.currentUser!.email!,
                      handle: widget.handle);
                }:null,
                icon: Icon(
                  Icons.delete,
                  color:(widget.handle != widget.userHandle)? Colors.red:Colors.grey,
                )),
          ],
          iconTheme: IconThemeData(color: Colors.white),
          title: Center(
              child: Text(
            "CodeZenith",
            style: TextStyle(color: Colors.white),
          )),
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Color.fromARGB(255, 42, 5, 71),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 150,
                child: Card(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SingleChildScrollView(
                        child: SizedBox(
                          width: 240,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Handle : ${widget.coder.handle}",
                                  style: coderInfoTextStyle,
                                ),
                                Text("Rank : ${widget.coder.rank}",
                                    style: coderInfoTextStyle),
                                Text("Rating : ${widget.coder.rating}",
                                    style: coderInfoTextStyle),
                                Text(
                                    "organisation : ${widget.coder.organisation}",
                                    style: coderInfoTextStyle),
                                Text("City : ${widget.coder.city}",
                                    style: coderInfoTextStyle),
                                Text("Country : ${widget.coder.country}",
                                    style: coderInfoTextStyle),
                                Text("Max Rank : ${widget.coder.maxRank}",
                                    style: coderInfoTextStyle),
                                Text("maxRating : ${widget.coder.maxRating}",
                                    style: coderInfoTextStyle),
                                Text(
                                    "Registration time : ${DateTime.fromMillisecondsSinceEpoch(widget.coder.registrationTimeSeconds! * 1000)}",
                                    style: coderInfoTextStyle),
                                Text(
                                    "Last Online : ${DateTime.fromMillisecondsSinceEpoch(widget.coder.lastOnlineTimeSeconds! * 1000)}",
                                    style: coderInfoTextStyle)
                              ]),
                        ),
                      ),
                      Spacer(),
                      SafeArea(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                widget.coder.titlePhoto!,
                                width: 95,
                              )))
                    ],
                  ),
                )),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: FutureBuilder(
                    future: participatedContests,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var contests = snapshot.data!.results.reversed.toList();
                        return Expanded(
                          child: ListView.builder(
                              itemCount: contests.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  color: (Color.fromARGB(255, 211, 158, 239)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "${index + 1}",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          children: [
                                            SizedBox(
                                                width: 200,
                                                child: Text(
                                                  "${contests[index].contestName}",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                            Text(
                                              "Rank: ${contests[index].rank}",
                                              style: TextStyle(fontSize: 15),
                                            ),
                                            Text(
                                                "${DateTime.fromMillisecondsSinceEpoch(contests[index].ratingUpdateTimeSeconds! * 1000)}")
                                          ],
                                        ),
                                        Spacer(),
                                        Column(
                                          children: [
                                            Text(
                                              "${contests[index].newRating}",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            Text(
                                              "${(contests[index].ratingChange!) > 0 ? "+" : ""}${(contests[index].ratingChange!)}",
                                              style: TextStyle(
                                                  color: (contests[index]
                                                                  .newRating! -
                                                              contests[index]
                                                                  .oldRating!) >=
                                                          0
                                                      ? Color.fromARGB(
                                                          255, 27, 145, 33)
                                                      : Colors.red,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "${contests[index].oldRating}",
                                              style: TextStyle(fontSize: 20),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        );
                      } else {
                        return LinearProgressIndicator();
                      }
                    }),
              )
            ],
          ),
        ));
  }
}
