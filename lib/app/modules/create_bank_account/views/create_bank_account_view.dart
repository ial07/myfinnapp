import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myfinnapp/app/modules/create_bank_account/models/getAccount.dart';
import 'package:myfinnapp/app/modules/create_bank_account/models/getBank.dart';
import 'package:myfinnapp/app/routes/app_pages.dart';
import 'package:myfinnapp/app/utils/Iconback.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:myfinnapp/app/utils/InputForm.dart';
import 'package:myfinnapp/app/utils/InputFormNumber.dart';
import '../controllers/create_bank_account_controller.dart';

import '../../../utils/color.dart' as color;

class CreateBankAccountView extends GetView<CreateBankAccountController> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: color.AppColor.PageBackground,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
              top: size.height * 0.07,
              left: size.width * 0.1,
              right: size.width * 0.1,
              bottom: size.height * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //icon Back
              IconBack(size: size.height * 0.07),

              /// Title login
              Text(
                "CREATE BANK ACCOUNT",
                style: GoogleFonts.montserrat(
                    fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.08),

              /// Input group
              Text("Add Account",
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.accountNameC,
                      autocorrect: false,
                      maxLength: 35,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          hintText: "Type here",
                          filled: true,
                          fillColor: Colors.blue[50],
                          helperStyle:
                              GoogleFonts.montserrat(color: Colors.blue[100])),
                      style: GoogleFonts.montserrat(),
                    ),
                  ),
                  Obx(
                    () => controller.isLoadingAccount.isFalse
                        ? Container(
                            margin: new EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                                color: Colors.blue[600],
                                borderRadius: BorderRadius.circular(10)),
                            child: new IconButton(
                                icon: new Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                onPressed: () async {
                                  if (controller.isLoadingAccount.isFalse) {
                                    await controller.addAccount();
                                  }
                                }),
                          )
                        : Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: CircularProgressIndicator()),
                  )
                ],
              ),
              Text("Only add if your account does not exist",
                  style:
                      GoogleFonts.montserrat(fontSize: 8, color: Colors.red)),
              Container(
                height: 3,
                width: size.width,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.2), //color of border
                    width: 2, //width of border
                  ),
                ),
              ),
              SizedBox(height: 35),
              // Dropdown Account
              Obx(() => controller.getAccountList.isNotEmpty
                  ? DropdownSearch<Datum>(
                      showSearchBox: true,
                      dropdownSearchDecoration:
                          InputDecoration(labelText: "Account Name"),
                      mode: Mode.BOTTOM_SHEET,
                      onChanged: (value) =>
                          controller.idAccount.value = value?.id,
                      dropdownBuilder: (context, selectedItem) => Text(
                        selectedItem?.accountName ?? "Choose Account...",
                        style: GoogleFonts.montserrat(),
                      ),
                      popupItemBuilder: (context, item, isSelected) => ListTile(
                        title: Text(item.accountName),
                      ),
                      onFind: (text) async {
                        var res = await controller.getAccountList;
                        if (res.length > 0) {
                          List<Datum> allAccountName = [];
                          res.forEach((element) {
                            allAccountName.add(Datum(
                              id: element.id,
                              accountName: element.accountName,
                            ));
                          });
                          return allAccountName;
                        } else {
                          return [];
                        }
                      },
                    )
                  : Center(child: CircularProgressIndicator())),
              SizedBox(height: 15),

              /// Get Bank Dropdown
              Row(
                children: [
                  Text(
                    "if your bank account not registered in list, please select",
                    style: GoogleFonts.montserrat(fontSize: 6),
                  ),
                  Text(" MY FINN BANK",
                      style: GoogleFonts.montserrat(
                          fontSize: 6, fontWeight: FontWeight.bold))
                ],
              ),
              Obx(() => controller.getBankList.isNotEmpty
                  ? DropdownSearch<BankData>(
                      showSearchBox: true,
                      dropdownSearchDecoration:
                          InputDecoration(labelText: "Bank Name"),
                      mode: Mode.BOTTOM_SHEET,
                      onChanged: (value) =>
                          controller.CodeBank.value = value?.code,
                      dropdownBuilder: (context, selectedItem) => Text(
                        selectedItem?.name ?? "Choose Bank...",
                        style: GoogleFonts.montserrat(),
                      ),
                      popupItemBuilder: (context, item, isSelected) => ListTile(
                        title: Text(item.name),
                      ),
                      dropdownSearchBaseStyle: GoogleFonts.montserrat(),
                      onFind: (text) async {
                        var res = await controller.getBankList;
                        if (res.length > 0) {
                          List<BankData> getBankList = [];
                          res.forEach((element) {
                            getBankList.add(BankData(
                                code: element.code, name: element.name));
                          });
                          return getBankList;
                        } else {
                          return [];
                        }
                      },
                    )
                  : Center(child: CircularProgressIndicator())),
              SizedBox(height: 35),

              //Switch Button
              Text("Account status", style: GoogleFonts.montserrat()),

              Obx(() => Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: controller.isDebit.value == false
                                    ? Colors.blue[600]
                                    : Colors.white),
                            onPressed: () {
                              controller.isDebit.value = false;
                              controller.AmountC.text = "";
                              controller.dateC.text = "";
                            },
                            child: Text("CREDIT",
                                style: GoogleFonts.montserrat(
                                    color: controller.isDebit.value == false
                                        ? Colors.white
                                        : Colors.grey[400]))),
                        SizedBox(width: 20),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: controller.isDebit.value == true
                                    ? Colors.blue[600]
                                    : Colors.white),
                            onPressed: () {
                              controller.isDebit.value = true;
                              controller.AmountC.text = "";
                            },
                            child: Text("DEBIT",
                                style: GoogleFonts.montserrat(
                                    color: controller.isDebit.value == true
                                        ? Colors.white
                                        : Colors.grey[400]))),
                      ],
                    ),
                  )),
              SizedBox(height: 20),

              Obx(
                () => controller.isDebit.isTrue
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InputFormNumber(
                              Title: "Expected Amount",
                              HintText: "Type expected amount",
                              Controller: controller.AmountC),
                          Text("Expected date",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 5),
                          TextField(
                            controller: controller.dateC,
                            autocorrect: false,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(9),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(9),
                              ),
                              hintText: "Select date",
                              filled: true,
                              icon: Icon(Icons.calendar_today_outlined),
                              fillColor: Colors.blue[50],
                            ),
                            style: GoogleFonts.montserrat(),
                            onTap: () {
                              controller.chooseDate();
                            },
                          ),
                        ],
                      )
                    : InputFormNumber(
                        Title: "Amount",
                        HintText: "Type amount",
                        Controller: controller.AmountC),
              ),
              SizedBox(height: 15),
              InputForm(
                  Title: "Notes",
                  HintText: "Enter notes",
                  Controller: controller.NotesC),

              SizedBox(height: 25),

              ///Button
              Obx(() => SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (controller.isLoading.isFalse) {
                          await controller.SubmitBank();
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
      ),
    );
  }
}
