import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:test_algostudio/utils/app_data.dart';

class Api {
  static var basicUrl = "https://api.imgflip.com/";

  static Future connectionApi(
      String typeConnect, valFormData, String url) async {
    var getUrl = basicUrl + url;

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    if (typeConnect == "post" ||
        typeConnect == "patch" ||
        typeConnect == "delete") {
      try {
        var url = Uri.parse(getUrl);
        if (typeConnect == "post") {
          var response =
              await post(url, body: jsonEncode(valFormData), headers: headers);
          return response;
        } else if (typeConnect == "patch") {
          var response =
              await patch(url, body: jsonEncode(valFormData), headers: headers);
          return response;
        } else if (typeConnect == "delete") {
          var response = await delete(url,
              body: jsonEncode(valFormData), headers: headers);
          return response;
        }
      } on SocketException catch (e) {
        print(e);
        return false;
      }
    } else {
      try {
        var url = Uri.parse(getUrl);
        var response = await get(url, headers: headers);
        return response;
      } on SocketException catch (e) {
        return false;
      }
    }
  }
}
