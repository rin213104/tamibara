import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'statistics.dart';

class StatisticsScreen extends StatefulWidget {
  final List<Map<String, dynamic>> completedItems;

  StatisticsScreen({required this.completedItems});

  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  String selectedPeriod = '일일';

  List<FlSpot> _createLineChartData() {
    List<StatisticsData> data = [];
    DateTime now = DateTime.now();
    DateTime startOfDay = DateTime(now.year, now.month, now.day);
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime startOfMonth = DateTime(now.year, now.month, 1);

    if (selectedPeriod == '일일') {
      List<Map<String, dynamic>> dailyItems = widget.completedItems
          .where((item) => Statistics.isSameDate(item['date'], now))
          .toList();
      if (dailyItems.isNotEmpty) {
        for (var item in dailyItems) {
          int hour = item['date'].hour;
          int minute = item['date'].minute;
          String timeLabel = '$hour:${minute.toString().padLeft(2, '0')}';
          data.add(StatisticsData(timeLabel, 1));  // Y값을 1로 설정
        }
      }
    } else if (selectedPeriod == '주간') {
      for (int i = 0; i < 7; i++) {
        DateTime date = startOfWeek.add(Duration(days: i));
        List<int> dailyDurations = Statistics.filterDurationsByDate(widget.completedItems, date);
        int totalDuration = dailyDurations.fold(0, (sum, duration) => sum + duration);
        data.add(StatisticsData('${date.month}/${date.day}', totalDuration));
      }
    } else if (selectedPeriod == '월간') {
      for (int i = 0; i < 4; i++) {
        DateTime weekStart = startOfMonth.add(Duration(days: i * 7));
        DateTime weekEnd = weekStart.add(Duration(days: 6));
        List<int> weeklyDurations = Statistics.filterDurationsByWeek(widget.completedItems, weekStart);
        int totalDuration = weeklyDurations.fold(0, (sum, duration) => sum + duration);
        data.add(StatisticsData('Week ${i + 1}', totalDuration));
      }
    }

    return data.map((stats) {
      return FlSpot(data.indexOf(stats).toDouble(), stats.duration.toDouble());
    }).toList();
  }


  List<LineTooltipItem> _getTooltipItems(List<LineBarSpot> touchedSpots) {
    return touchedSpots.map((barSpot) {
      return LineTooltipItem(
        '${barSpot.y} 분',
        const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      );
    }).toList();
  }

  Widget _bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xFF7589A2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    if (selectedPeriod == '일일') {
      switch (value.toInt()) {
        case 0:
          text = Text('0시', style: style);
          break;
        case 3:
          text = Text('3시', style: style);
          break;
        case 6:
          text = Text('6시', style: style);
          break;
        case 9:
          text = Text('9시', style: style);
          break;
        case 12:
          text = Text('12시', style: style);
          break;
        case 15:
          text = Text('15시', style: style);
          break;
        case 18:
          text = Text('18시', style: style);
          break;
        case 21:
          text = Text('21시', style: style);
          break;
        default:
          text = Container();
          break;
      }
    } else if (selectedPeriod == '주간') {
      switch (value.toInt()) {
        case 0:
          text = Text('월', style: style);
          break;
        case 1:
          text = Text('화', style: style);
          break;
        case 2:
          text = Text('수', style: style);
          break;
        case 3:
          text = Text('목', style: style);
          break;
        case 4:
          text = Text('금', style: style);
          break;
        case 5:
          text = Text('토', style: style);
          break;
        case 6:
          text = Text('일', style: style);
          break;
        default:
          text = Container();
          break;
      }
    } else {
      text = Text('Week ${value.toInt() + 1}', style: style);
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget _leftTitleWidgets(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(value == value.toInt() ? value.toInt().toString() : ''),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('통계'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedPeriod,
              items: <String>['일일', '주간', '월간'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedPeriod = newValue!;
                });
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: _createLineChartData(),
                      isCurved: true,
                      barWidth: 4,
                      color: Colors.blue,
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.blue.withOpacity(0.3),
                      ),
                    ),
                  ],
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: _leftTitleWidgets,
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: _bottomTitleWidgets,
                      ),
                    ),
                  ),
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: _getTooltipItems,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StatisticsData {
  final String label;
  final int duration;

  StatisticsData(this.label, this.duration);
}
