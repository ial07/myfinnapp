import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myfinnapp/app/models/AccountBankList.dart';
import 'package:myfinnapp/app/utils/BottomBar.dart';
import 'package:myfinnapp/app/utils/Iconback.dart';
import 'package:myfinnapp/app/utils/InputForm.dart';
import 'package:myfinnapp/app/utils/InputFormNumber.dart';
import 'package:myfinnapp/app/utils/SvgIcon.dart';

import '../controllers/create_trx_controller.dart';

import '../../../utils/color.dart' as color;

class CreateTrxView extends GetView<CreateTrxController> {
  @override
  Widget build(BuildContext context) {
    Get.put(CreateTrxController());
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //icon swipe
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.keyboard_double_arrow_down_outlined,
                  size: 25,
                  color: Colors.blue[600],
                ),
              ],
            ),
            SizedBox(height: 25),

            /// Title login
            Text(
              "CREATE TRANSACTION",
              style: GoogleFonts.montserrat(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.02),

            // Dropdown Account
            Obx(() => controller.getAccountBankList.isNotEmpty
                ? DropdownSearch<BankList>(
                    showSearchBox: true,
                    dropdownSearchDecoration:
                        InputDecoration(labelText: "Bank Account Name"),
                    mode: Mode.BOTTOM_SHEET,
                    onChanged: (value) =>
                        controller.idBankAccount.value = value?.id,
                    dropdownBuilder: _customDropDownPrograms,
                    popupItemBuilder: _customPopupItemBuilder,
                    onFind: (text) async {
                      var res = await controller.getAccountBankList;
                      if (res.length > 0) {
                        List<BankList> allAccountName = [];
                        res.forEach((element) {
                          allAccountName.add(BankList(
                            id: element.id,
                            userAccount: element.userAccount,
                            bank: element.bank,
                            notes: element.notes,
                            isDebit: element.isDebit,
                          ));
                        });
                        return allAccountName;
                      } else {
                        return [];
                      }
                    },
                    dropdownSearchBaseStyle: GoogleFonts.montserrat(),
                  )
                : Center(child: CircularProgressIndicator())),
            SizedBox(height: 15),

            ///Input Amount
            InputFormNumber(
                Title: "Amount",
                HintText: "Input amount",
                Controller: controller.AmountC),

            //Input Notes
            InputForm(
                Title: "Notes",
                HintText: "Enter notes",
                Controller: controller.NotesC),
            SizedBox(height: 20),

            ///Button
            Obx(() => SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (controller.isLoading.isFalse) {
                        await controller.SubmitTransaction();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue[600],
                        padding: EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(
                                color: Color.fromRGBO(0, 160, 227, 1)))),
                    child: Text(
                      controller.isLoading.isFalse ? "SUBMIT" : "LOADING...",
                      style:
                          GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

Widget _customDropDownPrograms(BuildContext context, BankList item) {
  return Container(
      child: (item == null)
          ? const ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text("Search Programs",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 13, color: Color.fromARGB(235, 158, 158, 158))),
            )
          : ListTile(
              contentPadding: const EdgeInsets.all(0),
              title: Text(
                item.bank.name,
                textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(),
              )));
}

Widget _customPopupItemBuilder(
    BuildContext context, dynamic item, bool isSelected) {
  var colors = item.bank.color;
  var colorresult;
  if (colors != "null") {
    colors = item.bank.color;
  } else {
    colors = '0x00000;0x2c3e50';
  }
  colorresult = colors.split(';');
  return Container(
    margin: const EdgeInsets.only(bottom: 5, left: 3, right: 3),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(int.parse(colorresult[0])).withOpacity(1),
          Color(int.parse(colorresult[1])).withOpacity(1),
        ],
      ),
      borderRadius: BorderRadius.circular(10),
      // boxShadow: [
      //   BoxShadow(
      //       offset: Offset(2, 5),
      //       blurRadius: 10,
      //       color: Colors.blue.withOpacity(0.3))
      // ],
    ),
    child: ListTile(
      title: Text(item.bank.name,
          style: GoogleFonts.montserrat(
              color: Colors.white, fontWeight: FontWeight.bold)),
      subtitle: Text(item.userAccount.accountName,
          style: GoogleFonts.montserrat(color: Colors.white)),
      leading: item.isDebit ? SvgIcon.debitSVG : SvgIcon.creditSVG,
      trailing: item.isDebit
          ? Text(
              "DEBIT",
              style: GoogleFonts.arimo(
                  fontWeight: FontWeight.bold, color: Colors.white),
            )
          : Text(
              "CREDIT",
              style: GoogleFonts.arimo(
                  fontWeight: FontWeight.bold, color: Colors.white),
            ),
    ),
  );
}
