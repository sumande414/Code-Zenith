import 'package:flutter/material.dart';
import 'package:friendz_code/models/participated_contests.dart';

class ParticipatedContestsCard extends StatefulWidget {
  const ParticipatedContestsCard(
      {super.key, required this.participatedContests});
  final Future<ParticipatedContests>? participatedContests;

  @override
  State<ParticipatedContestsCard> createState() => _CoderCardState();
}

class _CoderCardState extends State<ParticipatedContestsCard> {
  final Map<String, Color> rankColor = {
    "newbie": const Color.fromARGB(255, 129, 128, 128),
    "pupil": const Color.fromARGB(255, 103, 247, 117)
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
            height: 400,
            width: double.infinity,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              color: const Color.fromARGB(255, 217, 217, 217),
              child: FutureBuilder(
                  future: widget.participatedContests,
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      List<Result> contests = snapshot.data!.results;
                      contests = contests.reversed.toList();
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            itemCount: contests.length,
                            itemBuilder: (context, index) {
                              return Card(
                                color: ((contests[index].newRating! -
                                            contests[index].oldRating!) >=
                                        0
                                    ? const Color.fromARGB(255, 108, 243, 114)
                                    : Colors.red),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: 
                                             Text("${index+1}",style: TextStyle(
                                              fontSize: 20
                                            ),
                                          
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Column(
                                        children: [
                                          SizedBox(
                                              width: 200,
                                              child: Text(
                                                "${contests[index].contestName}",
                                                style: TextStyle(fontSize: 20),
                                              )),
                                          Text("Rank: ${contests[index].rank}", style: TextStyle(fontSize: 15),)
                                        ],
                                      ),
                                      Spacer(),
                                      Column(
                                        children: [
                                          Text("${contests[index].newRating}", style: TextStyle(fontSize: 20),),
                                          Text(
                                              "${(contests[index].newRating! - contests[index].oldRating!) > 0 ? "+" : ""}${(contests[index].newRating! - contests[index].oldRating!)}", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                          Text("${contests[index].oldRating}", style: TextStyle(fontSize: 20),)
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
                  })),
            )));
  }
}
