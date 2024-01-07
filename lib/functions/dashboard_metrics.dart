import 'package:friendz_code/models/participated_contests.dart';
import 'dart:math';

class DashboardMetrics {
  String calculateSuccessRate(List<Result> contests) {
    int contestWithPositiveRatingChange = 0;
    int totalContests = contests.length;
    for (var contest in contests) {
      if (contest.ratingChange! > 0) {
        contestWithPositiveRatingChange++;
      }
    }
    double successRate =
        (contestWithPositiveRatingChange / totalContests) * 100;

    return "${successRate.toStringAsFixed(2)}%";
  }

  String calculateAverageRatingChange(List<Result> contests) {
    int totalRatingChange = 0;
    int totalContests = contests.length;

    for (var contest in contests) {
      totalRatingChange += contest.ratingChange!;
    }

    double averageRatingChange = totalRatingChange / totalContests;
    return "${averageRatingChange.toStringAsFixed(2)}";
  }

  Map<String, dynamic> calulateHighestAndLowestRatingChangeContest(
      List<Result> contests) {
    Map<String, dynamic> mpp;
    mpp = {
      'highest': contests[0].ratingChange,
      'highest_contest_name': contests[0].contestName,
      'lowest': contests[0].ratingChange,
      'lowest_contest_name': contests[0].contestName,
    };
    for (var contest in contests) {
      if (mpp['highest'] < contest.ratingChange) {
        mpp['highest'] = contest.ratingChange;
        mpp['highest_contest_name'] = contest.contestName;
      }
      if (mpp['lowest'] > contest.ratingChange) {
        mpp['lowest'] = contest.ratingChange;
        mpp['lowest_contest_name'] = contest.contestName;
      }
    }
    return mpp;
  }

  String calculateConsistencyScore(List<Result> contests) {
    int totalRatingChange = 0;
    int totalContests = contests.length;

    for (var contest in contests) {
      totalRatingChange += contest.ratingChange!;
    }
    double averageRatingChange = totalRatingChange / totalContests;

    double sumSquaredDiff = 0;
    for (var contest in contests) {
      sumSquaredDiff += ((contest.ratingChange! - averageRatingChange) *
              (contest.ratingChange! - averageRatingChange))
          .toDouble();
    }
    double standardDeviation = sqrt(sumSquaredDiff / totalContests);

    double consistencyScore = averageRatingChange / standardDeviation;
    return consistencyScore.toStringAsFixed(2);
  }
}
