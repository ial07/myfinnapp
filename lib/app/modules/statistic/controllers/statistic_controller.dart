import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:week_of_year/week_of_year.dart';

class StatisticController extends GetxController {
  var month = DateFormat.MMM().format(DateTime.now());
  var monthNum = DateFormat.M().format(DateTime.now());
  var year = DateFormat.y().format(DateTime.now());

  var listTransactionByAccountId = {}.obs;
  var getWeekTransactions = [].obs;
  List<double> getWeekTotal = List<double>().obs;
  RxDouble getWeekEstimated = 0.0.obs;
  RxDouble getMonthEstimated = 0.0.obs;
  List<double> getMonthTotal = List<double>().obs;
  List<double> getNormalizeWeekTransactions = List<double>().obs;
  RxDouble getWeekNormalizeEstimated = 0.0.obs;
  RxDouble getNormalizeWeekEstimated = 0.0.obs;
  List<double> getNormalizeMonthTransactions = List<double>().obs;
  RxDouble getMonthNormalizeEstimated = 0.0.obs;
  var getMonthTransactions = [].obs;

  var firstweekinMonth =
      DateTime(DateTime.now().year, DateTime.now().month).weekOfYear;
  var lastWeekinMonth = DateTime(DateTime.now().year, DateTime.now().month + 1)
      .add(Duration(days: -1))
      .weekOfYear;
  var currWeekinMonth =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .weekOfYear;

  List weeks = [].obs;
  List Months = [].obs;

  String getMonthInitial(key) {
    switch (key) {
      case 1:
        {
          month = "Jan";
        }
        break;
      case 2:
        {
          month = "Feb";
        }
        break;
      case 3:
        {
          month = "Mar";
        }
        break;
      case 4:
        {
          month = "Apr";
        }
        break;
      case 5:
        {
          month = "May";
        }
        break;
      case 6:
        {
          month = "Jun";
        }
        break;
      case 7:
        {
          month = "Jul";
        }
        break;
      case 8:
        {
          month = "Aug";
        }
        break;
      case 9:
        {
          month = "Sep";
        }
        break;
      case 10:
        {
          month = "Oct";
        }
        break;
      case 11:
        {
          month = "Nov";
        }
        break;
      case 12:
        {
          month = "Des";
        }
        break;
    }
    return month;
  }

  String fullMonthName(int key) {
    switch (key) {
      case 0:
        {
          month = "Januari";
        }
        break;
      case 1:
        {
          month = "Februari";
        }
        break;
      case 2:
        {
          month = "March";
        }
        break;
      case 3:
        {
          month = "April";
        }
        break;
      case 4:
        {
          month = "May";
        }
        break;
      case 5:
        {
          month = "Juni";
        }
        break;
      case 6:
        {
          month = "July";
        }
        break;
      case 7:
        {
          month = "August";
        }
        break;
      case 8:
        {
          month = "September";
        }
        break;
      case 9:
        {
          month = "October";
        }
        break;
      case 10:
        {
          month = "November";
        }
        break;
      case 11:
        {
          month = "Desember";
        }
        break;
    }
    return month;
  }

