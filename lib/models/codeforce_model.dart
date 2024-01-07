class Codeforces {
  Codeforces({required this.status, required this.results});

  String status;
  List<Result> results;

  factory Codeforces.fromJson(Map<String, dynamic> json) {
    var result_list = json['result'] as List;
    List<Result> results = result_list.map((e) => Result.fromJson(e)).toList();
    return Codeforces(status: json['status'], results: results);
  }
}

class Result {
  Result(
      {required this.country,
      required this.lastOnlineTimeSeconds,
      required this.city,
      required this.rating,
      required this.friendOfCount,
      required this.titlePhoto,
      required this.handle,
      required this.avatar,
      required this.contributuion,
      required this.organisation,
      required this.rank,
      required this.maxRating,
      required this.registrationTimeSeconds,
      required this.maxRank});

  String? country;
  int? lastOnlineTimeSeconds;
  String? city;
  int? rating;
  int? friendOfCount;
  String? titlePhoto;
  String? handle;
  String avatar;
  String? contributuion;
  String? organisation;
  String? rank;
  int? maxRating;
  int? registrationTimeSeconds;
  String? maxRank;
  String? nickname;

  factory Result.fromJson(Map<String, dynamic> data) => Result(
      country: data['country'],
      lastOnlineTimeSeconds: data['lastOnlineTimeSeconds'],
      city: data['city'],
      rating: data['rating'],
      friendOfCount: data['friendOfCount'],
      titlePhoto: data['titlePhoto'],
      handle: data['handle'],
      avatar: data['avatar'],
      contributuion: data['contributuion'],
      organisation: data['organization'],
      rank: data['rank'],
      maxRating: data['maxRating'],
      registrationTimeSeconds: data['registrationTimeSeconds'],
      maxRank: data['maxRank']);
}
