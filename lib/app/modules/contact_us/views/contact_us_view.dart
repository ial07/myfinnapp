import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myfinnapp/app/utils/Iconback.dart';

import '../controllers/contact_us_controller.dart';

class ContactUsView extends GetView<ContactUsController> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: size.height * 0.1,
              right: size.width * 0.1,
              left: size.width * 0.1,
              bottom: size.height * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// icon top bar
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                IconBack(),
              ]),
              SizedBox(height: size.height * 0.1),

              /// Input group
              Container(
                  height: 150,
                  width: 150,
                  child: Image.asset('assets/logo.png')),
              SizedBox(height: 20),
              Text("Phone : (+62) 85381680323",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold, color: Colors.blue[300])),
              SizedBox(height: 10),

              Text("Email : myfinnplan@gmail.com",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold, color: Colors.blue[300])),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
