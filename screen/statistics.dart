import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Statistics {
  // 완료된 항목의 총 소요 시간을 계산하는 함수
  static Duration calculateTotalDuration(List<int> durations) {
    int totalDurationInSeconds = durations.fold(0, (sum, duration) => sum + duration);
    return Duration(seconds: totalDurationInSeconds);
  }

  // 완료된 항목의 평균 소요 시간을 계산하는 함수
  static Duration calculateAverageDuration(List<int> durations) {
    if (durations.isEmpty) return Duration.zero;
    int totalDurationInSeconds = durations.fold(0, (sum, duration) => sum + duration);
    return Duration(seconds: totalDurationInSeconds ~/ durations.length);
  }

  // 완료된 항목 수를 계산하는 함수
  static int calculateCompletedCount(List<int> durations) {
    return durations.length;
  }

  // 특정 날짜에 해당하는 항목들의 소요 시간을 반환하는 함수
  static List<int> filterDurationsByDate(List<Map<String, dynamic>> items, DateTime date) {
    return items
        .where((item) => isSameDate(item['date'], date))
        .map<int>((item) => item['duration'] as int)
        .toList();
  }

  // 특정 주에 해당하는 항목들의 소요 시간을 반환하는 함수
  static List<int> filterDurationsByWeek(List<Map<String, dynamic>> items, DateTime date) {
    DateTime startOfWeek = date.subtract(Duration(days: date.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(Duration(days: 6));
    return items
        .where((item) => item['date'].isAfter(startOfWeek.subtract(Duration(days: 1))) && item['date'].isBefore(endOfWeek.add(Duration(days: 1))))
        .map<int>((item) => item['duration'] as int)
        .toList();
  }

  // 특정 월에 해당하는 항목들의 소요 시간을 반환하는 함수
  static List<int> filterDurationsByMonth(List<Map<String, dynamic>> items, DateTime date) {
    return items
        .where((item) => item['date'].year == date.year && item['date'].month == date.month)
        .map<int>((item) => item['duration'] as int)
        .toList();
  }

  // 두 날짜가 같은 날짜인지 확인하는 함수
  static bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  // Duration을 시/분/초 형식으로 포맷팅하는 함수
  static String formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);
    return '$hours시간 $minutes분 $seconds초';
  }

  // 통계를 보여주는 함수
  static void showStatistics(BuildContext context, List<Map<String, dynamic>> items, DateTime date) {
    // 날짜 기준으로 항목을 필터링하여 기간별 소요 시간 계산
    List<int> dailyDurations = filterDurationsByDate(items, date);
    List<int> weeklyDurations = filterDurationsByWeek(items, date);
    List<int> monthlyDurations = filterDurationsByMonth(items, date);

    // 기간별 총 소요 시간 계산
    Duration totalDailyDuration = calculateTotalDuration(dailyDurations);
    Duration totalWeeklyDuration = calculateTotalDuration(weeklyDurations);
    Duration totalMonthlyDuration = calculateTotalDuration(monthlyDurations);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('통계'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('일일 통계'),
              Text('총 소요 시간: ${formatDuration(totalDailyDuration)}'),
              Text('주간 통계'),
              Text('총 소요 시간: ${formatDuration(totalWeeklyDuration)}'),
              Text('월간 통계'),
              Text('총 소요 시간: ${formatDuration(totalMonthlyDuration)}'),
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
