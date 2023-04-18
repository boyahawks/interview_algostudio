import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:test_algostudio/components/global/buttom_sheet.dart';
import 'package:test_algostudio/components/image/image_model.dart';
import 'package:test_algostudio/utils/api.dart';
import 'package:test_algostudio/utils/app_data.dart';
import 'package:test_algostudio/utils/toast.dart';
import 'package:test_algostudio/utils/utility.dart';
import 'package:test_algostudio/widget/text_form_field_group.dart';
import 'package:test_algostudio/widget/text_label.dart';
import 'package:flutter_share_me/flutter_share_me.dart';

class ImageController extends GetxController {
  ScreenshotController screenshotController = ScreenshotController();

  var dataStorageImage = <ImageModel>[].obs;

  var judul = TextEditingController().obs;
  var deskripsi = TextEditingController().obs;

  var imageSelected = "".obs;
  var judulSelected = "".obs;
  var deskripsiSelected = "".obs;
  var namaGambar = "".obs;

  var statusShare = false.obs;

  var idDataTerpilih = "".obs;

  void startLoad(idSelected) {
    idDataTerpilih.value = idSelected;
    idDataTerpilih.refresh();
    getData(idSelected);
  }

  void getData(idSelected) async {
    if (AppData.dataImage != null) {
      dataStorageImage.value = AppData.dataImage!;
      dataStorageImage.refresh();
      Future<List> prosesCheck = checkingImage(idSelected);
      List hasilCheck = await prosesCheck;
      if (hasilCheck.isNotEmpty) {
        idDataTerpilih.value = hasilCheck[0];
        imageSelected.value = hasilCheck[1];
        judulSelected.value = hasilCheck[2];
        deskripsiSelected.value = hasilCheck[3];
        idDataTerpilih.refresh();
        imageSelected.refresh();
        judulSelected.refresh();
        deskripsiSelected.refresh();
      }
    } else {
      print("data null");
    }
  }

  Future<List> checkingImage(idSelected) {
    String idTampung = "";
    String base64 = "";
    String judulPilih = "";
    String deskripsiPilih = "";
    for (var element in dataStorageImage) {
      if (element.idImage == idSelected) {
        idTampung = element.idImage!;
        base64 = element.image!;
        judulPilih = element.judul!;
        deskripsiPilih = element.deskripsi!;
      }
    }
    return Future.value([idTampung, base64, judulPilih, deskripsiPilih]);
  }

  void validasiBack() {
    if (statusShare.value) {
      statusShare.value = false;
      statusShare.refresh();
    } else {
      Get.back();
    }
  }

  void aksiGetPickture() async {
    final getFoto = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 100,
        maxHeight: 250,
        maxWidth: 250);
    if (getFoto == null) {
      UtilsAlert.showToast("Gagal mengambil gambar");
    } else {
      var file = File(getFoto.path);
      var base64fotoUser = base64Encode(file.readAsBytesSync());
      imageSelected.value = base64fotoUser;
      imageSelected.refresh();
      namaGambar.value =
          "${DateFormat("ddMMyyyyHHss").format(DateTime.now())}.png";
      namaGambar.refresh();
    }
  }

  void addTitleAndDeskripsi() {
    ButtonSheetController().validasiButtonSheet("Tambah Judul and Deskripsi",
        screenTitleDeskripsi(), "add_title_deskripsi", "Tambah", () {
      if (judul.value.text == "" || deskripsi.value.text == "") {
        UtilsAlert.showToast("Lengkapi form terlebih dahulu");
      } else {
        judulSelected.value = judul.value.text;
        deskripsiSelected.value = deskripsi.value.text;
        judulSelected.refresh();
        deskripsiSelected.refresh();
        judul.value.text = "";
        deskripsi.value.text = "";
        Get.back();
      }
    });
  }

  Widget screenTitleDeskripsi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextLabel(
          text: "Judul",
          weigh: FontWeight.bold,
        ),
        SizedBox(
          height: Utility.verySmall,
        ),
        TextFieldMain(
            statusIconLeft: false, controller: judul.value, onTap: () {}),
        SizedBox(
          height: Utility.medium,
        ),
        TextLabel(
          text: "Deskripsi",
          weigh: FontWeight.bold,
        ),
        SizedBox(
          height: Utility.verySmall,
        ),
        TextFieldMultiline(
          statusIconLeft: false,
          maxLength: 255,
          controller: deskripsi.value,
        )
      ],
    );
  }

  void simpanChange() {
    List validasiId = dataStorageImage
        .where((element) => element.idImage == idDataTerpilih.value)
        .toList();
    if (validasiId.isEmpty) {
      dataStorageImage.add(ImageModel(
        idImage: idDataTerpilih.value,
        image: imageSelected.value,
        judul: judulSelected.value,
        deskripsi: deskripsiSelected.value,
      ));
      AppData.dataImage = dataStorageImage;
      statusShare.value = true;
      statusShare.refresh();
      startLoad(idDataTerpilih.value);
    } else {
      statusShare.value = true;
      statusShare.refresh();
    }
    UtilsAlert.showToast("Data tersimpan");
  }

  void shareToMedsos() {
    screenshotController
        .capture(delay: Duration(milliseconds: 10))
        .then((capturedImage) async {
      final directory = await getTemporaryDirectory();
      final getFile = File(
          '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg');
      await getFile.writeAsBytes(capturedImage!);
      String filePath = getFile.path;
      // await FlutterShareMe().shareToInstagram(
      //   filePath: filePath,
      // );
      // String msg =
      //     'Flutter share is great!!\n Check out full example at https://pub.dev/packages/flutter_share_me';
      // String url = 'https://pub.dev/packages/flutter_share_me';

      // await FlutterShareMe().shareToFacebook(msg: msg, url: url);

      final box = Get.context!.findRenderObject() as RenderBox?;
      await Share.shareFiles([filePath],
          text: "MimGenerator",
          subject: "Generate Meme",
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    }).catchError((onError) {
      print(onError);
    });
  }
}
