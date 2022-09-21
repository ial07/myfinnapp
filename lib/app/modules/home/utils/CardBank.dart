import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardBank extends StatelessWidget {
  final String NamaBank;
  final String Amount;
  final String Type;
  final String Note;
  final int Color1;
  final int Color2;

  CardBank({
    this.NamaBank,
    this.Amount,
    this.Type,
    this.Note,
    this.Color1,
    this.Color2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.82,
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
                  Text("$NamaBank",
                      style: GoogleFonts.amiri(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  Text("Rp $Amount",
                      style: GoogleFonts.montserrat(
                          fontSize: 14, color: Colors.white)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("$Type",
                      style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("$Note",
                      style: GoogleFonts.montserrat(
                          fontSize: 12, color: Colors.white)),
                  Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(2, 5),
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.3))
                        ],
                      ),
                      child: Icon(Icons.line_axis, size: 22)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
