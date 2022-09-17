import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myfinnapp/app/modules/home/utils/CardBank.dart';
import 'package:myfinnapp/app/modules/home/utils/CardListHistory.dart';
import 'package:myfinnapp/app/utils/BottomBar.dart';

import '../controllers/home_controller.dart';
import '../../../utils/color.dart' as color;

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: color.AppColor.homePageBackground,
      body: Container(
        padding: EdgeInsets.only(top: size.height * 0.1, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.square,
                  size: 40,
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 219, 189, 100),
                    borderRadius: BorderRadius.circular(100),
                  ),
                )
              ],
            ),
            SizedBox(height: 30),

            // Title
            Text(
              "My Cards",
              style: GoogleFonts.montserrat(
                  fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // List card
            Expanded(
                child: Container(
              height: size.height * 0.25,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  CardBank(
                      NamaBank: "BANK EKSPOR INDONESIA", Price: "60,000,000"),
                  CardBank(NamaBank: "BRI", Price: "60,000,000"),
                  CardBank(
                      NamaBank: "BANK OF AMERICA, N.A", Price: "60,000,000"),
                ],
              ),
            )),
            SizedBox(height: 30),

            // History
            Text(
              "List Transaction",
              style: GoogleFonts.montserrat(
                  fontSize: 20, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 5),

            // List Card History
            Expanded(
                child: ListView(
              children: [
                CardListHistory(
                  Title: "Ini Title",
                  SubTitle: "Ini Subtitle",
                  Price: "50,000",
                  Date: "16 Sep",
                ),
                CardListHistory(
                  Title: "Ini Title",
                  SubTitle: "Ini Subtitle",
                  Price: "50,000",
                  Date: "16 Sep",
                ),
                CardListHistory(
                  Title: "Ini Title",
                  SubTitle: "Ini Subtitle",
                  Price: "50,000",
                  Date: "16 Sep",
                ),
                CardListHistory(
                  Title: "Ini Title",
                  SubTitle: "Ini Subtitle",
                  Price: "50,000",
                  Date: "16 Sep",
                ),
              ],
            ))
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
