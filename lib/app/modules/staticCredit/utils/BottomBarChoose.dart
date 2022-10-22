import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myfinnapp/app/modules/staticCredit/controllers/static_credit_controller.dart';

class BottomBarChoose extends StatelessWidget {
  final int valueChoose;

  BottomBarChoose({
    this.valueChoose,
  });

  @override
  Widget build(BuildContext context) {
    final staticC = Get.put<StaticCreditController>(StaticCreditController());

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
                    color: Colors.blue[300],
                    borderRadius: BorderRadius.circular(50)),
                child: Icon(Icons.check, color: Colors.white),
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
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(50)),
                child: Icon(Icons.calendar_month),
              ),
              title: Text("Monthly", style: GoogleFonts.montserrat()),
            ),
          ),
        ],
      ),
    );
  }
}