  String getMonth() {
    var m = DateFormat('MM').format(DateTime.now());
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

  RxInt valueChoose = 0.obs;
  RxInt activeDay = 0.obs;
  RxInt activeWeek = 0.obs;
  RxInt activeMonth = 0.obs;

  void getWeekTotalList() {
    var data = listTransactionByAccountId;
    var weekLengthInMonth = lastWeekinMonth - firstweekinMonth;
    getWeekTotal = [];
    for (var i = 1; i < weekLengthInMonth + 2; i++) {
      if (data["WeekTotal"]["week $i ${getMonth()} $year"] != null) {
        getWeekTotal.add(double.parse(
            data["WeekTotal"]["week $i ${getMonth()} $year"].toString()));
      } else {
        getWeekTotal.add(0);
      }
    }
  }

  void getWeekEstimatedList() {
    var data = listTransactionByAccountId;
    var weekLengthInMonth = lastWeekinMonth - firstweekinMonth;
    getWeekEstimated.value = 0.0;
    if (data != null)
      getWeekEstimated.value = double.parse(data["WeekEstimate"].toString());
  }

  void getListTransactionOfWeek() {
    getNormalizeWeekTransactions = [];
    var data = listTransactionByAccountId["Week"]
        ["week ${activeWeek} ${getMonth()} $year"];
    if (data != null) {
      getWeekTransactions.value = data;
    } else {
      getWeekTransactions.value = [];
    }
  }

  void getNormalisasiTransactionOfWeek() {
    getNormalizeWeekTransactions = [];
    getWeekNormalizeEstimated.value = 0.0;
    var data =
        listTransactionByAccountId["WeekTotalNormalize"]["${getMonth()} $year"];
    var weekLengthInMonth = lastWeekinMonth - firstweekinMonth;
    if (data["${getMonth()} $year estimate"] != null) {
      getWeekNormalizeEstimated.value =
          double.parse(data["${getMonth()} $year estimate"].toString());
      for (var i = 1; i < weekLengthInMonth + 2; i++) {
        if (data["week $i ${getMonth()} $year"] != null) {
          getNormalizeWeekTransactions.add(
              double.parse(data["week $i ${getMonth()} $year"].toString()));
        } else {
          getNormalizeWeekTransactions.add(0);
        }
      }
    }
  }

  void getMonthTotalList() {
    var data = listTransactionByAccountId;
    getMonthTotal = [];
    for (var i = 0; i < 12; i++) {
      if (data["MonthTotal"]["${fullMonthName(i)} $year"] != null) {
        getMonthTotal.add(double.parse(
            data["MonthTotal"]["${fullMonthName(i)} $year"].toString()));
      } else {
        getMonthTotal.add(0);
      }
    }
  }

  void getMonthEstimatedList() {
    var data = listTransactionByAccountId;
    getMonthEstimated.value = 0.0;
    if (data != null)
      getMonthEstimated.value = double.parse(data["MonthEstimate"].toString());
  }

  void getListTransactionOfMonth() {
    getNormalizeMonthTransactions = [];
    var data = listTransactionByAccountId["Month"]
        ["${fullMonthName(activeMonth.value)} $year"];
    if (data != null) {
      getMonthTransactions.value = data;
    } else {
      getMonthTransactions.value = [];
    }
  }

  void getNormalisasiTransactionOfMonth() {
    getNormalizeMonthTransactions = [];
    getMonthNormalizeEstimated.value = 0.0;
    var data = listTransactionByAccountId["MonthTotalNormalize"]["$year"];
    if (data["month $year estimate"] != null) {
      getMonthNormalizeEstimated.value =
          double.parse(data["month $year estimate"].toString());
      for (var i = 0; i < 12; i++) {
        if (data["${fullMonthName(i)} $year"] != null) {
          getNormalizeMonthTransactions
              .add(double.parse(data["${fullMonthName(i)} $year"].toString()));
        } else {
          getNormalizeMonthTransactions.add(0);
        }
      }
    }
  }

  void initialWeek() {
    var weekNow = currWeekinMonth - firstweekinMonth + 1;
    activeWeek.value = weekNow;
    var weekLengthInMonth = lastWeekinMonth - firstweekinMonth;
    for (var i = 1; i < weekLengthInMonth + 2; i++) {
      weeks.add({"label": "$month", "day": "Week ${i}"});
    }
  }

  void initialMonth() {
    activeMonth.value = int.parse(monthNum) - 1;
    for (var i = 1; i < 13; i++) {
      Months.add({"label": "$year", "day": "${getMonthInitial(i)}"});
    }
  }

  @override
  void onInit() {
    listTransactionByAccountId = Get.arguments;
    initialWeek();
    initialMonth();
    getListTransactionOfWeek();
    getWeekTotalList();
    getWeekEstimatedList();
    getListTransactionOfMonth();
    getMonthTotalList();
    getMonthEstimatedList();
    getNormalisasiTransactionOfWeek();
    getNormalisasiTransactionOfMonth();
    super.onInit();
  }

  @override
  void dispose() {
    getNormalizeMonthTransactions;
    getNormalizeWeekTransactions;
    getNormalizeWeekEstimated.value;
    super.dispose();
  }
}
