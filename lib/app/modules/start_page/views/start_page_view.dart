import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myfinnapp/app/routes/app_pages.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../controllers/start_page_controller.dart';

class StartPageView extends GetView<StartPageController> {
  final _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width,
          child: PageView(
            controller: _controller,
            children: [
              Scaffold(
                backgroundColor: Colors.transparent,
                body: Padding(
                  padding: EdgeInsets.all(40),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: Colors.blue[300],
                    ),
                  ),
                ),
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                body: Padding(
                  padding: EdgeInsets.all(40),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: Colors.blue[300],
                    ),
                  ),
                ),
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                body: Padding(
                  padding: EdgeInsets.all(40),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: Colors.blue[300],
                    ),
                  ),
                ),
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                body: Padding(
                  padding: EdgeInsets.all(40),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: Colors.blue[300],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SmoothPageIndicator(
          controller: _controller,
          count: 4,
          effect: SwapEffect(
            activeDotColor: Colors.blue.shade300,
            dotColor: Colors.blue.shade100,
            dotHeight: 10,
            dotWidth: 20,
            spacing: 10,
          ),
        ),

        //Button Row
        SizedBox(height: 35),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.REGISTER);
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue[600],
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side:
                            BorderSide(color: Color.fromRGBO(0, 160, 227, 1)))),
                child: Text(
                  "Sign up",
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.LOGIN);
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                        color: Color.fromARGB(255, 30, 136, 229),
                      ),
                    )),
                child: Text(
                  "Sign in",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold, color: Colors.blue[600]),
                ),
              ),
            ),
          ],
        )
      ]),
    );
  }
}
