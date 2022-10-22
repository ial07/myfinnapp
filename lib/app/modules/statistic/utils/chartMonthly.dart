import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfinnapp/app/modules/statistic/controllers/statistic_controller.dart';

final staticC = Get.put<StatisticController>(StatisticController());
var largestMonth;
String TopText = "";
String MidText = "";
String BotText = "";
BarChartData barChartMonthlys() {
  final List<Color> availableColors = [
    Colors.blue[300],
    Colors.red[400],
  ];

  if (staticC.getMonthTotal.isNotEmpty) {
    largestMonth = staticC.getMonthTotal[0];
    for (var i = 0; i < staticC.getMonthTotal.length; i++) {
      if (staticC.getMonthTotal[i] > largestMonth) {
        largestMonth = staticC.getMonthTotal[i];
      }
    }
  }

  int count = 0;
  int count2 = 0;
  int count3 = 0;

  var Temp = largestMonth;
  var Temp2 = largestMonth / 2;
  var Temp3 = largestMonth / 9;

  var middleWeek = largestMonth / 2;
  var botWeek = largestMonth / 9;
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
    TopText = (largestMonth / 1000000000).toInt().toString() + "B";
  } else if (count > 6) {
    TopText = (largestMonth / 1000000).toInt().toString() + "M";
  } else if (count > 3) {
    TopText = (largestMonth / 1000).toInt().toString() + "K";
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

  return BarChartData(
      barGroups: List.generate(
          staticC.getNormalizeMonthTransactions.isNotEmpty
              ? staticC.getNormalizeMonthTransactions.length
              : 1, (i) {
        switch (i) {
          case 0:
            return makeGroupDataMonthly(
                0,
                staticC.getNormalizeMonthTransactions.isNotEmpty
                    ? staticC.getNormalizeMonthTransactions[i]
                    : 0,
                barColor: staticC.getNormalizeMonthTransactions[i] >= 5
                    ? availableColors[0]
                    : availableColors[1]);
          case 1:
            return makeGroupDataMonthly(
                1, staticC.getNormalizeMonthTransactions[i],
                barColor: staticC.getNormalizeMonthTransactions[i] >= 5
                    ? availableColors[0]
                    : availableColors[1]);
          case 2:
            return makeGroupDataMonthly(
                2, staticC.getNormalizeMonthTransactions[i],
                barColor: staticC.getNormalizeMonthTransactions[i] >= 5
                    ? availableColors[0]
                    : availableColors[1]);
          case 3:
            return makeGroupDataMonthly(
                3, staticC.getNormalizeMonthTransactions[i],
                barColor: staticC.getNormalizeMonthTransactions[i] >= 5
                    ? availableColors[0]
                    : availableColors[1]);
          case 4:
            return makeGroupDataMonthly(
                4, staticC.getNormalizeMonthTransactions[i],
                barColor: staticC.getNormalizeMonthTransactions[i] >= 5
                    ? availableColors[0]
                    : availableColors[1]);
          case 5:
            return makeGroupDataMonthly(
                5, staticC.getNormalizeMonthTransactions[i],
                barColor: staticC.getNormalizeMonthTransactions[i] >= 5
                    ? availableColors[0]
                    : availableColors[1]);
          case 6:
            return makeGroupDataMonthly(
                6, staticC.getNormalizeMonthTransactions[i],
                barColor: staticC.getNormalizeMonthTransactions[i] >= 5
                    ? availableColors[0]
                    : availableColors[1]);
          case 7:
            return makeGroupDataMonthly(
                7, staticC.getNormalizeMonthTransactions[i],
                barColor: staticC.getNormalizeMonthTransactions[i] >= 5
                    ? availableColors[0]
                    : availableColors[1]);
          case 8:
            return makeGroupDataMonthly(
                8, staticC.getNormalizeMonthTransactions[i],
                barColor: staticC.getNormalizeMonthTransactions[i] >= 5
                    ? availableColors[0]
                    : availableColors[1]);
          case 9:
            return makeGroupDataMonthly(
                9, staticC.getNormalizeMonthTransactions[i],
                barColor: staticC.getNormalizeMonthTransactions[i] >= 5
                    ? availableColors[0]
                    : availableColors[1]);
          case 10:
            return makeGroupDataMonthly(
                10, staticC.getNormalizeMonthTransactions[i],
                barColor: staticC.getNormalizeMonthTransactions[i] >= 5
                    ? availableColors[0]
                    : availableColors[1]);
          case 11:
            return makeGroupDataMonthly(
                11, staticC.getNormalizeMonthTransactions[i],
                barColor: staticC.getNormalizeMonthTransactions[i] >= 5
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
            getTitlesWidget: bottomTitlesMonthly,
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
  String text;
  if (value == 0) {
    text = BotText;
  } else if (value == 5) {
    text = MidText;
  } else if (value == 10) {
    text = TopText;
  } else {
    return Container();
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 0,
    child: Text(text, style: style),
  );
}

Widget bottomTitlesMonthly(double value, TitleMeta meta) {
  List<String> titles = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Agt",
    "Sep",
    "Okt",
    "Nov",
    "Dec"
  ];

  Widget text = Text(
    titles[value.toInt()],
    style: TextStyle(
      color: Colors.blue[300],
      fontWeight: FontWeight.bold,
      fontSize: 8,
    ),
  );

  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 10, //margin top
    child: text,
  );
}

BarChartGroupData makeGroupDataMonthly(
  int x,
  double y, {
  Color barColor = Colors.white,
  double width = 15,
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
