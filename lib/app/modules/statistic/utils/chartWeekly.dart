import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfinnapp/app/modules/statistic/controllers/statistic_controller.dart';

var largestWeek;
String TopText = "";
String MidText = "";
String BotText = "";
int estimatedNormalize = 0;
BarChartData barChartWeeklys() {
  final staticC = Get.put(StatisticController());
  final List<Color> availableColors = [
    Colors.blue[300],
    Colors.red[400],
  ];

  if (staticC.getWeekTotal.isNotEmpty) {
    largestWeek = staticC.getWeekTotal[0];
    for (var i = 0; i < staticC.getWeekTotal.length; i++) {
      if (staticC.getWeekTotal[i] > largestWeek) {
        largestWeek = staticC.getWeekTotal[i];
      }
    }
  }

  estimatedNormalize = (staticC.getWeekNormalizeEstimated).toInt();

  int count = 0;
  int count2 = 0;
  int count3 = 0;

  var Temp = largestWeek;
  var Temp2 = staticC.getWeekEstimated.value.toInt();
  var Temp3 = largestWeek / 9;

  var middleWeek = staticC.getWeekEstimated.value.toInt();
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
  } else {
    TopText = "Rp. " + (largestWeek).toInt().toString();
  }

  if (count2 > 9) {
    MidText = (middleWeek / 1000000000).toInt().toString() + "B";
  } else if (count2 > 6) {
    MidText = (middleWeek / 1000000).toInt().toString() + "M";
  } else if (count2 > 3) {
    MidText = (middleWeek / 1000).toInt().toString() + "K";
  } else {
    MidText = "Rp. " + (middleWeek).toInt().toString();
  }

  if (count3 > 9) {
    BotText = (botWeek / 1000000000).toInt().toString() + "B";
  } else if (count3 > 6) {
    BotText = (botWeek / 1000000).toInt().toString() + "M";
  } else if (count3 > 3) {
    BotText = (botWeek / 1000).toInt().toString() + "K";
  } else {
    BotText = "Rp. " + (botWeek).toInt().toString();
  }

  return BarChartData(
      barGroups: List.generate(
          staticC.getNormalizeWeekTransactions.isNotEmpty
              ? staticC.getNormalizeWeekTransactions.length
              : 1, (i) {
        switch (i) {
          case 0:
            return makeGroupDataWeekls(
                0,
                staticC.getNormalizeWeekTransactions.isNotEmpty
                    ? staticC.getNormalizeWeekTransactions[i]
                    : 0,
                barColor: staticC.getNormalizeWeekTransactions[i] >=
                        estimatedNormalize
                    ? availableColors[0]
                    : availableColors[1]);
          case 1:
            return makeGroupDataWeekls(
                1, staticC.getNormalizeWeekTransactions[i],
                barColor: staticC.getNormalizeWeekTransactions[i] >=
                        estimatedNormalize
                    ? availableColors[0]
                    : availableColors[1]);
          case 2:
            return makeGroupDataWeekls(
                2, staticC.getNormalizeWeekTransactions[i],
                barColor: staticC.getNormalizeWeekTransactions[i] >=
                        estimatedNormalize
                    ? availableColors[0]
                    : availableColors[1]);
          case 3:
            return makeGroupDataWeekls(
                3, staticC.getNormalizeWeekTransactions[i],
                barColor: staticC.getNormalizeWeekTransactions[i] >=
                        estimatedNormalize
                    ? availableColors[0]
                    : availableColors[1]);
          case 4:
            return makeGroupDataWeekls(
                4, staticC.getNormalizeWeekTransactions[i],
                barColor: staticC.getNormalizeWeekTransactions[i] >=
                        estimatedNormalize
                    ? availableColors[0]
                    : availableColors[1]);
          case 5:
            return makeGroupDataWeekls(
                5, staticC.getNormalizeWeekTransactions[i],
                barColor: staticC.getNormalizeWeekTransactions[i] >=
                        estimatedNormalize
                    ? availableColors[0]
                    : availableColors[1]);
          case 6:
            return makeGroupDataWeekls(
                6, staticC.getNormalizeWeekTransactions[i],
                barColor: staticC.getNormalizeWeekTransactions[i] >=
                        estimatedNormalize
                    ? availableColors[0]
                    : availableColors[1]);
          default:
            return throw Error();
        }
      }),
      alignment: BarChartAlignment.spaceEvenly,
      borderData: FlBorderData(
        show: false,
      ),
      gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: const Color(0xff37434d),
              strokeWidth: 0.1,
            );
          }),
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: bottomTitlesWeeklys,
            reservedSize: 42,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              interval: 1,
              getTitlesWidget: RightTitles),
        ),
      ));
}

Widget RightTitles(double value, TitleMeta meta) {
  var style = TextStyle(
    color: Colors.blue[300],
    fontWeight: FontWeight.bold,
    fontSize: 8,
  );
  var styleEst = TextStyle(
    color: Colors.red[300],
    fontWeight: FontWeight.bold,
    fontSize: 6,
  );
  String text;
  if (value == 0) {
    text = BotText;
  } else if (value == estimatedNormalize) {
    text = MidText + " EST";
  } else if (value == 10) {
    text = TopText;
  } else {
    return Container();
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 0,
    child: Text(text, style: value == estimatedNormalize ? styleEst : style),
  );
}

Widget bottomTitlesWeeklys(double value, TitleMeta meta) {
  List<String> titles = ["W1", "W2", "W3", "W4", "W5", "W6"];

  Widget text = Text(
    titles[value.toInt()],
    style: TextStyle(
      color: Colors.blue[300],
      fontWeight: FontWeight.bold,
      fontSize: 12,
    ),
  );

  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 16, //margin top
    child: text,
  );
}

BarChartGroupData makeGroupDataWeekls(
  int x,
  double y, {
  Color barColor = Colors.white,
  double width = 22,
  List<int> showTooltips = const [],
}) {
  return BarChartGroupData(
    x: x,
    barRods: [
      BarChartRodData(
        toY: y,
        color: barColor,
        width: width,
        borderSide: const BorderSide(color: Colors.white, width: 0),
        backDrawRodData: BackgroundBarChartRodData(
          show: true,
          toY: 10,
          color: Colors.grey.shade200,
        ),
      ),
    ],
    showingTooltipIndicators: showTooltips,
  );
}
