import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myfinnapp/app/modules/statistic/utils/BottomBarChoose.dart';
import 'package:myfinnapp/app/modules/statistic/utils/CardStatistic.dart';
import 'package:myfinnapp/app/utils/Iconback.dart';

import '../controllers/statistic_controller.dart';

import '../../../utils/color.dart' as color;

class StatisticView extends GetView<StatisticController> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
              expandedHeight: size.height * 0.58,
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
                                ? "This Week"
                                : controller.valueChoose == 2
                                    ? "This Month"
                                    : controller.valueChoose == 3
                                        ? "This Year"
                                        : "This Week",
                            style: GoogleFonts.montserrat(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          )),
                      SizedBox(height: 10),
                      CardStatistic(
                        valueChoose: controller.valueChoose.value,
                        // getMonthList: controller.GetListWeekMonth,
                        getMonthList: [6.0, 7.0, 2.0, 5.0, 8.0, 2.0],
                      )
                    ],
                  ),
                  preferredSize: Size.fromHeight(size.height * 0.4)),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 3, right: 10, left: 10),
                child: Container(
                  padding: EdgeInsets.all(5),
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
                  child: ListTile(
                    leading: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(20)),
                        child: Icon(Icons.send_and_archive)),
                    title: Text("Ini Title",
                        style: GoogleFonts.montserrat(
                            fontSize: 12, fontWeight: FontWeight.bold)),
                    subtitle: Text("6 transactions",
                        style: GoogleFonts.montserrat(fontSize: 10)),
                    trailing: Text("Rp. 23.000.000,00",
                        style: GoogleFonts.montserrat(
                            fontSize: 9, fontWeight: FontWeight.bold)),
                  ),
                ),
              );
            }, childCount: 7))
          ],
        ),
      ),
    );
  }
}
