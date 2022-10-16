import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myfinnapp/app/modules/staticCredit/utils/staticModel.dart';
import 'package:myfinnapp/app/modules/staticCredit/utils/chart.dart';
import 'package:myfinnapp/app/utils/Iconback.dart';
import '../../../utils/color.dart' as color;

import '../controllers/static_credit_controller.dart';

class StaticCreditView extends GetView<StaticCreditController> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    print(controller.activeDay);
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
                            // onTap: () => Get.bottomSheet(
                            //   BottomBarChoose(),
                            //   barrierColor: Colors.black38,
                            //   backgroundColor: Colors.white,
                            //   shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.vertical(
                            //         top: Radius.circular(20)),
                            //   ),
                            // ),
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
                          height: 200,
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
                                        "\$2446.90",
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
                                    height: 150,
                                    child: LineChart(
                                      mainData(),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(days.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                controller.activeDay.value = index;
                              },
                              child: Container(
                                width: (size.width - 40) / 7,
                                child: Column(
                                  children: [
                                    Text(
                                      days[index]['label'],
                                      style: TextStyle(fontSize: 10),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Obx(() => Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              color:
                                                  controller.activeDay == index
                                                      ? Colors.blue[300]
                                                      : Colors.transparent,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: controller.activeDay ==
                                                          index
                                                      ? Colors.blue[300]
                                                      : Colors.black
                                                          .withOpacity(0.1))),
                                          child: Center(
                                            child: Text(
                                              days[index]['day'],
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                  color: controller.activeDay ==
                                                          index
                                                      ? Colors.white
                                                      : Colors.black),
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            );
                          })),
                      Obx(() => Text(
                            controller.valueChoose == 1
                                ? "Days Exspenses"
                                : controller.valueChoose == 2
                                    ? "Weeks Exspenses"
                                    : controller.valueChoose == 3
                                        ? "Months Exspenses"
                                        : "Days Exspenses",
                            style: GoogleFonts.montserrat(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          )),
                      SizedBox(height: 10),
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
