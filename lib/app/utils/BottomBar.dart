import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfinnapp/app/controller/MainController.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class BottomBar extends StatelessWidget {
  final pageC = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      style: TabStyle.fixedCircle,
      color: Colors.blue[600],
      backgroundColor: Colors.white,
      activeColor: Colors.blue[300],

      height: MediaQuery.of(context).size.height * 0.07,
      items: [
        TabItem(icon: Icons.home),
        // TabItem(icon: Icons.list_alt),
        TabItem(icon: Icons.add),
        // TabItem(icon: Icons.account_balance_wallet),
        TabItem(icon: Icons.people_alt),
      ],
      initialActiveIndex: pageC.pageIndex.value, //optional, default as 0
      onTap: (int i) => pageC.changePage(i),
    );
  }
}
