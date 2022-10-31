import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myfinnapp/app/modules/statistic/controllers/statistic_controller.dart';

class BottomBarChoose extends StatelessWidget {
  final int valueChoose;

  BottomBarChoose({
    this.valueChoose,
  });

  @override
  Widget build(BuildContext context) {
    final staticC = Get.put<StatisticController>(StatisticController());
    return Container(
      height: MediaQuery.of(context).size.height * 0.27,
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text("View Analytic",
                style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
          ),
          InkWell(
            onTap: () {
              staticC.valueChoose.value = 1;
              Get.back();
            },
            child: ListTile(
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: staticC.valueChoose.value == 0
                        ? Colors.blue[300]
                        : staticC.valueChoose.value == 1
                            ? Colors.blue[300]
                            : Colors.blue[50],
                    borderRadius: BorderRadius.circular(50)),
                child: staticC.valueChoose.value == 0
                    ? Icon(Icons.check, color: Colors.white)
                    : staticC.valueChoose.value == 1
                        ? Icon(Icons.check, color: Colors.white)
                        : Icon(Icons.calendar_month),
              ),
              title: Text("Weekly", style: GoogleFonts.montserrat()),
            ),
          ),
          InkWell(
            onTap: () {
              staticC.valueChoose.value = 2;
              Get.back();
            },
            child: ListTile(
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: staticC.valueChoose.value == 2
                        ? Colors.blue[300]
                        : Colors.blue[50],
                    borderRadius: BorderRadius.circular(50)),
                child: staticC.valueChoose.value == 2
                    ? Icon(Icons.check, color: Colors.white)
                    : Icon(Icons.calendar_month),
              ),
              title: Text("Monthly", style: GoogleFonts.montserrat()),
            ),
          ),
        ],
      ),
    );
  }
}
