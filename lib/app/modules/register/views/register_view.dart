import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myfinnapp/app/routes/app_pages.dart';
import 'package:myfinnapp/app/utils/InputFormNumber.dart';

import '../controllers/register_controller.dart';
import '../../../utils/color.dart' as color;
import '../../../utils/InputForm.dart';
import '../../../utils/Iconback.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: color.AppColor.PageBackground,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
              top: size.height * 0.07,
              left: size.width * 0.1,
              right: size.width * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //icon Back
              IconBack(size: size.height * 0.08),

              /// Title login
              Text(
                "REGISTER",
                style: GoogleFonts.montserrat(
                    fontSize: 35, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.08),

              /// Input group
              InputForm(
                  Title: "Your email",
                  HintText: "Enter email",
                  Controller: controller.emailC),

              InputForm(
                  Title: "Username",
                  HintText: "Enter username",
                  Controller: controller.nameC),

              InputFormNumber(
                  Title: "No HP",
                  HintText: "Enter No HP",
                  Controller: controller.nohpC),

              Text("Password",
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Obx(() => TextFormField(
                    controller: controller.passC,
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
                      hintText: "Enter password",
                      filled: true,
                      fillColor: Colors.blue[50],
                    ),
                  )),
              SizedBox(height: 15),

              Text("Confirm Password",
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Obx(() => TextFormField(
                    controller: controller.confirmPassC,
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
              SizedBox(height: 30),

              ///Button
              Obx(() => SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (controller.isLoading.isFalse) {
                          await controller.processRegister();
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
                        controller.isLoading.isFalse
                            ? "REGISTER"
                            : "LOADING...",
                        style:
                            GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                      ),
                    ),
                  )),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already registered.",
                    style: GoogleFonts.montserrat(),
                  ),
                  TextButton(
                    onPressed: () => Get.toNamed(Routes.LOGIN),
                    child: Text("LOGIN", style: GoogleFonts.montserrat()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
