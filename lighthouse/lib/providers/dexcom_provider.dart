// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/AppConstants.dart';
import '../helpers/Utils.dart';
import '../services/dexcomService.dart';

class DexcomProvider with ChangeNotifier {
  SharedPreferences sharedPreferences;
  DexcomProvider(this.sharedPreferences);
  bool isLoading = false;
  String currentNightScoutUrl = "";
  showOrHideLoader(bool isShow) {
    if (isShow) {
      isLoading = true;
    } else {
      isLoading = false;
    }

    notifyListeners();
  }

  Future<void> addNightScoutUrl({required BuildContext context, required String url}) async {
    showOrHideLoader(true);
    String? userId = sharedPreferences.getString(AppConstants.applicationuserIdKey);

    var result = await DexcomService.addNightScoutUrlService(userId: userId ?? "", url: url);

    if (result != null) {
      Utils.successSnackBar(context, result["message"]);
    } else {
      log("error$result");
      Utils.errorSnackBar(context, result["message"]);
      showOrHideLoader(false);
    }

    showOrHideLoader(false);
  }

  Future<void> getNightScoutUrl({required BuildContext context}) async {
    showOrHideLoader(true);
    String? userId = sharedPreferences.getString(AppConstants.applicationuserIdKey);

    var result = await DexcomService.getNightScouturk(userId: userId ?? "");

    if (result != null) {
      currentNightScoutUrl = result["nightscoutUrl"];
    } else {
      log("error$result");
      Utils.errorSnackBar(context, result["message"]);
      showOrHideLoader(false);
    }

    showOrHideLoader(false);
  }
}
