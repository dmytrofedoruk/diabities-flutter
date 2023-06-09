// ignore_for_file: use_build_context_synchronously

import 'dart:collection';
import 'dart:developer';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:lighthouse/providers/hueHomeProvider.dart';
import 'package:lighthouse/views/auth/joining_screens/joinning_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../helpers/AppConstants.dart';
import '../helpers/Utils.dart';
import '../models/gluco_History_model.dart';
import '../models/nighscout_model.dart';
import '../services/dexcomService.dart';
import '../services/libre_auth_service.dart';

class LibreHomeProvider with ChangeNotifier {
  SharedPreferences sharedPreferences;
  LibreHomeProvider(this.sharedPreferences);

  String glucoHistory = "";
  GlucoHistoryModel? glucoHistoryModel;

  List<GraphDatum> graphListFromServer = [];

  List<ReadingDetails> graphListFromNighScout = [];

  String lastReadingTimestamp = '';
  String lastReadingValue = '';
  String minutesSinceLastReading = "";
  NightScoutModel? nightScoutmodel;

  bool lightSyncStatus = false;

  bool isLoading = false;
  showOrHideLoader(bool isShow) {
    if (isShow) {
      isLoading = true;
    } else {
      isLoading = false;
    }

    notifyListeners();
  }

  String? libretoken = "";
  String? librepatientId = "";
  late final WebViewController controller;

