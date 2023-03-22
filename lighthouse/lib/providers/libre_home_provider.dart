// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lighthouse/dummyjson.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

import '../helpers/AppConstants.dart';
import '../helpers/Utils.dart';
import '../models/gluco_History_model.dart';
import '../services/libre_auth_service.dart';
import '../views/auth/login/loginScreen.dart';

class LibreHomeProvider with ChangeNotifier {
  SharedPreferences sharedPreferences;
  LibreHomeProvider(this.sharedPreferences);

  String glucoHistory = "";
  GlucoHistoryModel? glucoHistoryModel;

  bool isLoading = false;
  showOrHideLoader(bool isShow) {
    if (isShow) {
      isLoading = true;
    } else {
      isLoading = false;
    }

    notifyListeners();
  }

  Future<void> logout(BuildContext context) async {
    sharedPreferences.setString(AppConstants.libreTokenKey, "");
    sharedPreferences.setString(AppConstants.librePatientId, "");
    glucoHistoryModel = null;
    notifyListeners();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen()), (Route<dynamic> route) => false);
  }

  Future<bool> checkLibreTokenExist() async {
    var libretoken = sharedPreferences.getString(
      AppConstants.libreTokenKey,
    );
    if (libretoken != null && libretoken.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  var formmat = DateFormat('MMM dd');
  Future<void> libreGetData({
    required BuildContext context,
  }) async {
    glucoHistoryModel = null;
    graphDataPoints.clear();

    showOrHideLoader(true);

    var libretoken = sharedPreferences.getString(
      AppConstants.libreTokenKey,
    );
    var librepatientId = sharedPreferences.getString(
      AppConstants.librePatientId,
    );

    var result = await LibreAuthService.librGetMeasurement(token: libretoken.toString(), patientId: librepatientId ?? "");
    // var result = jsonDecode(dummyjson);

    if (result != null) {
      if (result.containsKey("data")) {
        glucoHistory = result.toString();
        glucoHistoryModel = GlucoHistoryModel.fromMap(result);
        // periodModel = glucoHistoryModel!.data!.periods!.first;
        if (glucoHistoryModel!.data!.graphData != null && glucoHistoryModel!.data!.graphData!.isNotEmpty) {
          for (var i = 0; i < glucoHistoryModel!.data!.graphData!.length; i++) {
            var grphData = glucoHistoryModel!.data!.graphData![i];
            // var startDate = block.percentile5;
            graphDataPoints.add(_ChartSalesData(sales: double.parse(grphData.value.toString()), month: grphData.timestamp.toString()));
          }
          // for (var i = 0; i < glucoHistoryModel!.data!.periods!.first.data!.blocks!.first!.length; i++) {
          //   var block = glucoHistoryModel!.data!.periods!.first.data!.blocks!.first[i];
          //   // var startDate = block.percentile5;
          //   persontile25Points.add(_ChartSalesData(sales: double.parse(block.percentile25.toString()), month: block.time.toString()));
          // }
          // for (var i = 0; i < glucoHistoryModel!.data!.periods!.first.data!.blocks!.first!.length; i++) {
          //   var block = glucoHistoryModel!.data!.periods!.first.data!.blocks!.first[i];
          //   // var startDate = block.percentile5;
          //   persontile50Points.add(_ChartSalesData(sales: double.parse(block.percentile50.toString()), month: block.time.toString()));
          // }
          // for (var i = 0; i < glucoHistoryModel!.data!.periods!.first.data!.blocks!.first!.length; i++) {
          //   var block = glucoHistoryModel!.data!.periods!.first.data!.blocks!.first[i];
          //   // var startDate = block.percentile5;
          //   persontile75Points.add(_ChartSalesData(sales: double.parse(block.percentile75.toString()), month: block.time.toString()));
          // }
          // for (var i = 0; i < glucoHistoryModel!.data!.periods!.first.data!.blocks!.first!.length; i++) {
          //   var block = glucoHistoryModel!.data!.periods!.first.data!.blocks!.first[i];
          //   // var startDate = block.percentile5;
          //   persontile95Points.add(_ChartSalesData(sales: double.parse(block.percentile95.toString()), month: block.time.toString()));
          // }
        }
      } else {
        Utils.errorSnackBar(context, "invalid or expired jwt");
        sharedPreferences.setString(AppConstants.libreTokenKey, "");
      }
    } else {
      Utils.errorSnackBar(context, "Something went wrong");
      sharedPreferences.setString(AppConstants.libreTokenKey, "");
    }
    showOrHideLoader(false);
    notifyListeners();
  }

  List<_ChartSalesData> graphDataPoints = [];

  List<LineSeries<_ChartSalesData, String>> getDefaultData() {
    // final List<_ChartSalesData> chartData = <_ChartSalesData>[
    //   _ChartSalesData("2005", 1000.0),
    //   _ChartSalesData("2006", 2000.0),
    //   _ChartSalesData("2007", 2000.0),
    // ];
    return <LineSeries<_ChartSalesData, String>>[
      LineSeries<_ChartSalesData, String>(
          dataSource: graphDataPoints,
          xValueMapper: (_ChartSalesData sales, _) => sales.month,
          yValueMapper: (_ChartSalesData sales, _) => sales.sales,
          width: 2,
          name: "Graph Data",
          markerSettings:
              MarkerSettings(isVisible: true, height: 4, width: 4, shape: DataMarkerType.circle, borderWidth: 3, borderColor: Colors.blue),
          dataLabelSettings: DataLabelSettings(isVisible: true, labelPosition: ChartDataLabelPosition.outside))
      //   LineSeries<_ChartSalesData, String>(
      //       dataSource: persontile25Points,
      //       xValueMapper: (_ChartSalesData sales, _) => sales.month,
      //       yValueMapper: (_ChartSalesData sales, _) => sales.sales,
      //       width: 2,
      //       name: "Percentile25",
      //       markerSettings:
      //           MarkerSettings(isVisible: true, height: 4, width: 4, shape: DataMarkerType.circle, borderWidth: 3, borderColor: Colors.brown),
      //       dataLabelSettings: DataLabelSettings(isVisible: true, labelPosition: ChartDataLabelPosition.outside)),
      //   LineSeries<_ChartSalesData, String>(
      //       dataSource: persontile50Points,
      //       xValueMapper: (_ChartSalesData sales, _) => sales.month,
      //       yValueMapper: (_ChartSalesData sales, _) => sales.sales,
      //       width: 2,
      //       name: "Percentile50",
      //       markerSettings:
      //           MarkerSettings(isVisible: true, height: 4, width: 4, shape: DataMarkerType.circle, borderWidth: 3, borderColor: Colors.pink),
      //       dataLabelSettings: DataLabelSettings(isVisible: true, labelPosition: ChartDataLabelPosition.outside)),
      //   LineSeries<_ChartSalesData, String>(
      //       dataSource: persontile75Points,
      //       xValueMapper: (_ChartSalesData sales, _) => sales.month,
      //       yValueMapper: (_ChartSalesData sales, _) => sales.sales,
      //       width: 2,
      //       name: "Percentile75",
      //       markerSettings: MarkerSettings(
      //           isVisible: true, height: 4, width: 4, shape: DataMarkerType.circle, borderWidth: 3, borderColor: Color.fromARGB(255, 151, 131, 94)),
      //       dataLabelSettings: DataLabelSettings(isVisible: true, labelPosition: ChartDataLabelPosition.outside)),
      //   LineSeries<_ChartSalesData, String>(
      //       dataSource: persontile95Points,
      //       xValueMapper: (_ChartSalesData sales, _) => sales.month,
      //       yValueMapper: (_ChartSalesData sales, _) => sales.sales,
      //       width: 2,
      //       name: "Percentile95",
      //       markerSettings:
      //           MarkerSettings(isVisible: true, height: 4, width: 4, shape: DataMarkerType.circle, borderWidth: 3, borderColor: Colors.green[800]),
      //       dataLabelSettings: DataLabelSettings(isVisible: true, labelPosition: ChartDataLabelPosition.outside)),
    ];
  }
}

class _ChartSalesData {
  _ChartSalesData({required this.month, required this.sales});

  final String month;
  final double sales;
}
