import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:test_algostudio/utils/utility.dart';

class UtilsAlert {
  static showToast(message) {
    Fluttertoast.showToast(
        msg: message,
        timeInSecForIosWeb: 5,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 12);
  }

  static showLoadingIndicator(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Padding(
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Utility.primaryDefault,
                          ),
                          padding: EdgeInsets.all(8)),
                      Padding(
                          child: Text(
                            'Tunggu Sebentar …',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          padding: EdgeInsets.all(8))
                    ],
                  )
                ]));
      },
    );
  }

  static loadingSimpanData(BuildContext context, text) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            content: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 20,
                        child: Padding(
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              color: Utility.primaryDefault,
                            ),
                            padding: EdgeInsets.all(8)),
                      ),
                      Expanded(
                        flex: 80,
                        child: Padding(
                            child: Text(
                              text,
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                            padding: EdgeInsets.all(8)),
                      )
                    ],
                  )
                ]));
      },
    );
  }
}
