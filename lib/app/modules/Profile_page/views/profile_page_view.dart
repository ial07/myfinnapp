import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myfinnapp/app/routes/app_pages.dart';
import 'package:myfinnapp/app/utils/BottomBar.dart';

import '../controllers/profile_page_controller.dart';

class ProfilePageView extends GetView<ProfilePageController> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            top: size.height * 0.12,
            right: size.width * 0.1,
            left: size.width * 0.1),
        child: Column(
          children: [
            /// icon top bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.fingerprint_sharp),
                Badge(
                  badgeContent: Text(
                    '3',
                    style: GoogleFonts.montserrat(color: Colors.white),
                  ),
                  child: Icon(Icons.notifications),
                )
              ],
            ),
            SizedBox(height: 30),
            Stack(
              children: [
                Container(height: size.height * 0.25),
                Center(
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.teal,
                    child: CircleAvatar(
                        backgroundColor: Colors.greenAccent[400],
                        radius: 65,
                        child: Icon(Icons.person)),
                  ),
                ),
                Positioned(
                  top: size.height * 0.16,
                  left: size.width * 0.45,
                  child: InkWell(
                    onTap: () => Get.toNamed(Routes.PROFILE_EDIT),
                    child: CircleAvatar(
                      radius: 19,
                      backgroundColor: Colors.blue[50],
                      child: CircleAvatar(
                          backgroundColor: Colors.blue[300],
                          radius: 15,
                          child: Icon(
                            Icons.edit,
                            size: 17,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ),
              ],
            ),
            Text("ILHAM ALMALIK",
                style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
            Text("ialilham77@gmail.com",
                style: GoogleFonts.montserrat(
                    fontSize: 11, fontStyle: FontStyle.italic)),
            SizedBox(
              height: size.height * 0.1,
            ),
            Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.blue[300],
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(Icons.phone_callback_rounded),
                    title: Text("Contact Us", style: GoogleFonts.montserrat()),
                  ),
                  ListTile(
                    leading: Icon(Icons.logout_rounded),
                    title: Text("Logout", style: GoogleFonts.montserrat()),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Text("v1.0",
                style: GoogleFonts.montserrat(
                    color: Colors.grey,
                    fontSize: 9,
                    fontStyle: FontStyle.italic)),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
