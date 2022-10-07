import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:myfinnapp/app/function/sessionHandlerFunction.dart';
// import 'package:myfinnapp/app/models/GetListTRX.dart';
import 'package:myfinnapp/service/network_handler.dart';
import '../models/chartData.dart';

class StatisticController extends GetxController {
  final dataUser = GetStorage();
  RxInt valueChoose = 0.obs;
  DateTime now = DateTime.now();
  var Year = DateFormat('yyyy').format(DateTime.now()).toString();

  var GetListWeekMonth = [].obs;
  List<double> SumAmmountWeek = List<double>().obs;

  Map<String, List<dynamic>> temp = new Map<String, List<dynamic>>().obs;
  Map<String, List<dynamic>> temp2 = new Map<String, List<dynamic>>().obs;

  @override
  void onInit() {
    getResponse();

    super.onInit();
  }

  String getMonth() {
    var m = DateFormat('MM').format(now);
    var month = "";
    switch (m) {
      case '01':
        {
          month = "January";
        }
        break;
      case '02':
        {
          month = "February";
        }
        break;
      case '03':
        {
          month = "March";
        }
        break;
      case '04':
        {
          month = "April";
        }
        break;
      case '05':
        {
          month = "May";
        }
        break;
      case '06':
        {
          month = "Juni";
        }
        break;
      case '07':
        {
          month = "July";
        }
        break;
      case '08':
        {
          month = "August";
        }
        break;
      case '09':
        {
          month = "September";
        }
        break;
      case '10':
        {
          month = "October";
        }
        break;
      case '11':
        {
          month = "November";
        }
        break;
      case '12':
        {
          month = "Desember";
        }
        break;
    }
    return month;
  }

  void getResponse() async {
    Map<String, dynamic> data = dataUser.read("dataUser");
    final idUser = data["profile"]["Id"];
    var response = await NetworkHandler.get("gettransactionbybankaccountid/1");
    if (response.toString().contains('Session End')) {
      sessionHandlerFunction.ExpiredTokenRetryPolicy();
    } else {
      var result = json.decode(response);
      var months = [
        "January",
        "February",
        "March",
        "April",
        "May",
        "Juni",
        "July",
        "August",
        "September",
        "October",
        "November",
        "Desember"
      ];

      // print(result["data"]["WeekTotal"]["week 2 October 2022"]);

      for (var month in months) {
        temp2[month + " $Year"] = result["data"]["Month"][month + " $Year"];
        for (var i = 1; i < 6; i++) {
          temp["week " + i.toString() + " " + month + " $Year"] =
              (result["data"]["Week"]
                  ["week " + i.toString() + " " + month + " $Year"]);
        }
      }

      for (var i = 1; i < 6; i++) {
        if (temp["week $i ${getMonth()} $Year"] == null) {
          GetListWeekMonth.add(0);
        } else {
          GetListWeekMonth.add(temp["week $i ${getMonth()} $Year"]);
        }
      }
      double Amount = 0;
      for (var i = 0; i < GetListWeekMonth.length; i++) {
        for (var j = 0; j < GetListWeekMonth[1].length; j++) {
          if (GetListWeekMonth[i] != 0) {
            Amount += GetListWeekMonth[1][j]["Amount"];
          }
        }
        if (GetListWeekMonth[i] != 0) {
          SumAmmountWeek.add(Amount);
        } else {
          SumAmmountWeek.add(0);
        }
      }
    }
  }
}
