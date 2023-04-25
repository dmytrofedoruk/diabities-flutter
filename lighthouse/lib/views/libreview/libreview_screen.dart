// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lighthouse/global_widgets/custom_gradient_button.dart';
import 'package:lighthouse/mixins/appbar_mixins.dart';
import 'package:lighthouse/providers/libre_home_provider.dart';
import 'package:lighthouse/views/libre_auth/login/loginScreen.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

import '../../providers/dashboard_provider.dart';
import '../../providers/homeProvider.dart';

class LibreViewScreen extends StatefulWidget {
  const LibreViewScreen({super.key});

  @override
  State<LibreViewScreen> createState() => _LibreViewScreenState();
}

class _LibreViewScreenState extends State<LibreViewScreen> with AppbarMixin {
  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true, canShowMarker: true);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      var libreHomeProvider = Provider.of<LibreHomeProvider>(context, listen: false);
      libreHomeProvider.checkLibreTokenExist().then((value) {
        if (value == true) {
          Provider.of<LibreHomeProvider>(context, listen: false).libreGetData(
            context: context,
          );
        }
      });
    });

    super.initState();
  }

  bool isEmergencyNumberOn = false;

  @override
  Widget build(BuildContext context) {
    // var libreAuthProvider = Provider.of<LibreAuthProvider>(context, listen: false);
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return
        // appBar: baseStyleAppBar(title: '', leadingWidget: Container(), actions: [

        // ]),
        Consumer<LibreHomeProvider>(builder: (context, provider, child) {
      var formmat = DateFormat('MMM dd');
      return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: provider.isLoading
            ? Center(
                child: CupertinoActivityIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              )
            : Container(
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Emergency Calling",
                          style: GoogleFonts.bebasNeue(fontSize: 16, color: theme.primaryColor),
                        ),
                        Switch(
                          onChanged: (value) {
                            setState(() {
                              isEmergencyNumberOn = value;
                            });
                          },
                          value: isEmergencyNumberOn,
                          activeColor: Colors.green,
                          activeTrackColor: const Color.fromRGBO(35, 60, 133, 1),
                          inactiveThumbColor: Colors.redAccent,
                          inactiveTrackColor: Colors.grey,
                        ),
                        IconButton(
                            onPressed: () {
                              Provider.of<LibreHomeProvider>(context, listen: false).checkLibreTokenExist().then((value) {
                                if (value == true) {
                                  Provider.of<LibreHomeProvider>(context, listen: false).libreGetData(
                                    context: context,
                                  );
                                }
                              });
                            },
                            icon: Icon(
                              Icons.refresh,
                              color: theme.primaryColor,
                            )),
                        IconButton(
                            onPressed: () {
                              Provider.of<LibreHomeProvider>(context, listen: false).logout(context);
                            },
                            icon: Icon(
                              Icons.logout,
                              color: theme.primaryColor,
                            ))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 35,
                          ),
                          Text(
                            "Welcome,",
                            style: GoogleFonts.bebasNeue(fontSize: 16, color: theme.primaryColor),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                provider.glucoHistoryModel?.data?.connection?.firstName ?? 'DashBoard',
                                style: GoogleFonts.bebasNeue(fontSize: 42, color: theme.primaryColor),
                              ),
                              Provider.of<HueProvider>(context).deviceListModel == null ||
                                      Provider.of<HueProvider>(context).deviceListModel?.data == null
                                  ? Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(20)),
                                      child: IconButton(
                                          onPressed: () {
                                            Provider.of<DashBoardProvider>(context, listen: false).selectTab(1);
                                          },
                                          icon: const Icon(Icons.light)))
                                  : Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                                      child: IconButton(
                                          onPressed: () {
                                            Provider.of<DashBoardProvider>(context, listen: false).selectTab(1);
                                          },
                                          icon: const Icon(
                                            Icons.light,
                                            color: Colors.green,
                                          )))
                            ],
                          ),
                        ],
                      ),
                    ),
                    provider.glucoHistoryModel == null
                        ? Center(
                            child: CustomGradientButton(
                              "Connect Libre Device",
                              width: size.width * 0.8,
                              onpressed: () {
                                showModalBottomSheet<void>(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return const FractionallySizedBox(heightFactor: 0.9, child: LibreLoginScreen());
                                  },
                                  backgroundColor: theme.primaryColorDark,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                );
                              },
                              backgroundColor: theme.primaryColorDark,
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                child: Text(
                                  "Today",
                                  style: GoogleFonts.bebasNeue(fontSize: 16, color: theme.primaryColor),
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    // ItemPointsWidget(
                                    //   title: "Active insulin",
                                    //   value: "1.5",
                                    //   unit: "units",
                                    // ),
                                    ItemPointsWidget(
                                      title: "Average BG",
                                      value: "8.5",
                                      unit: "mmol/L",
                                    ),
                                    ItemPointsWidget(
                                      title: "Time in Range",
                                      value: "57",
                                      unit: "%",
                                    ),
                                  ],
                                ),
                              ),
                              (provider.glucoHistoryModel!.data!.graphData != null &&
                                      provider.glucoHistoryModel!.data!.graphData != null &&
                                      provider.glucoHistoryModel!.data!.graphData!.isNotEmpty)
                                  ? Stack(
                                      children: [
                                        Positioned(
                                            top: 120,
                                            child: Center(
                                              child: Container(
                                                margin: EdgeInsets.symmetric(horizontal: 25),
                                                height: 120,
                                                width: MediaQuery.of(context).size.width * 0.95,
                                                color: Colors.green[400],
                                              ),
                                            )),
                                        Container(
                                          height: 400,
                                          child: MaterialApp(
                                            theme: ThemeData(brightness: Brightness.dark),
                                            debugShowCheckedModeBanner: false,
                                            home: SfCartesianChart(
                                              plotAreaBorderColor: Colors.white,
                                              // plotAreaBorderWidth: 0,
                                              // title: ChartTitle(text: 'Flutter Chart'),
                                              legend: Legend(isVisible: true, position: LegendPosition.bottom, padding: 10),
                                              series: provider.getDefaultData(),
                                              // zoomPanBehavior: ZoomPanBehavior(
                                              //   enablePanning: true,
                                              // ),
                                              primaryXAxis: CategoryAxis(
                                                labelRotation: 90,
                                                majorGridLines: MajorGridLines(width: 0),

                                                // minimum: 2,
                                                // maximum: 16,
                                                // interval: 3,
                                              ),
                                              primaryYAxis: NumericAxis(
                                                  minimum: 2,
                                                  maximum: 16,
                                                  interval: 1,
                                                  // labelFormat: '{value}%',
                                                  labelStyle: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Roboto',
                                                    fontSize: 10,
                                                  )),
                                              // primaryYAxis: CategoryAxis(
                                              //   majorGridLines: MajorGridLines(width: 0),
                                              // ),

                                              tooltipBehavior: _tooltipBehavior,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : const Center(
                                      child: Text(
                                      "No Graph Data Found",
                                      style: TextStyle(color: Colors.white),
                                    )),
                              // provider.glucoHistoryModel == null || provider.periodModel == null
                              //     ? Container()
                              //     : Container(
                              //         margin: const EdgeInsets.all(10),
                              //         padding: const EdgeInsets.all(20),
                              //         decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                              //         child: Column(
                              //           children: [
                              //             Row(
                              //               children: [
                              //                 Text(
                              //                   "Max Glucose Range: ${provider.periodModel!.data!.maxGlucoseRange!.toString()}",
                              //                   style: GoogleFonts.bebasNeue(fontSize: 16, color: Colors.grey.shade800),
                              //                 ),
                              //               ],
                              //             ),
                              //             Row(
                              //               children: [
                              //                 Text(
                              //                   "Min Glucose Range: ${provider.periodModel!.data!.minGlucoseRange!.toString()}",
                              //                   style: GoogleFonts.bebasNeue(fontSize: 16, color: Colors.grey.shade800),
                              //                 ),
                              //               ],
                              //             ),
                              //             Row(
                              //               children: [
                              //                 Text(
                              //                   "Max Glucose value: ${provider.periodModel!.data!.maxGlucoseValue!.toString()}",
                              //                   style: GoogleFonts.bebasNeue(fontSize: 16, color: Colors.grey.shade800),
                              //                 ),
                              //               ],
                              //             )
                              //           ],
                              // ),
                              // )
                              // Text(provider.glucoHistory),
                            ],
                          ),
                  ],
                ),
              ),
      );
    });
  }
}

class ItemPointsWidget extends StatelessWidget {
  final String? title;
  final String? value;
  final String? unit;

  const ItemPointsWidget({super.key, required this.title, required this.value, required this.unit});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, bottom: 20),
      height: 120,
      width: 135,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(46, 120, 184, 1),
              Color.fromRGBO(35, 60, 133, 1),
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            title ?? "",
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            value ?? "",
            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            unit ?? "",
            style: const TextStyle(color: Colors.white, fontSize: 12),
          )
        ],
      ),
    );
  }
}
