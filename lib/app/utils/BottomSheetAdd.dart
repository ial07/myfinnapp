import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomSheetAdd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Colors.amber,
          );
        });
  }
}
