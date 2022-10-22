import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfinnapp/app/modules/staticCredit/controllers/static_credit_controller.dart';

List<Color> gradientColors = [Colors.blue[300]];
var largestWeek;
String TopText = "";
String MidText = "";
String BotText = "";
LineChartData mainDataWeekly() {
  var staticC = Get.put(StaticCreditController());

  if (staticC.getWeekTotal.isNotEmpty) {
    largestWeek = staticC.getWeekTotal[0];
    for (var i = 0; i < staticC.getWeekTotal.length; i++) {
      if (staticC.getWeekTotal[i] > largestWeek) {
        largestWeek = staticC.getWeekTotal[i];
      }
    }
  }

  int count = 0;
  int count2 = 0;
  int count3 = 0;

  var Temp = largestWeek;
  var Temp2 = largestWeek / 2;
  var Temp3 = largestWeek / 9;

  var middleWeek = largestWeek / 2;
  var botWeek = largestWeek / 9;
  while (Temp > 0) {
    Temp = (Temp / 10).toInt();
    count++;
  }

  while (Temp2 > 0) {
    Temp2 = (Temp2 / 10).toInt();
    count2++;
  }

  while (Temp3 > 0) {
    Temp3 = (Temp3 / 10).toInt();
    count3++;
  }

  if (count > 9) {
    TopText = (largestWeek / 1000000000).toInt().toString() + "B";
  } else if (count > 6) {
    TopText = (largestWeek / 1000000).toInt().toString() + "M";
  } else if (count > 3) {
    TopText = (largestWeek / 1000).toInt().toString() + "K";
  }

  if (count2 > 9) {
    MidText = (middleWeek / 1000000000).toInt().toString() + "B";
  } else if (count2 > 6) {
    MidText = (middleWeek / 1000000).toInt().toString() + "M";
  } else if (count2 > 3) {
    MidText = (middleWeek / 1000).toInt().toString() + "K";
  }

  if (count3 > 9) {
    BotText = (botWeek / 1000000000).toInt().toString() + "B";
  } else if (count3 > 6) {
    BotText = (botWeek / 1000000).toInt().toString() + "M";
  } else if (count3 > 3) {
    BotText = (botWeek / 1000).toInt().toString() + "K";
  }

  return LineChartData(
    gridData: FlGridData(
        show: true,
        drawHorizontalLine: false,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 0.1,
          );
        }),
    titlesData: FlTitlesData(
      show: true,
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          interval: 1,
          getTitlesWidget: bottomTitleWidgets,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTitlesWidget: leftTitleWidgets,
          reservedSize: 42,
        ),
      ),
    ),
    borderData: FlBorderData(
      show: false,
    ),
    minX: 0,
    maxX: 8,
    minY: 0,
    maxY: 10,
    lineBarsData: [
      LineChartBarData(
        spots: flspot,
        isCurved: true,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
      ),
    ],
  );
}

List<FlSpot> flspot = [];

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color(0xff68737d),
    fontWeight: FontWeight.bold,
    fontSize: 8,
  );
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text('Week 1', style: style);
      break;
    case 1:
      text = const Text('Week 2', style: style);
      break;
    case 2:
      text = const Text('Week 3', style: style);
      break;
    case 3:
      text = const Text('Week 4', style: style);
      break;
    case 4:
      text = const Text('Week 5', style: style);
      break;
    case 5:
      text = const Text('Week 6', style: style);
      break;
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text,
  );
}

Widget leftTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color(0xff67727d),
    fontWeight: FontWeight.bold,
    fontSize: 8,
  );
  String text;
  switch (value.toInt()) {
    case 1:
      text = BotText;
      break;
    case 5:
      text = MidText;
      break;
    case 10:
      text = TopText;
      break;
    default:
      return Container();
  }

  return Text(text, style: style, textAlign: TextAlign.left);
}
