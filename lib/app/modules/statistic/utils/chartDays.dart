import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BarChartData barChartDays() {
  final List<Color> availableColors = [
    Colors.blue[300],
    Colors.red[400],
  ];
  List<double> valueStatic = [2, 2, 6, 4, 6, 7, 3];

  return BarChartData(
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
            getTitlesWidget: bottomTitlesDays,
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
  // print(totalWeakly);
  if (value == 0) {
    text = '1K';
  } else if (value == 5) {
    text = 'ETS 5K';
  } else if (value == 10) {
    text = '10K';
  } else {
    return Container();
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 0,
    child: Text(text, style: style),
  );
}

Widget bottomTitlesDays(double value, TitleMeta meta) {
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
