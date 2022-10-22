import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfinnapp/app/modules/staticCredit/controllers/static_credit_controller.dart';
import 'package:myfinnapp/app/modules/staticCredit/utils/staticModel.dart';

class ListDaily extends StatelessWidget {
  const ListDaily({
    Key key,
    @required this.controller,
    @required this.size,
  }) : super(key: key);

  final StaticCreditController controller;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(days.length, (index) {
          return GestureDetector(
            onTap: () {
              controller.activeDay.value = index;
            },
            child: Container(
              width: (size.width - 40) / 7,
              child: Column(
                children: [
                  Text(
                    days[index]['label'],
                    style: TextStyle(fontSize: 10),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Obx(() => Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: controller.activeDay == index
                                ? Colors.blue[300]
                                : Colors.transparent,
                            shape: BoxShape.rectangle,
                            border: Border.all(
                                color: controller.activeDay == index
                                    ? Colors.blue[300]
                                    : Colors.black.withOpacity(0.1)),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            days[index]['day'],
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: controller.activeDay == index
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          );
        }));
  }
}
