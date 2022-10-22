import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfinnapp/app/modules/staticCredit/controllers/static_credit_controller.dart';

class ListMonthly extends StatelessWidget {
  const ListMonthly({
    Key key,
    @required this.controller,
    @required this.size,
  }) : super(key: key);

  final StaticCreditController controller;
  final Size size;

  @override
  Widget build(BuildContext context) {
    var staticC = Get.put(StaticCreditController());
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Obx(() => staticC.Months.isNotEmpty
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(staticC.Months.length, (index) {
                return GestureDetector(
                  onTap: () {
                    controller.activeMonth.value = index;
                    controller.getListTransactionOfMonth();
                  },
                  child: Container(
                    width: (size.width - 40) / 7,
                    child: Column(
                      children: [
                        Text(
                          staticC.Months[index]['label'],
                          style: TextStyle(fontSize: 10),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: controller.activeMonth == index
                                ? Colors.blue[300]
                                : Colors.transparent,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: controller.activeMonth == index
                                    ? Colors.blue[300]
                                    : Colors.black.withOpacity(0.1)),
                          ),
                          child: Center(
                            child: Text(
                              staticC.Months[index]['day'],
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: controller.activeMonth == index
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }))
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
              ],
            )),
    );
  }
}
