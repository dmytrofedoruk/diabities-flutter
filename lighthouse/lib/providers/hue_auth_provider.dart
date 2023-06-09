// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lighthouse/models/link_button_model.dart';
import 'package:lighthouse/models/token_model.dart';
import 'package:lighthouse/providers/hueHomeProvider.dart';
import 'package:lighthouse/services/hue_auth_service.dart';
import 'package:lighthouse/views/hue_home/hue_homeScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/AppConstants.dart';
import '../helpers/Utils.dart';

class HueAuthProvider with ChangeNotifier {
  HueAuthProvider(this.sharedPreferences);
  TokensModel? tokensModel;
  bool isLoading = false;
  final SharedPreferences sharedPreferences;

  showOrHideLoader(bool isShow) {
    if (isShow) {
      isLoading = true;
    } else {
      isLoading = false;
    }

    notifyListeners();
  }

  accessTokenChanged(TokensModel? newtokensModel, BuildContext context) async {
    log("access token ch");
    if (newtokensModel != null) {
      tokensModel = newtokensModel;
      Navigator.pop(context);
      await sharedPreferences.setString(AppConstants.HuetokenKey, newtokensModel.accessToken!);
      await sharedPreferences.setString(AppConstants.refreshtokenKey, newtokensModel.refreshToken!);
      var provider = Provider.of<HueProvider>(context, listen: false);
      Provider.of<HueProvider>(context, listen: false);
      await provider.pressLinkButton(context).then((value) async {
        log(value.toString());
        if (value) {
          log("link button pressed");
          await provider.getApplicationKeyOrUserName(context);
        } else {
          Utils.toast("The bridge seems to be offline.");
        }
      });

      notifyListeners();
    } else {
      log("access token changed");
    }
  }
}
