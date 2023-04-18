import 'dart:convert';

import 'package:test_algostudio/components/image/image_model.dart';
import 'package:test_algostudio/utils/local_storage.dart';

class AppData {
  // SET

  // BOOL

  // STRING

  // LIST

  static set dataImage(List<ImageModel>? value) {
    if (value != null) {
      List<String> listString = value.map((e) => e.toJson()).toList();
      LocalStorage.saveToDisk('dataImage', listString);
    } else {
      LocalStorage.saveToDisk('dataImage', null);
    }
  }

  // GET

  // BOOL

  // STRING

  // LIST

  static List<ImageModel>? get dataImage {
    if (LocalStorage.getFromDisk('dataImage') != null) {
      List<String> listData = LocalStorage.getFromDisk('dataImage');
      return listData.map((e) => ImageModel.fromMap(jsonDecode(e))).toList();
    }
    return null;
  }

  // CLEAR ALL DATA

  static void clearAllData() =>
      LocalStorage.removeFromDisk(null, clearAll: true);
}
