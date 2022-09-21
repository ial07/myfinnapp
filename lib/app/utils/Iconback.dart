import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IconBack extends StatelessWidget {
  final double size;

  const IconBack({
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => Get.back(),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(100)),
            child: Icon(
              Icons.arrow_back,
              color: Colors.blue[300],
            ),
          ),
        ),
        SizedBox(height: size),
      ],
    );
  }
}
