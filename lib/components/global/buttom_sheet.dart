import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_algostudio/utils/utility.dart';
import 'package:test_algostudio/widget/button.dart';
import 'package:iconsax/iconsax.dart';

class ButtonSheetController extends GetxController {
  void validasiButtonSheet(String pesan1, Widget content, String type,
      String acc, Function() onTap) {
    showModalBottomSheet(
      context: Get.context!,
      isDismissible: false,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0),
        ),
      ),
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: Utility.large + Utility.large,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 90,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$pesan1",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 10,
                        child: InkWell(
                          onTap: () => Navigator.pop(Get.context!),
                          child: Icon(
                            Iconsax.close_circle,
                            color: Colors.red,
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: Utility.small,
              ),
              const Divider(),
              SizedBox(
                height: Utility.normal,
              ),
              type == "show_keterangan"
                  ? Flexible(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 16.0,
                              right: 16.0,
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: content,
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: content,
                      ),
                    ),
              SizedBox(
                height: Utility.medium,
              ),
              type == "validasi_lanjutkan_orderpenjualan" ||
                      type == "cetak_faktur_penjualan" ||
                      type == "show_keterangan"
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () => Get.back(),
                              child: Button3(
                                textBtn: "Cancel",
                                colorSideborder: Utility.primaryDefault,
                                overlayColor: Utility.primaryLight100,
                                colorText: Utility.primaryDefault,
                                onTap: () {
                                  Get.back();
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 3),
                              child: Button1(
                                textBtn: acc,
                                style: 2,
                                colorBtn: Utility.primaryDefault,
                                onTap: () {
                                  if (onTap != null) onTap();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        );
      },
    );
  }
}
