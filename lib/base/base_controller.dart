// ignore_for_file: file_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:practicaltest/app/global.dart' as global;
import 'package:practicaltest/app/service/network_service.dart';

class BaseController extends GetxController {
  NetworkController networkController = Get.find<NetworkController>();

  //Function errorLog print error log (only debug mode)
  errorLog(String screenName, String methodName, String err) {
    log("Exception - $methodName in $screenName :- $err ");
  }

  unFocusOverlay() => FocusManager.instance.primaryFocus?.unfocus();

  //Funtion hideLoader remove loader from the context
  hideLoader(BuildContext context) {
    try {
      if (context.loaderOverlay.visible) {
        context.loaderOverlay.hide();
      }
    } catch (err) {
      errorLog("Base", "hideLoader", err.toString());
    }
  }

  Future<bool> checkNetwork(context) async {
    await networkController.checkNetworkOnce();
    if (networkController.connectionStatus.value) {
      return true;
    } else {
      return false;
    }
  }

  showLoader(BuildContext context) => context.loaderOverlay.show();

  //Function showsnackbar use to show snackbar
  //type = 1 :- success
  //type = 2 :- warning
  //type = 3 :- error
  showSnackBar({
    String? title,
    required String message,
    int? type = 3,
  }) {
    try {
      IconData? icon;
      Color? color;

      //assign color and icon as per type
      switch (type) {
        case 1:
          icon = Icons.done_rounded;
          color = Colors.green;
          break;
        case 2:
          icon = Icons.warning;
          color = Colors.orange;
          break;
        case 3:
          icon = Icons.error;
          color = Colors.red;
          break;
      }

      final SnackBar snackBar = SnackBar(
          content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(message),
          Icon(
            icon,
            color: color,
          )
        ],
      ));
      global.snackbarKey.currentState!.showSnackBar(snackBar);
    } catch (err) {
      errorLog("BaseController", "showSnackBar", err.toString());
    }
  }
}
