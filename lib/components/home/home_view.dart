import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:test_algostudio/components/home/home_controller.dart';
import 'package:test_algostudio/components/image/image_view.dart';
import 'package:test_algostudio/utils/utility.dart';
import 'package:test_algostudio/widget/button.dart';
import 'package:test_algostudio/widget/card_custom.dart';
import 'package:test_algostudio/widget/main_scaffold.dart';
import 'package:test_algostudio/widget/search.dart';
import 'package:test_algostudio/widget/text_form_field_group.dart';
import 'package:test_algostudio/widget/text_label.dart';
import 'package:iconsax/iconsax.dart';
import 'package:test_algostudio/utils/utility.dart';
import 'package:test_algostudio/widget/button.dart';
import 'package:test_algostudio/widget/text_label.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var controller = Get.put(HomeController());

  @override
  void initState() {
    controller.startLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      type: "default",
      returnOnWillpop: true,
      backFunction: () {},
      content: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 30),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: TextLabel(
                  text: "MimGenerator",
                  weigh: FontWeight.bold,
                  size: Utility.medium,
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(
                height: Utility.medium,
              ),
              Flexible(child: listDataImage())
            ],
          ),
        ),
      ),
    );
  }

  Widget listDataImage() {
    return controller.loadData.value && controller.listData.isEmpty
        ? Align(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Utility.primaryDefault,
                ),
                SizedBox(
                  height: Utility.verySmall,
                ),
                TextLabel(
                  text: "Loading Data...",
                  weigh: FontWeight.bold,
                )
              ],
            ),
          )
        : !controller.loadData.value && controller.listData.isEmpty
            ? Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextLabel(
                      text: "Tidak ada data",
                      weigh: FontWeight.bold,
                    )
                  ],
                ),
              )
            : SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                header: MaterialClassicHeader(
                  color: Utility.primaryDefault,
                ),
                footer: ClassicFooter(
                  loadingText: "Load More...",
                  noDataText: "Finished loading data",
                  loadStyle: LoadStyle.ShowWhenLoading,
                  loadingIcon: Icon(Iconsax.more),
                ),
                onRefresh: () async {
                  await Future.delayed(Duration(seconds: 1));
                  controller.page.value = 15;
                  controller.page.refresh();
                  controller.startLoad();
                  controller.refreshController.refreshCompleted();
                },
                onLoading: () async {
                  await Future.delayed(Duration(seconds: 1));
                  setState(() {
                    controller.page.value = controller.page.value + 15;
                    controller.refreshController.loadComplete();
                  });
                },
                controller: controller.refreshController,
                child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.all(0),
                    itemCount:
                        controller.listData.length > controller.page.value
                            ? controller.page.value
                            : controller.listData.length,
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.65,
                    ),
                    itemBuilder: (context, index) {
                      var id = controller.listData[index].id;
                      var urlImage = controller.listData[index].url;
                      var lebar = controller.listData[index].width;
                      var tinggi = controller.listData[index].height;
                      return InkWell(
                        onTap: () => Get.to(
                            ImageView(
                              idSelected: id!,
                              urlImage: urlImage,
                            ),
                            duration: Duration(milliseconds: 300),
                            transition: Transition.rightToLeftWithFade),
                        child: Image.network(
                          urlImage!,
                          width: lebar,
                          height: tinggi,
                        ),
                      );
                    }));
  }
}
