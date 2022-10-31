import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myfinnapp/app/modules/statistic/utils/BottomBarChoose.dart';
import 'package:myfinnapp/app/modules/statistic/utils/CardStatistic.dart';
import 'package:myfinnapp/app/modules/statistic/utils/listMonthly.dart';
import 'package:myfinnapp/app/modules/statistic/utils/listTransactionMonth.dart';
import 'package:myfinnapp/app/modules/statistic/utils/listTransactionWeek.dart';
import 'package:myfinnapp/app/modules/statistic/utils/listWeekly.dart';
import 'package:myfinnapp/app/utils/Iconback.dart';

import '../controllers/statistic_controller.dart';

import '../../../utils/color.dart' as color;

class StatisticView extends GetView<StatisticController> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print(size.height);
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
              expandedHeight:
                  size.height > 670 ? size.height * 0.62 : size.height * 0.72,
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
                      Obx(() => Text(
                            controller.valueChoose == 1
                                ? "This Month"
                                : controller.valueChoose == 2
                                    ? "This Year"
                                    : "This Month",
                            style: GoogleFonts.montserrat(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          )),
                      SizedBox(height: 10),
                      CardStatistic(
                        valueChoose: controller.valueChoose.value,
                      ),
                      SizedBox(height: 10),
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
                  preferredSize: Size.fromHeight(size.height * 0.53)),
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
