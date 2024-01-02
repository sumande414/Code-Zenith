import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:friendz_code/widgets/coder_card.dart';
import 'package:friendz_code/widgets/form_container_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future OpenDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Add Friend"),
            actions: [
              FormContainerWidget(
                hintText: "Codeforces handle",
              ),
            ],
          ));

  @override
  void initState() {
    // TODO: implement initState
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
        leading: const Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Color.fromARGB(255, 78, 68, 68),
            backgroundImage: NetworkImage(
              "",
            ),
          ),
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
      body: CoderCard(
        handle: "sumande0414",
        avatar:
            "https://userpic.codeforces.org/3206650/title/57cf6b76464101e.jpg",
        rank: "pupil",
        rating: 903,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          OpenDialog();
        },
        backgroundColor: Colors.green,
        label: Text("Add Friends"),
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
