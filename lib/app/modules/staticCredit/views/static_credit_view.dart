import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:myfinnapp/app/modules/staticCredit/utils/chartMonthly.dart';
import 'package:myfinnapp/app/modules/staticCredit/utils/chartWeekly.dart';
import 'package:myfinnapp/app/modules/staticCredit/utils/BottomBarChoose.dart';
import 'package:myfinnapp/app/modules/staticCredit/utils/listMonthly.dart';
import 'package:myfinnapp/app/modules/staticCredit/utils/listTransactionMonth.dart';
import 'package:myfinnapp/app/modules/staticCredit/utils/listTransactionWeek.dart';
import 'package:myfinnapp/app/modules/staticCredit/utils/listWeekly.dart';
import 'package:myfinnapp/app/utils/Iconback.dart';
import '../../../utils/color.dart' as color;

import '../controllers/static_credit_controller.dart';

class StaticCreditView extends GetView<StaticCreditController> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var f = NumberFormat("#,##0.00", "en_US");
    var largestMonth;
    if (controller.getMonthTotal.isNotEmpty) {
      largestMonth = controller.getMonthTotal[0];
      for (var i = 0; i < controller.getMonthTotal.length; i++) {
        if (controller.getMonthTotal[i] > largestMonth) {
          largestMonth = controller.getMonthTotal[i];
        }
      }
    }
    return Scaffold(
      backgroundColor: color.AppColor.PageBackground,
      body: Padding(
        padding: EdgeInsets.only(
            top: size.height * 0.04,
            left: size.width * 0.05,
            right: size.width * 0.05),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              expandedHeight: size.height * 0.6,
              backgroundColor: color.AppColor.PageBackground,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconBack(),
                          InkWell(
                            onTap: () => Get.bottomSheet(
                              BottomBarChoose(),
                              barrierColor: Colors.black38,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20)),
                              ),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.circular(100)),
                              child: Icon(
                                Icons.calendar_month,
                                color: Colors.blue[300],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              bottom: PreferredSize(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          width: double.infinity,
                          height: size.height * 0.35,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.01),
                                  spreadRadius: 10,
                                  blurRadius: 3,
                                  // changes position of shadow
                                ),
                              ]),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      )
                                    ],
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: Container(
                                    width: (size.width - 20),
                                    height: size.height * 0.2,
                                    child: Obx(() => LineChart(
                                          controller.valueChoose == 1
                                              ? mainDataWeekly()
                                              : controller.valueChoose == 2
                                                  ? mainDataMonthly()
                                                  : mainDataWeekly(),
                                        )),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Obx(() => controller.valueChoose == 1
                          ? ListWeekly(
                              controller: controller,
                              size: size,
                            )
                          : controller.valueChoose == 2
                              ? ListMonthly(
                                  controller: controller,
                                  size: size,
                                )
                              : ListWeekly(
                                  controller: controller,
                                  size: size,
                                )),
                      SizedBox(height: 10),
                      Obx(() => Text(
                            controller.valueChoose == 1
                                ? "Weeks Exspenses"
                                : controller.valueChoose == 2
                                    ? "Months Exspenses"
                                    : "Weeks Exspenses",
                            style: GoogleFonts.montserrat(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          )),
                      SizedBox(height: 10),
                    ],
                  ),
                  preferredSize: Size.fromHeight(size.height * 0.43)),
            ),
            Obx(
              () => controller.valueChoose == 1
                  ? SliverListWeek()
                  : controller.valueChoose == 2
                      ? SliverListMonth()
                      : SliverListWeek(),
            ),
          ],
        ),
      ),
    );
  }
}
