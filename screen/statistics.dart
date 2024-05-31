import 'package:flutter/material.dart';

class Statistics {
  // 완료된 항목의 총 소요 시간을 계산하는 함수
  static int calculateTotalDuration(List<int> durations) {
    return durations.fold(0, (sum, duration) => sum + duration);
  }

  // 완료된 항목의 평균 소요 시간을 계산하는 함수
  static double calculateAverageDuration(List<int> durations) {
    if (durations.isEmpty) return 0;
    int totalDuration = calculateTotalDuration(durations);
    return totalDuration / durations.length;
  }

  // 완료된 항목 수를 계산하는 함수
  static int calculateCompletedCount(List<int> durations) {
    return durations.length;
  }

  // 통계를 보여주는 함수
  static void showStatistics(BuildContext context, List<int> durations) {
    int totalDuration = calculateTotalDuration(durations);
    double averageDuration = calculateAverageDuration(durations);
    int itemCount = calculateCompletedCount(durations);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('통계'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('완료된 항목 수: $itemCount'),
              Text('총 소요 시간: $totalDuration 분'),
              Text('평균 소요 시간: ${averageDuration.toStringAsFixed(2)} 분'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
