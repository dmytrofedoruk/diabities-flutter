// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lighthouse/models/link_button_model.dart';
import 'package:lighthouse/models/token_model.dart';
import 'package:lighthouse/providers/homeProvider.dart';
import 'package:lighthouse/services/auth_service.dart';
import 'package:lighthouse/views/home/homeScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/AppConstants.dart';
import '../helpers/Utils.dart';

class AuthProvider with ChangeNotifier {
  AuthProvider(this.sharedPreferences);
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
    if (newtokensModel != null) {
      tokensModel = newtokensModel;
      Navigator.pop(context);
      await sharedPreferences.setString(AppConstants.tokenKey, newtokensModel.accessToken!);
      await sharedPreferences.setString(AppConstants.refreshtokenKey, newtokensModel.refreshToken!);
      var provider = Provider.of<HomeProvider>(context, listen: false);
      Provider.of<HomeProvider>(context, listen: false);
      provider.pressLinkButton(context).then((value) => provider.getApplicationKeyOrUserName(context));

      notifyListeners();
    }
  }
}
