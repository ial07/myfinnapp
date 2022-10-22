import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfinnapp/app/modules/staticCredit/controllers/static_credit_controller.dart';

class ListWeekly extends StatelessWidget {
  const ListWeekly({
    Key key,
    @required this.controller,
    @required this.size,
  }) : super(key: key);

  final StaticCreditController controller;
  final Size size;

  @override
  Widget build(BuildContext context) {
    var staticC = Get.put(StaticCreditController());

    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(staticC.weeks.length, (index) {
          return GestureDetector(
            onTap: () {
              controller.activeWeek.value = index + 1;
              controller.getListTransactionOfWeek();
            },
            child: Container(
              width: (size.width - 40) / 6,
              child: Obx(
                () => staticC.weeks.isNotEmpty
                    ? Column(
                        children: [
                          Text(
                            staticC.weeks[index]['label'],
                            style: TextStyle(fontSize: 10),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Container(
                            width: 50,
                            height: 30,
                            decoration: BoxDecoration(
                                color: controller.activeWeek == index + 1
                                    ? Colors.blue[300]
                                    : Colors.transparent,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: controller.activeWeek == index + 1
                                        ? Colors.blue[300]
                                        : Colors.black.withOpacity(0.1))),
                            child: Center(
                              child: Text(
                                staticC.weeks[index]['day'],
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: controller.activeWeek == index + 1
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          ),
                        ],
                      )
                    : CircularProgressIndicator(),
              ),
            ),
          );
        }));
  }
}