  Future<void> logout(BuildContext context) async {
    sharedPreferences.setString(AppConstants.ApplicationtokenKey, "");
    sharedPreferences.setString(AppConstants.libreTokenKey, "");
    sharedPreferences.setString(AppConstants.librePatientId, "");
    sharedPreferences.setString(AppConstants.HuetokenKey, "");
    sharedPreferences.setString(AppConstants.applicationuserIdKey, "");
    sharedPreferences.setString(AppConstants.userNameKey, "");
    sharedPreferences.setString(AppConstants.refreshtokenKey, "");
    glucoHistoryModel = null;
    graphListFromServer = [];
    Provider.of<HueProvider>(context, listen: false).isHueToken = false;

    notifyListeners();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const JoiningScreen()), (Route<dynamic> route) => false);
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

  Future<bool> checkNightScoutUrlExist() async {
    var nightScoutUrl = sharedPreferences.getString(
      AppConstants.nightScoutUrl,
    );
    if (nightScoutUrl != null && nightScoutUrl.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  var formmat = DateFormat('MMM dd');
  // Future<void> libreGetDataFromLibreServer({
  //   required BuildContext context,
  // }) async {
  //   glucoHistoryModel = null;
  //   graphDataPoints.clear();

  //   showOrHideLoader(true);

  //   var libretoken = sharedPreferences.getString(
  //     AppConstants.libreTokenKey,
  //   );
  //   var librepatientId = sharedPreferences.getString(
  //     AppConstants.librePatientId,
  //   );

  //   var result = await LibreAuthService.librGetMeasurement(token: libretoken.toString(), patientId: librepatientId ?? "");
  //   // var result = jsonDecode(dummyjson);

  //   if (result != null) {
  //     if (result.containsKey("data")) {
  //       glucoHistory = result.toString();
  //       glucoHistoryModel = GlucoHistoryModel.fromMap(result);
  //       // periodModel = glucoHistoryModel!.data!.periods!.first;
  //       if (glucoHistoryModel!.data!.graphData != null &&
  //           glucoHistoryModel!.data!.graphData != null &&
  //           glucoHistoryModel!.data!.graphData!.isNotEmpty) {
  //         sparchDataPoint.clear();
  //         // var min = glucoHistoryModel!.data!.graphData!.reduce((curr, next) => curr.value! < next.value! ? curr : next).value;
  //         // var max = glucoHistoryModel!.data!.graphData!.reduce((curr, next) => curr.value! > next.value! ? curr : next).value;
  //         // graphDataPoints.add(_ChartSalesData(
  //         //   sales: double.parse(glucoHistoryModel!.data!.graphData!.reduce((curr, next) => curr.value! < next.value! ? curr : next).value.toString()),
  //         //   month: glucoHistoryModel!.data!.graphData!.reduce((curr, next) => curr.value! < next.value! ? curr : next).timestamp.toString(),
  //         //   color:
  //         //   (min! >= 4.0)
  //         //       ? Colors.green
  //         //       : (min < 4.0)
  //         //           ? Colors.yellow
  //         //           : Colors.red,
  //         // ));
  //         // graphDataPoints.add(_ChartSalesData(
  //         //   sales: double.parse(glucoHistoryModel!.data!.graphData!.reduce((curr, next) => curr.value! > next.value! ? curr : next).value.toString()),
  //         //   month: glucoHistoryModel!.data!.graphData!.reduce((curr, next) => curr.value! > next.value! ? curr : next).timestamp.toString(),
  //         //   color: (max! <= 10.0)
  //         //       ? Colors.green
  //         //       : (max < 4.0)
  //         //           ? Colors.yellow
  //         //           : Colors.red,
  //         // ));

  //         // For loop for showing all the values
  //         for (var i = 0; i < glucoHistoryModel!.data!.graphData!.length; i++) {
  //           var grphData = glucoHistoryModel!.data!.graphData![i];
  //           List<String> dateTimeParts = grphData.timestamp!.split(" ");
  //           sparchDataPoint.add(grphData.value!);

  //           // var startDate = block.percentile5;
  //           graphDataPoints.add(
  //             _ChartSalesData(
  //                 sales: double.parse(grphData.value.toString()),
  //                 month: grphData.timestamp!.substring(grphData.timestamp!.indexOf(' ') + 1),
  //                 color: Color.fromRGBO(54, 169, 225, 1)

  //                 // grphData.value! >= 4 && grphData.value! <= 10 ? Colors.green : Colors.yellow
  //                 ),
  //           );
  //         }
  //         // for (var i = 0; i < glucoHistoryModel!.data!.periods!.first.data!.blocks!.first!.length; i++) {
  //         //   var block = glucoHistoryModel!.data!.periods!.first.data!.blocks!.first[i];
  //         //   // var startDate = block.percentile5;
  //         //   persontile25Points.add(_ChartSalesData(sales: double.parse(block.percentile25.toString()), month: block.time.toString()));
  //         // }
  //         // for (var i = 0; i < glucoHistoryModel!.data!.periods!.first.data!.blocks!.first!.length; i++) {
  //         //   var block = glucoHistoryModel!.data!.periods!.first.data!.blocks!.first[i];
  //         //   // var startDate = block.percentile5;
  //         //   persontile50Points.add(_ChartSalesData(sales: double.parse(block.percentile50.toString()), month: block.time.toString()));
  //         // }
  //         // for (var i = 0; i < glucoHistoryModel!.data!.periods!.first.data!.blocks!.first!.length; i++) {
  //         //   var block = glucoHistoryModel!.data!.periods!.first.data!.blocks!.first[i];
  //         //   // var startDate = block.percentile5;
  //         //   persontile75Points.add(_ChartSalesData(sales: double.parse(block.percentile75.toString()), month: block.time.toString()));
  //         // }
  //         // for (var i = 0; i < glucoHistoryModel!.data!.periods!.first.data!.blocks!.first!.length; i++) {
  //         //   var block = glucoHistoryModel!.data!.periods!.first.data!.blocks!.first[i];
  //         //   // var startDate = block.percentile5;
  //         //   persontile95Points.add(_ChartSalesData(sales: double.parse(block.percentile95.toString()), month: block.time.toString()));
  //         // }
  //       }
  //     } else {
  //       Utils.errorSnackBar(context, "invalid or expired jwt");
  //       sharedPreferences.setString(AppConstants.libreTokenKey, "");
  //     }
  //   } else {
  //     Utils.errorSnackBar(context, "Something went wrong");
  //     sharedPreferences.setString(AppConstants.libreTokenKey, "");
  //   }
  //   showOrHideLoader(false);
  //   notifyListeners();
  // }

  updateGraphDataAccordingtoHours(int count) {
    log(newgraphDataPoints.length.toString());
    graphDataPoints.clear();
    if (count <= newgraphDataPoints.length) {
      log("Count is normal");
      for (var i = 0; i < count; i++) {
        graphDataPoints.add(newgraphDataPoints[i]);
      }

      notifyListeners();
    } else {
      log("Count is not normal");
      for (var i = 0; i < newgraphDataPoints.length; i++) {
        graphDataPoints.add(newgraphDataPoints[i]);
      }
      notifyListeners();
    }
  }

  Future<void> getNightScoutdata({required BuildContext context}) async {
    showOrHideLoader(true);
    String? userId = sharedPreferences.getString(AppConstants.applicationuserIdKey);

    var result = await DexcomService.getNightScoutdataService(userId: userId ?? "");

    if (result != null) {
      nightScoutmodel = null;
      nightScoutmodel = NightScoutModel.fromMap(result);

      if (nightScoutmodel?.data != null) {
        graphListFromNighScout.clear();
        graphDataPoints.clear();
        newgraphDataPoints.clear();

        // final dataSet = HashSet<ReadingDetails>(
        //   // or LinkedHashSet
        //   equals: (a, b) => a.dateString!.hour == b.dateString!.hour,
        //   hashCode: (a) => a.dateString!.hour.hashCode,
        // )..addAll(nightScoutmodel!.data!);
        graphListFromNighScout = nightScoutmodel!.data!;
        // graphListFromNighScout = dataSet.toList();
        log(graphListFromNighScout.length.toString());
        // graphListFromNighScout.sort();
        notifyListeners();

        if (graphListFromNighScout.isEmpty) {
          Utils.errorSnackBar(context, "No graph data found");
        } else {
          lastReadingTimestamp = DateFormat.Hms().format(graphListFromNighScout.first.dateString ?? DateTime.now());
          lastReadingValue = (graphListFromNighScout.first.sgv! / 18).toStringAsFixed(2);
          var time = DateTime.now().difference(graphListFromNighScout.first.dateString!);
          minutesSinceLastReading = time.inMinutes.toStringAsFixed(2);

          // For loop for showing all the values
          for (var i = 0; i < graphListFromNighScout.length; i++) {
            var grphData = graphListFromNighScout[i];

            // List<String> dateTimeParts = grphData.timestamp!.split(" ");
            // sparchDataPoint.add(grphData.value!);

            // var startDate = block.percentile5;
            // log((double.parse(grphData.sgv.toString()) / 18).toString());
            // log(grphData.dateString!.hour.toString());
            graphDataPoints.add(
              _ChartSalesData(
                  sales: double.parse(grphData.sgv.toString()) / 18, month: i == 0 ? "now" : i.toString(), color: Color.fromRGBO(54, 169, 225, 1)),
            );
            newgraphDataPoints.add(
              _ChartSalesData(
                  sales: double.parse(grphData.sgv.toString()) / 18, month: i == 0 ? "now" : i.toString(), color: Color.fromRGBO(54, 169, 225, 1)),
            );
          }
        }
        // sparchDataPoint.clear();
      }
    } else {
      log("error$result");
      Utils.errorSnackBar(context, result["message"]);
      showOrHideLoader(false);
    }

    showOrHideLoader(false);
  }

  Future<void> libreGetDataFromServer({
    required BuildContext context,
  }) async {
    glucoHistoryModel = null;

    showOrHideLoader(true);

    var libretoken = sharedPreferences.getString(
      AppConstants.libreTokenKey,
    );
    var userId = sharedPreferences.getString(
      AppConstants.applicationuserIdKey,
    );
    graphListFromServer.clear();
    graphDataPoints.clear();
    newgraphDataPoints.clear();

    var result = await LibreAuthService.librGetMeasurementFromServer(token: libretoken.toString(), patientId: userId ?? "");
    // var result = jsonDecode(dummyjson);

    if (result != null) {
      // log(result.toString());

      glucoHistory = result.toString();
      graphListFromServer = List<GraphDatum>.from(result['graphData'].map((x) => GraphDatum.fromMap(x)));
      var timeStamp = result['lastReadingTimestamp'] != null ? DateTime.parse(result['lastReadingTimestamp']) : DateTime.now();
      lastReadingTimestamp = DateFormat.Hms().format(timeStamp);
      lastReadingValue = result['lastReadingValue'] ?? "";
      minutesSinceLastReading = result['minutesSinceLastReading'] != null ? double.parse(result['minutesSinceLastReading']).toStringAsFixed(1) : "";
      // periodModel = glucoHistoryModel!.data!.periods!.first;
      if (graphListFromServer != null) {
        if (graphListFromServer.isEmpty) {
          Utils.errorSnackBar(context, "No graph data found");
        } else {
          // For loop for showing all the values
          for (var i = 0; i < graphListFromServer.length; i++) {
            var grphData = graphListFromServer[i];

            // List<String> dateTimeParts = grphData.timestamp!.split(" ");
            // sparchDataPoint.add(grphData.value!);

            // var startDate = block.percentile5;
            graphDataPoints.add(
              _ChartSalesData(
                  sales: double.parse(grphData.value.toString()), month: grphData.timestamp!.hour.toString(), color: Color.fromRGBO(54, 169, 225, 1)),
            );
            newgraphDataPoints.add(
              _ChartSalesData(
                  sales: double.parse(grphData.value.toString()), month: grphData.timestamp!.hour.toString(), color: Color.fromRGBO(54, 169, 225, 1)),
            );
          }
        }
        // sparchDataPoint.clear();
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
  List<_ChartSalesData> newgraphDataPoints = [];

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
          pointColorMapper: (_ChartSalesData data, _) => data.color,
          width: 2,
          name: "Graph Data",
          markerSettings: const MarkerSettings(
              color: Color.fromRGBO(54, 169, 225, 1),
              isVisible: false,
              height: 4,
              width: 4,
              shape: DataMarkerType.circle,
              borderWidth: 3,
              borderColor: Color.fromRGBO(54, 169, 225, 1)
              // (graphDataPoints.first.sales >= 4.0 && graphDataPoints.last.sales <= 10.0)
              //     ? Colors.green
              //     : (graphDataPoints.last.sales > 10.0)
              //         ? Colors.red
              //         : Color.fromRGBO(54, 169, 225, 1)
              ),
          dataLabelSettings: const DataLabelSettings(isVisible: false, labelPosition: ChartDataLabelPosition.outside))
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

  Future<void> lightSyncActive({
    required BuildContext context,
  }) async {
    showOrHideLoader(true);
    String? userId = sharedPreferences.getString(AppConstants.applicationuserIdKey);

    var result = await LibreAuthService.lightSyncActive(userid: userId ?? "");

    if (result != null) {
      Utils.successSnackBar(context, result["message"]);
    } else {
      log("error$result");
      Utils.errorSnackBar(context, result["message"]);
      showOrHideLoader(false);
    }

    showOrHideLoader(false);
  }

  Future<void> lightSyncInActive({
    required BuildContext context,
  }) async {
    showOrHideLoader(true);
    String? userId = sharedPreferences.getString(AppConstants.applicationuserIdKey);

    var result = await LibreAuthService.lightSyncINActive(userid: userId ?? "");

    if (result != null) {
      Utils.successSnackBar(context, result["message"]);
    } else {
      log("error$result");
      Utils.errorSnackBar(context, result["message"]);
      showOrHideLoader(false);
    }

    showOrHideLoader(false);
  }

  Future<void> getlightSyncStaus({
    required BuildContext context,
  }) async {
    showOrHideLoader(true);
    String? userId = sharedPreferences.getString(AppConstants.applicationuserIdKey);
    String? token = sharedPreferences.getString(AppConstants.applicationuserIdKey);

    var result = await LibreAuthService.smartLightStatus(userId: userId ?? "");

    if (result != null) {
      log(result.toString());
      lightSyncStatus = result["active"];
      notifyListeners();
    } else {
      log("error$result");
      Utils.errorSnackBar(context, "Some thing went wrong");
      showOrHideLoader(false);
    }

    showOrHideLoader(false);
  }
}

class _ChartSalesData {
  _ChartSalesData({required this.month, required this.sales, required this.color});

  final String month;
  final double sales;
  final Color color;
}
