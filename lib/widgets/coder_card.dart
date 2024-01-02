import 'package:flutter/material.dart';

class CoderCard extends StatelessWidget {
  CoderCard(
      {super.key,
      required this.handle,
      required this.avatar,
      required this.rank,
      required this.rating});

  final String handle;
  final String avatar;
  final int rating;
  final String rank;

  final Map<String, Color> rankColor = {"pupil": const Color.fromARGB(255, 103, 247, 117)};

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 100,
        width: double.infinity,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          color: const Color.fromARGB(255, 217, 217, 217),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 78, 68, 68),
                  backgroundImage: NetworkImage(avatar),
                  radius: 30,
                ),
                Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      handle,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text(rank.toUpperCase(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                      ),
                      decoration: BoxDecoration(color:rankColor[rank],
                      borderRadius: BorderRadius.circular(20)),
                    )
                  ],
                ),
                Spacer(),
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 78, 68, 68),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      rating.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
