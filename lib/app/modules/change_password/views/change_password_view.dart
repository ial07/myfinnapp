import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myfinnapp/app/utils/Iconback.dart';

import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
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
            children: [
              /// icon top bar
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                IconBack(),
              ]),
              SizedBox(height: size.height * 0.1),

              /// Input group
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text("Old Password",
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                TextFormField(
                  controller: controller.oldPassC,
                  autocorrect: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    hintText: "Enter old password",
                    filled: true,
                    fillColor: Colors.blue[50],
                  ),
                ),
                SizedBox(height: size.height * 0.1),
                Text("New Password",
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Obx(() => TextFormField(
                      controller: controller.newPassC,
                      autocorrect: false,
                      obscureText: controller.isVisible.isFalse ? true : false,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () => controller.isVisible.toggle(),
                          icon: Icon(controller.isVisible.isFalse
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined),
                          color: Colors.blue[300],
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        hintText: "Enter New password",
                        filled: true,
                        fillColor: Colors.blue[50],
                      ),
                    )),
                SizedBox(height: 15),
                Text("Confirm Password",
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Obx(() => TextFormField(
                      controller: controller.confirmNewPassC,
                      autocorrect: false,
                      obscureText:
                          controller.isConfirmVisible.isFalse ? true : false,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () => controller.isConfirmVisible.toggle(),
                          icon: Icon(controller.isConfirmVisible.isFalse
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined),
                          color: Colors.blue[300],
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        hintText: "Enter password",
                        filled: true,
                        fillColor: Colors.blue[50],
                      ),
                    )),
              ]),

              SizedBox(height: 30),

              ///Button
              Obx(() => SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (controller.isLoading.isFalse) {
                          await controller.changePass();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blue[600],
                          padding: EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(
                                  color: Color.fromRGBO(0, 160, 227, 1)))),
                      child: Text(
                        controller.isLoading.isFalse ? "UPDATE" : "LOADING...",
                        style:
                            GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
