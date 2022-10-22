import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:myfinnapp/app/models/AccountBankList.dart';
import 'package:myfinnapp/app/modules/home/controllers/home_controller.dart';
import 'package:myfinnapp/app/routes/app_pages.dart';
import 'package:myfinnapp/app/utils/SvgIcon.dart';

class CardBank extends StatelessWidget {
  final String NamaBank;
  final String Amount;
  final String Type;
  final String Note;
  final int Color1;
  final int Color2;
  final bool isDebit;
  final DateTime ExpectedDate;
  final int TotalMonthExpenses;

  CardBank({
    this.NamaBank,
    this.Amount,
    this.Type,
    this.Note,
    this.Color1,
    this.Color2,
    this.isDebit,
    this.ExpectedDate,
    this.TotalMonthExpenses,
  });

  @override
  Widget build(BuildContext context) {
    var f = NumberFormat("#,##0.00", "en_US");

    var staticC = Get.put(HomeController());

    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(Color1).withOpacity(1),
                  Color(Color2).withOpacity(1),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("$NamaBank",
                              style: GoogleFonts.amiri(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          isDebit ? SvgIcon.creditSVG : SvgIcon.debitSVG
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          isDebit != true
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Amount",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 13, color: Colors.white)),
                                    Text(
                                        "Rp ${f.format(int.parse(Amount) - TotalMonthExpenses)}",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 13,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Current Amount",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 10, color: Colors.white)),
                                    Text("Rp ${f.format(int.parse(Amount))}",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 10,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                          isDebit == true
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text("Expected Amount",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 10, color: Colors.white)),
                                    Text("Rp.13,000,000",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 10,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                )
                              : Text(""),
                        ],
                      ),
                    ],
                  ),
                  isDebit == true
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(""),
                            Text(""),
                            Column(
                              children: [
                                Text("estimated savings per month",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 7, color: Colors.white)),
                                Text("Rp.13,000,000",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 7,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("Until",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 7, color: Colors.white)),
                                Text(
                                    "${DateFormat("dd-MMM-yyyy").format(ExpectedDate)}",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 7,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ],
                            )
                          ],
                        )
                      : Text(""),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("$Type",
                              style: GoogleFonts.montserrat(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)),
                          Text("$Note",
                              style: GoogleFonts.montserrat(
                                  fontSize: 7, color: Colors.white)),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          isDebit
                              ? Get.toNamed(Routes.STATISTIC,
                                  arguments: staticC.listTransactionByAccountId)
                              : Get.toNamed(Routes.STATIC_CREDIT,
                                  arguments:
                                      staticC.listTransactionByAccountId);
                        },
                        child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(2, 5),
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.3))
                              ],
                            ),
                            child: Icon(Icons.query_stats_rounded, size: 22)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
