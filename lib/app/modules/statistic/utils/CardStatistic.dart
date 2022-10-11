import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:myfinnapp/app/modules/statistic/controllers/statistic_controller.dart';
import 'package:myfinnapp/app/modules/statistic/models/chartData.dart';

class CardStatistic extends StatelessWidget {
  final List<Color> availableColors = [
    Colors.blue[300],
    Colors.red[400],
  ];

  final List<double> valueStatic = [2, 2, 6, 4, 6, 7, 3];
  final List<double> valueStaticMonth = [2.0, 2.0, 6.0, 4.0];
  final List<double> valueStaticYearly = [3, 4, 10, 6, 4, 9, 5, 5, 7, 8, 2, 7];

  double totalWeakly = 0;

  final int valueChoose;
  final List<double> SumAmmountWeek;

  CardStatistic({this.valueChoose, this.SumAmmountWeek});

  @override
  Widget build(BuildContext context) {
    var f = NumberFormat("#,##0.00", "en_US");

    print(SumAmmountWeek);

    for (var i = 0; i < valueStatic.length; i++) {
      totalWeakly += valueStatic[i];
    }

    final staticC = Get.put<StatisticController>(StatisticController());

    var barChartWeekly = BarChart(
      BarChartData(
          barGroups: List.generate(valueStatic.length, (i) {
            switch (i) {
              case 0:
                return makeGroupData(0, valueStatic[i],
                    barColor: valueStatic[i] >= 5
                        ? availableColors[0]
                        : availableColors[1]);
              case 1:
                return makeGroupData(1, valueStatic[i],
                    barColor: valueStatic[i] >= 5
                        ? availableColors[0]
                        : availableColors[1]);
              case 2:
                return makeGroupData(2, valueStatic[i],
                    barColor: valueStatic[i] >= 5
                        ? availableColors[0]
                        : availableColors[1]);
              case 3:
                return makeGroupData(3, valueStatic[i],
                    barColor: valueStatic[i] >= 5
                        ? availableColors[0]
                        : availableColors[1]);
              case 4:
                return makeGroupData(4, valueStatic[i],
                    barColor: valueStatic[i] >= 5
                        ? availableColors[0]
                        : availableColors[1]);
              case 5:
                return makeGroupData(5, valueStatic[i],
                    barColor: valueStatic[i] >= 5
                        ? availableColors[0]
                        : availableColors[1]);
              case 6:
                return makeGroupData(6, valueStatic[i],
                    barColor: valueStatic[i] >= 5
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
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: bottomTitlesWeekly,
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
          )),
    );

    var barChartMonthly = BarChart(
      BarChartData(
          barGroups: List.generate(valueStaticMonth.length, (i) {
            switch (i) {
              case 0:
                return makeGroupData(0, valueStaticMonth[i],
                    barColor: valueStaticMonth[i] >= 5
                        ? availableColors[0]
                        : availableColors[1]);
              case 1:
                return makeGroupData(1, valueStaticMonth[i],
                    barColor: valueStaticMonth[i] >= 5
                        ? availableColors[0]
                        : availableColors[1]);
              case 2:
                return makeGroupData(2, valueStaticMonth[i],
                    barColor: valueStaticMonth[i] >= 5
                        ? availableColors[0]
                        : availableColors[1]);
              case 3:
                return makeGroupData(3, valueStaticMonth[i],
                    barColor: valueStaticMonth[i] >= 5
                        ? availableColors[0]
                        : availableColors[1]);
              case 4:
                return makeGroupData(4, valueStaticMonth[i],
                    barColor: valueStaticMonth[i] >= 5
                        ? availableColors[0]
                        : availableColors[1]);
              case 5:
                return makeGroupData(5, valueStaticMonth[i],
                    barColor: valueStaticMonth[i] >= 5
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
          )),
    );

    var barChartYearly = BarChart(
      BarChartData(
          barGroups: List.generate(valueStaticYearly.length, (i) {
            switch (i) {
              case 0:
                return makeGroupDataYearly(0, valueStaticYearly[i],
                    barColor: valueStaticYearly[i] >= 5
                        ? availableColors[0]
                        : availableColors[1]);
              case 1:
                return makeGroupDataYearly(1, valueStaticYearly[i],
                    barColor: valueStaticYearly[i] >= 5
                        ? availableColors[0]
                        : availableColors[1]);
              case 2:
                return makeGroupDataYearly(2, valueStaticYearly[i],
                    barColor: valueStaticYearly[i] >= 5
                        ? availableColors[0]
                        : availableColors[1]);
              case 3:
                return makeGroupDataYearly(3, valueStaticYearly[i],
                    barColor: valueStaticYearly[i] >= 5
                        ? availableColors[0]
                        : availableColors[1]);
              case 4:
                return makeGroupDataYearly(4, valueStaticYearly[i],
                    barColor: valueStaticYearly[i] >= 5
                        ? availableColors[0]
                        : availableColors[1]);
              case 5:
                return makeGroupDataYearly(5, valueStaticYearly[i],
                    barColor: valueStaticYearly[i] >= 5
                        ? availableColors[0]
                        : availableColors[1]);
              case 6:
                return makeGroupDataYearly(6, valueStaticYearly[i],
                    barColor: valueStaticYearly[i] >= 5
                        ? availableColors[0]
                        : availableColors[1]);
              case 7:
                return makeGroupDataYearly(7, valueStaticYearly[i],
                    barColor: valueStaticYearly[i] >= 5
                        ? availableColors[0]
                        : availableColors[1]);
              case 8:
                return makeGroupDataYearly(8, valueStaticYearly[i],
                    barColor: valueStaticYearly[i] >= 5
                        ? availableColors[0]
                        : availableColors[1]);
              case 9:
                return makeGroupDataYearly(9, valueStaticYearly[i],
                    barColor: valueStaticYearly[i] >= 5
                        ? availableColors[0]
                        : availableColors[1]);
              case 10:
                return makeGroupDataYearly(10, valueStaticYearly[i],
                    barColor: valueStaticYearly[i] >= 5
                        ? availableColors[0]
                        : availableColors[1]);
              case 11:
                return makeGroupDataYearly(11, valueStaticYearly[i],
                    barColor: valueStaticYearly[i] >= 5
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
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: bottomTitlesYearly,
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
          )),
    );

    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    color: Colors.black.withOpacity(0.2))
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Rp. 13.000.000",
                      style: GoogleFonts.amiri(
                          fontSize: 17, fontWeight: FontWeight.bold)),
                  Text("Spent Today Rp. 13.000.000",
                      style: GoogleFonts.amiri(fontSize: 12)),
                  SizedBox(height: 10),
                  Obx(() => AspectRatio(
                        aspectRatio: 2,
                        child: staticC.valueChoose == 1
                            ? barChartWeekly
                            : staticC.valueChoose == 2
                                ? valueStaticMonth.length > 0
                                    ? barChartMonthly
                                    : Text("data")
                                : staticC.valueChoose == 3
                                    ? barChartYearly
                                    : barChartWeekly,
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget RightTitles(double value, TitleMeta meta) {
    var style = TextStyle(
      color: Colors.blue[300],
      fontWeight: FontWeight.bold,
      fontSize: 8,
    );
    String text;
    // print(totalWeakly);
    if (value == 0) {
      text = '1K';
    } else if (value == 25000) {
      text = 'ETS ${(totalWeakly / 2).toString()}K';
    } else if (value == 35000) {
      text = '${totalWeakly.toString()}K';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }
}

Widget bottomTitlesWeekly(double value, TitleMeta meta) {
  List<String> titles = ["Mn", "Te", "Wd", "Tu", "Fr", "St", "Su"];

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

Widget bottomTitlesMonthly(double value, TitleMeta meta) {
  List<String> titles = ["W1", "W2", "W3", "W4", "W5"];

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

Widget bottomTitlesYearly(double value, TitleMeta meta) {
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

BarChartGroupData makeGroupData(
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

BarChartGroupData makeGroupDataYearly(
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
