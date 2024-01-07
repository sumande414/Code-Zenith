import 'package:flutter/material.dart';
import 'package:friendz_code/models/participated_contests.dart';
import 'package:friendz_code/functions/dashboard_metrics.dart';

class ParticipatedContestsCard extends StatefulWidget {
  ParticipatedContestsCard(
      {super.key,
      required this.participatedContests,
      required this.username,
     });
  final Future<ParticipatedContests>? participatedContests;
  final String? username;
  final DashboardMetrics metric = DashboardMetrics();

  @override
  State<ParticipatedContestsCard> createState() => _CoderCardState();
}

class _CoderCardState extends State<ParticipatedContestsCard> {
  final DashboardMetrics metric = DashboardMetrics();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: FutureBuilder(
          future: widget.participatedContests,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              List<Result> contests = snapshot.data!.results;
              var performance =
                  metric.calulateHighestAndLowestRatingChangeContest(contests);

              contests = contests.reversed.toList();
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          color: Color.fromARGB(255, 196, 177, 224),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Card(
                                  color: Color.fromARGB(255, 101, 40, 142),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Hi ${widget.username ?? "".substring(0, (widget.username ?? " ").indexOf(' '))}! Here are the results of the contests you participated in:",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                      itemCount: contests.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          color: (Colors.white),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "${index + 1}",
                                                    style:
                                                        TextStyle(fontSize: 20),
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
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                    Text(
                                                      "Rank: ${contests[index].rank}",
                                                      style: TextStyle(
                                                          fontSize: 15),
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
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                    Text(
                                                      "${(contests[index].ratingChange!) > 0 ? "+" : ""}${(contests[index].ratingChange!)}",
                                                      style: TextStyle(
                                                          color: (contests[index]
                                                                          .newRating! -
                                                                      contests[
                                                                              index]
                                                                          .oldRating!) >=
                                                                  0
                                                              ? Color.fromARGB(
                                                                  255,
                                                                  27,
                                                                  145,
                                                                  33)
                                                              : Colors.red,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      "${contests[index].oldRating}",
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                                Card(
                                  color: Color.fromARGB(255, 101, 40, 142),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "Success Rate : ${metric.calculateSuccessRate(contests)}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                              "Average Rating Change : ${metric.calculateAverageRatingChange(contests)}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                              "Consistency Score : ${metric.calculateConsistencyScore(contests)}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                            "Your best performance was in the contest ${performance['highest_contest_name']} with a rating change of +${performance['highest']} and your poorest performance was in ${performance['lowest_contest_name']} with a rating change of ${performance['lowest']}.",
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))),
                ],
              );
            } else {
              return LinearProgressIndicator();
            }
          })),
    );
  }
}
