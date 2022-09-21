import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myfinnapp/app/modules/home/utils/CardBank.dart';
import 'package:myfinnapp/app/modules/home/utils/CardListHistory.dart';
import 'package:myfinnapp/app/routes/app_pages.dart';
import 'package:myfinnapp/app/utils/BottomBar.dart';
import 'package:get_storage/get_storage.dart';
import '../controllers/home_controller.dart';
import '../../../utils/color.dart' as color;

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: color.AppColor.PageBackground,
      body: Container(
        padding: EdgeInsets.only(top: size.height * 0.07, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    GetStorage().erase();
                    Get.offAllNamed(Routes.START_PAGE);
                  },
                  child: Icon(
                    Icons.square,
                    size: 40,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 219, 189, 100),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: size.height * 0.05),

            // Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "My Cards",
                  style: GoogleFonts.montserrat(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.CREATE_BANK_ACCOUNT);
                    },
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.blue[600],
                        borderRadius: BorderRadius.circular(3),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(1, 3),
                              blurRadius: 5,
                              color: Colors.black.withOpacity(0.2))
                        ],
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
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
                    NamaBank: "BANK BRI",
                    Amount: "60,000,000",
                    Type: "Tabungan",
                    Note: "Tabungan Nikah",
                    Color1: 0x1E88E5,
                    Color2: 0x87ceeb,
                  ),
                  CardBank(
                    NamaBank: "BANK DANAMON",
                    Amount: "60,000,000",
                    Type: "Tabungan",
                    Note: "Tabungan Nikah",
                    Color1: 0xff4500,
                    Color2: 0xff4500,
                  ),
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
