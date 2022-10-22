import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:myfinnapp/app/modules/statistic/controllers/statistic_controller.dart';
import 'package:myfinnapp/app/modules/statistic/models/chartData.dart';
import 'package:myfinnapp/app/modules/statistic/utils/chartDays.dart';
import 'package:myfinnapp/app/modules/statistic/utils/chartMonthly.dart';
import 'package:myfinnapp/app/modules/statistic/utils/chartWeekly.dart';

class CardStatistic extends StatelessWidget {
  final int valueChoose;

  CardStatistic({this.valueChoose});

  @override
  Widget build(BuildContext context) {
    var f = NumberFormat("#,##0.00", "en_US");

    final staticC = Get.put<StatisticController>(StatisticController());

    var largestMonth;
    if (staticC.getMonthTotal.isNotEmpty) {
      largestMonth = staticC.getMonthTotal[0];
      for (var i = 0; i < staticC.getMonthTotal.length; i++) {
        if (staticC.getMonthTotal[i] > largestMonth) {
          largestMonth = staticC.getMonthTotal[i];
        }
      }
    }
    print(largestMonth);

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
                  Text(
                    "Net balance",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 9,
                        color: Color(0xff67727d)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Rp. ${f.format(largestMonth)}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Obx(() => AspectRatio(
                      aspectRatio: 2,
                      child: BarChart(
                        staticC.valueChoose == 1
                            ? barChartWeeklys()
                            : staticC.valueChoose == 2
                                ? barChartMonthlys()
                                : barChartWeeklys(),
                      ))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
