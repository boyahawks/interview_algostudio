import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:screenshot/screenshot.dart';
import 'package:test_algostudio/components/home/home_controller.dart';
import 'package:test_algostudio/components/image/image_controller.dart';
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

class ImageView extends StatefulWidget {
  String idSelected;
  String urlImage;
  ImageView({Key? key, required this.idSelected, required this.urlImage})
      : super(key: key);
  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  var controller = Get.put(ImageController());

  @override
  void initState() {
    controller.startLoad(widget.idSelected);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      type: "appbar",
      returnOnWillpop: true,
      backFunction: () => controller.validasiBack(),
      ontapAppbar: () => controller.validasiBack(),
      appbarTitle: "MimGenerator",
      content: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 30),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: controller.statusShare.value ? 75 : 85,
                child: Screenshot(
                  controller: controller.screenshotController,
                  child: Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                alignment: Alignment.center,
                                image: NetworkImage(widget.urlImage),
                                fit: BoxFit.cover)),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        color: controller.imageSelected.value == "" &&
                                controller.judulSelected.value == "" &&
                                controller.deskripsiSelected.value == ""
                            ? Colors.transparent
                            : Color.fromARGB(179, 227, 227, 227),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 20,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        child: controller.imageSelected.value !=
                                                ""
                                            ? Align(
                                                alignment: Alignment.topCenter,
                                                child: SizedBox(
                                                  child: Image.memory(
                                                    base64Decode(controller
                                                        .imageSelected.value),
                                                    fit: BoxFit
                                                        .cover, // adjust the fit as per your requirements
                                                  ),
                                                ))
                                            : const SizedBox()),
                                    Expanded(
                                        child: controller.judulSelected.value !=
                                                ""
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 6.0),
                                                child: TextLabel(
                                                    text: controller
                                                        .judulSelected.value),
                                              )
                                            : const SizedBox())
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 80,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: controller.deskripsiSelected.value != ""
                                    ? TextLabel(
                                        text:
                                            controller.deskripsiSelected.value)
                                    : const SizedBox(),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: controller.statusShare.value ? 25 : 15,
                child: controller.statusShare.value == true
                    ? screenShare()
                    : controller.imageSelected.value == "" ||
                            controller.judulSelected.value == "" ||
                            controller.deskripsiSelected.value == ""
                        ? addChange()
                        : simpanAndShare(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget addChange() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 3.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextLabel(
                    text: "Add Logo",
                    weigh: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                  SizedBox(
                    height: Utility.medium,
                  ),
                  controller.imageSelected.value == ""
                      ? InkWell(
                          onTap: () => controller.aksiGetPickture(),
                          child: const Icon(
                            Iconsax.image,
                            size: 30,
                          ),
                        )
                      : TextLabel(text: controller.namaGambar.value)
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 3.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextLabel(
                    text: "Add Text",
                    weigh: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                  SizedBox(
                    height: Utility.medium,
                  ),
                  InkWell(
                    onTap: () => controller.addTitleAndDeskripsi(),
                    child: const Icon(
                      Iconsax.note_1,
                      size: 30,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget simpanAndShare() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 3.0),
              child: Button1(
                textBtn: "Simpan",
                colorBtn: Utility.primaryDefault,
                colorText: Utility.baseColor2,
                onTap: () => controller.simpanChange(),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 3.0),
              child: Button1(
                textBtn: "Share",
                colorBtn: Utility.primaryDefault,
                colorText: Utility.baseColor2,
                onTap: () {
                  setState(() {
                    controller.statusShare.value = true;
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget screenShare() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Utility.normal,
          ),
          Button1(
            textBtn: "Share Medsos",
            colorBtn: Utility.primaryDefault,
            colorText: Utility.baseColor2,
            onTap: () => controller.shareToMedsos(),
          ),
        ],
      ),
    );
  }
}
