import 'dart:ffi';

class ParticipatedContests {
  ParticipatedContests({required this.status, required this.results});

  String status;
  List<Result> results;

  factory ParticipatedContests.fromJson(Map<String, dynamic> json) {
    var result_list = json['result'] as List;
    List<Result> results = result_list.map((e) => Result.fromJson(e)).toList();
    return ParticipatedContests(status: json['status'], results: results);
  }
}

class Result {
  Result({
    required this.contestId,
    required this.contestName,
    required this.handle,
    required this.rank,
    required this.ratingUpdateTimeSeconds,
    required this.oldRating,
    required this.newRating,
    required this.ratingChange
  });

  int? contestId;
  String? contestName;
  String? handle;
  int? rank;
  int? ratingUpdateTimeSeconds;
  int? oldRating;
  int? newRating;
  int? ratingChange;

  factory Result.fromJson(Map<String, dynamic> data) => Result(
      contestId: data['contestId'],
      contestName: data['contestName'],
      handle: data['handle'],
      rank: data['rank'],
      ratingUpdateTimeSeconds: data['ratingUpdateTimeSeconds'],
      oldRating: data['oldRating'],
      newRating: data['newRating'],
      ratingChange:data['newRating']-data['oldRating']);
}
