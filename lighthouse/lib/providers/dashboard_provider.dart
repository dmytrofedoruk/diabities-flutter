import 'package:flutter/material.dart';

class DashBoardProvider with ChangeNotifier {
  int selectedIndex = 0;

  void selectTab(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
