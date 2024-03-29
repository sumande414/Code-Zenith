import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:friendz_code/models/participated_contests.dart';
import 'package:friendz_code/screens/dashboard_screen.dart';
import 'package:friendz_code/screens/friends_screen.dart';
import 'package:friendz_code/screens/profile_screen.dart';
import 'package:friendz_code/widgets/add_friend_widget.dart';
import 'package:friendz_code/widgets/coder_card.dart';
import 'package:friendz_code/models/codeforce_model.dart';
import 'package:friendz_code/api/api.dart';

class PostLoginScreens extends StatefulWidget {
  const PostLoginScreens({super.key});

  @override
  State<PostLoginScreens> createState() => _PostLoginScreensState();
}

class _PostLoginScreensState extends State<PostLoginScreens> {
  String? handle;
  String? username;
  bool loading = true;
  Future<Codeforces>? user;
  Future<ParticipatedContests>? participatedContests;

  @override
  void initState() {
    FriendsScreen.dbAndApiCall();
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((value) {
      do {
        handle = value['handle'];
        username = value['username'];
        if (handle != null && username != null) {
          user = api.fetchHandle(handle);
          participatedContests = api.fetchParticipatedContests(handle);
          setState(() {
            loading = false;
          });
        }
      } while (handle == null &&
          username == null &&
          user == null &&
          participatedContests == null);
    });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  int pageIndex = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 42, 5, 71),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.transparent,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: pageIndex,
        destinations: [
          NavigationDestination(
              icon: Icon(Icons.home,
                  color: pageIndex == 0 ? Colors.black : Colors.white),
              label: "Dashboard"),
          NavigationDestination(
              icon: Icon(Icons.people,
                  color: pageIndex == 1 ? Colors.black : Colors.white),
              label: "Friends")
        ],
        onDestinationSelected: (value) {
          setState(() {
            pageIndex = value;
          });
        },
      ),
      appBar: AppBar(
        title: const Center(
            child: Text(
          "CodeZenith",
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 25,
              fontWeight: FontWeight.bold),
        )),
        leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<Codeforces?>(
                future: user,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var currentUser = snapshot.data!.results[0];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileScreen(handle:handle!, username: username!)));
                      },
                      child: CircleAvatar(
                        backgroundColor: const Color.fromARGB(255, 78, 68, 68),
                        backgroundImage: NetworkImage(
                          currentUser.avatar,
                        ),
                      ),
                    );
                  } else {
                    return Center(child: const CircularProgressIndicator());
                  }
                })),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () async {
                Fluttertoast.showToast(msg: "Logging out...");
                await FirebaseAuth.instance.signOut();
              },
              icon: const Icon(
                Icons.logout,
                color: Color.fromARGB(255, 255, 255, 255),
              ))
        ],
      ),
      body: [
        //Home Page
        Dashboard(
            participatedContests: participatedContests, username: username),

        //Friends Page
        FriendsScreen(userHandle: handle)
      ][pageIndex],
      floatingActionButton: pageIndex == 1 ? AddFriendWizard() : null,
    );
  }
}
