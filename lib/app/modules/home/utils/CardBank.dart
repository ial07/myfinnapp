import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardBank extends StatelessWidget {
  final String NamaBank;
  final String Price;

  CardBank({required this.NamaBank, required this.Price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0x1e90ff).withOpacity(0.8),
              const Color(0x1e90ff).withOpacity(0.2),
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
              Text("$NamaBank",
                  style: GoogleFonts.amiri(
                      fontSize: 14, fontWeight: FontWeight.bold)),
              Text("Rp $Price",
                  style: GoogleFonts.montserrat(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
