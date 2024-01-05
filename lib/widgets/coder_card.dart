import 'package:flutter/material.dart';
import 'package:friendz_code/models/codeforce_model.dart';

class CoderCard extends StatelessWidget {
  CoderCard(
      {super.key,
      required this.user
      });

  Result user;

  final Map<String, Color> rankColor = {
    "newbie": const Color.fromARGB(255, 129, 128, 128),
    "pupil": const Color.fromARGB(255, 103, 247, 117)
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 500,
        width: double.infinity,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          color: const Color.fromARGB(255, 217, 217, 217),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.network(user.titlePhoto.toString(),
                        fit: BoxFit.fitWidth, height: 280, width: 350,
                        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25)
              ),
              height:280,
              width:350,
              child: Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              ),
            ),
          );
        },)),
                Text(
                  user.handle.toString(),
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Current Rating : ${user.rating}\nCurrent Rank: ${user.rank.toString()}\nMax Rating: ${user.maxRating.toString()}\nMax Rank: ${user.maxRank.toString()}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          color: rankColor[user.rank],
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          user.rating.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
