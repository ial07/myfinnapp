import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:myfinnapp/app/utils/SvgIcon.dart';
import '../../../utils/color.dart' as color;

class CardListHistory extends StatelessWidget {
  final String Title;
  final String SubTitle;
  final String Price;
  final DateTime Date;
  final bool isDebit;

  CardListHistory(
      {this.Title, this.SubTitle, this.Price, this.Date, this.isDebit});

  @override
  Widget build(BuildContext context) {
    var f = NumberFormat("#,##0.00", "en_US");
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.height * 0.15,
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(10),
          // boxShadow: [
          //   BoxShadow(
          //       offset: Offset(2, 4),
          //       blurRadius: 5,
          //       color: Colors.black.withOpacity(0.2))
          // ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(2, 5),
                              blurRadius: 10,
                              color: Colors.blue.withOpacity(0.3))
                        ],
                      ),
                      child: Icon(
                        Icons.monetization_on_outlined,
                        color: Colors.black54,
                      )),
                  SizedBox(width: 15),
                  // Center Item
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Text(
                      //     "${Title.split(" ")[0]} ${Title.split(" ").length > 1 ? "..." : ""}",
                      //     style: GoogleFonts.montserrat(
                      //         fontSize: 12, fontWeight: FontWeight.bold)),
                      Text("$SubTitle",
                          style: GoogleFonts.montserrat(fontSize: 10)),
                      Text("Rp ${f.format(int.parse(Price))}",
                          style: GoogleFonts.montserrat(
                              fontSize: 11, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),

              // Right item
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Text("Rp ${f.format(int.parse(Price))}",
                  //     style: GoogleFonts.montserrat(
                  //         fontSize: 11, fontWeight: FontWeight.bold)),
                  Text("${DateFormat("dd-MMM-yyyy").format(Date)}",
                      style: GoogleFonts.montserrat(fontSize: 8)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
