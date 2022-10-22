import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:myfinnapp/app/modules/statistic/controllers/statistic_controller.dart';

class SliverListMonth extends StatelessWidget {
  const SliverListMonth({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var listTrx = Get.put(StatisticController());
    var f = NumberFormat("#,##0.00", "en_US");

    return Obx(() => listTrx.getMonthTransactions.length > 0
        ? SliverList(
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
                      child: Icon(
                        Icons.monetization_on_outlined,
                        color: Colors.grey.withOpacity(0.3),
                      )),
                  title: Text("${listTrx.getMonthTransactions[index]["Notes"]}",
                      style: GoogleFonts.montserrat(
                          fontSize: 11, fontWeight: FontWeight.bold)),
                  subtitle: Text(
                      "${DateFormat("dd-MMM-yyyy").format(DateTime.parse(listTrx.getMonthTransactions[index]["CreatedDate"]))}",
                      style: GoogleFonts.montserrat(fontSize: 8)),
                  trailing: Text(
                      "Rp. ${f.format(listTrx.getMonthTransactions[index]["Amount"])}",
                      style: GoogleFonts.montserrat(
                          fontSize: 9, fontWeight: FontWeight.bold)),
                ),
              ),
            );
          }, childCount: listTrx.getMonthTransactions.length))
        : SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Center(
                  child: Text("Transaction Not Found",
                      style: GoogleFonts.montserrat())),
            );
          }, childCount: 1)));
  }
}
