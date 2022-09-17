import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardListHistory extends StatelessWidget {
  final String Title;
  final String SubTitle;
  final String Price;
  final String Date;

  CardListHistory({
    required this.Title,
    required this.SubTitle,
    required this.Price,
    required this.Date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.height * 0.15,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
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
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(2, 5),
                              blurRadius: 10,
                              color: Colors.grey.withOpacity(0.3))
                        ],
                      ),
                      child: Icon(Icons.chat, size: 22)),
                  SizedBox(width: 15),
                  // Center Item
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("$Title",
                          style: GoogleFonts.montserrat(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      Text("$SubTitle",
                          style: GoogleFonts.montserrat(fontSize: 11)),
                    ],
                  ),
                ],
              ),

              // Right item
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Rp $Price",
                      style: GoogleFonts.montserrat(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                  Text("$Date", style: GoogleFonts.montserrat(fontSize: 12)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
