import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myfinnapp/app/modules/home/utils/CardBank.dart';
import 'package:myfinnapp/app/modules/home/utils/CardListHistory.dart';
import 'package:myfinnapp/app/modules/home/utils/CardWelcome.dart';
import 'package:myfinnapp/app/routes/app_pages.dart';
import 'package:myfinnapp/app/utils/BottomBar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../controllers/home_controller.dart';
import '../../../utils/color.dart' as color;

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _controller = PageController();

    return Scaffold(
      backgroundColor: color.AppColor.PageBackground,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              backgroundColor: color.AppColor.PageBackground,
              expandedHeight: size.height * 0.5,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.only(top: 40, right: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              GetStorage().erase();
                              Get.offAllNamed(Routes.START_PAGE);
                            },
                            child: Icon(
                              Icons.square,
                              size: 40,
                              color: Colors.black,
                            ),
                          ),
                          Center(
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.blue[300],
                              child: Obx(() => CircleAvatar(
                                  radius: 17,
                                  backgroundImage: NetworkImage(controller
                                          .UserDatas.isNotEmpty
                                      ? controller.UserDatas[0].photo.isNotEmpty
                                          ? controller.UserDatas[0].photo
                                          : "https://ui-avatars.com/api/?bold=true&background=1E88E&color=fff&name=${controller.UserDatas[0].email}"
                                      : "https://ui-avatars.com/api/?bold=true&background=1E88E&color=fff&name=MY"))),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              bottom: PreferredSize(
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ///Text My Card
                          Text(
                            "My Cards",
                            style: GoogleFonts.montserrat(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),

                          /// button Add
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(Routes.CREATE_BANK_ACCOUNT);
                              },
                              child: Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.blue[600],
                                  borderRadius: BorderRadius.circular(3),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(1, 3),
                                        blurRadius: 5,
                                        color: Colors.black.withOpacity(0.2))
                                  ],
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 15),
                      Obx(() => controller.getBankList.isEmpty
                          ?

                          /// Card Wellcome MyFinnApps
                          CardWelcome()
                          :

                          /// Card Bank Account
                          SizedBox(
                              child: Container(
                                height: size.height * 0.25,
                                child: PageView.builder(
                                    controller: _controller,
                                    // onPageChanged: (val) =>
                                    //     controller.getResponse(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: controller.getBankList.length,
                                    itemBuilder: (context, index) {
                                      controller.idBankAccount.value =
                                          controller.getBankList[index].id;
                                      controller.getExpenseMonth();
                                      controller.getTransaction();
                                      var colors = controller
                                          .getBankList[index].bank.color;
                                      var colorresult;
                                      if (colors != "null") {
                                        colors = controller
                                            .getBankList[index].bank.color;
                                      } else {
                                        colors = '0x00000;0x2c3e50';
                                      }
                                      colorresult = colors.split(';');
                                      return Obx(() => CardBank(
                                            TotalMonthExpenses: controller
                                                .TotalMonthExpenses.value,
                                            NamaBank: controller
                                                .getBankList[index].bank.name,
                                            Amount: controller
                                                .getBankList[index].amount
                                                .toString(),
                                            Type: controller.getBankList[index]
                                                .userAccount.accountName
                                                .toString(),
                                            Note: controller
                                                .getBankList[index].notes,
                                            Color1: int.parse(colorresult[0]),
                                            Color2: int.parse(colorresult[1]),
                                            isDebit: controller
                                                .getBankList[index].isDebit,
                                            ExpectedDate: controller
                                                .getBankList[index].expiredDate,
                                          ));
                                    }),
                              ),
                            )),
                      Obx(() => controller.getBankList.isNotEmpty
                          ? SmoothPageIndicator(
                              controller: _controller,
                              count: controller.getBankList.length,
                              effect: SwapEffect(
                                activeDotColor: Colors.blue.shade300,
                                dotColor: Colors.blue.shade100,
                                dotHeight: 5,
                                dotWidth: 10,
                                spacing: 5,
                              ),
                            )
                          : Text("")),
                      SizedBox(height: 5),

                      /// List Transaction Text
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "List Transaction",
                          style: GoogleFonts.montserrat(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  preferredSize: Size.fromHeight(size.height * 0.33)),
            ),

            // / list Transaction

            Obx(() => controller.getTransactionsList.isNotEmpty
                ? SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                    return CardListHistory(
                      // Title: "Notes",
                      SubTitle: controller.getTransactionsList[index].notes,
                      Price: controller.getTransactionsList[index].amount
                          .toString(),
                      Date: controller.getTransactionsList[index].createdDate,
                      isDebit: controller
                          .getTransactionsList[index].bankAccount.isDebit,
                    );
                  }, childCount: controller.getTransactionsList.length))
                : SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 70),
                      child: Center(
                          child: Text("Transaction Not Found",
                              style: GoogleFonts.montserrat())),
                    );
                  }, childCount: 1)))
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
