import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon {
  static Widget creditSVG = SvgPicture.asset(
    'assets/credit.svg',
    color: Colors.white,
    semanticsLabel: 'A red up arrow',
    height: 20,
    width: 20,
  );
  static Widget debitSVG = SvgPicture.asset(
    'assets/debit.svg',
    color: Colors.white,
    semanticsLabel: 'A red up arrow',
    height: 20,
    width: 20,
  );
}
