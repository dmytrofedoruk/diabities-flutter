// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lighthouse/global_widgets/custom_gradient_button.dart';
import 'package:lighthouse/main.dart';
import 'package:lighthouse/mixins/appbar_mixins.dart';
import 'package:lighthouse/providers/libre_home_provider.dart';
import 'package:lighthouse/views/libre_auth/login/loginScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

import '../../global_widgets/elevated_button.dart';
import '../../global_widgets/gradient_container.dart';
import 'liberview_items.dart';

class LibreViewScreen extends StatefulWidget {
  const LibreViewScreen({super.key});

  @override
  State<LibreViewScreen> createState() => _LibreViewScreenState();
}

class _LibreViewScreenState extends State<LibreViewScreen> with AppbarMixin {
  TooltipBehavior? _tooltipBehavior;

  late SharedPreferences sharedPreferences;
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {Factory(() => EagerGestureRecognizer())};
  final UniqueKey _key = UniqueKey();
  void initPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true, canShowMarker: true);
    initPrefs();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      var libreHomeProvider = Provider.of<LibreHomeProvider>(context, listen: false);

      libreHomeProvider.checkNightScoutUrlExist().then((value) {
        if (value) {
          libreHomeProvider.getNightScoutdata(context: context);
          log("getNightScoutdata");
        } else {
          log("libreGetDataFromServer");
          libreHomeProvider.checkLibreTokenExist().then((value) {
            if (value == true) {
              Provider.of<LibreHomeProvider>(context, listen: false).libreGetDataFromServer(
                context: context,
              );
            }
          });
        }
      });

      libreHomeProvider.getlightSyncStaus(context: context);
    });

    super.initState();
  }

  bool is6Hours = false;
  bool is12Hours = false;
  bool is24Hours = true;

  int interval = 3;
  int max = 24;

  @override
  Widget build(BuildContext context) {
    // var libreAuthProvider = Provider.of<LibreAuthProvider>(context, listen: false);
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Consumer<LibreHomeProvider>(builder: (context, provider, child) {
      var formmat = DateFormat('MMM dd');
      return Container(
        height: size.height,
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
                  shrinkWrap: true,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              provider.checkNightScoutUrlExist().then((value) {
                                if (value) {
                                  provider.getNightScoutdata(context: context);
                                  log("getNightScoutdata");
                                } else {
                                  log("libreGetDataFromServer");
                                  provider.checkLibreTokenExist().then((value) {
                                    if (value == true) {
                                      Provider.of<LibreHomeProvider>(context, listen: false).libreGetDataFromServer(
                                        context: context,
                                      );
                                    }
                                  });
                                }
                              });

                              // Provider.of<LibreHomeProvider>(context, listen: false).checkLibreTokenExist().then((value) {
                              //   if (value == true) {
                              //     Provider.of<LibreHomeProvider>(context, listen: false)
                              //         .libreGetDataFromServer(
                              //       context: context,
                              //     )
                              //         .then((value) {
                              //       initPrefs();
                              //       Provider.of<LibreHomeProvider>(context, listen: false).controller.reload();
                              //       Provider.of<LibreHomeProvider>(context, listen: false).controller.currentUrl().then((value) {
                              //         log(value!);
                              //       });
                              //     });
                              //   }
                              // });
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
                    // Padding(
                    //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    //     child: InputTextField(
                    //       label: "",
                    //       onChanged: (value) {},
                    //       decoration: InputDecoration(
                    //         prefixIcon: Container(
                    //           height: 30,
                    //           width: 30,
                    //           child: Center(
                    //             child: Image.asset(
                    //               'assets/nightscout.png',
                    //               height: 30,
                    //               width: 30,
                    //               fit: BoxFit.contain,
                    //             ),
                    //           ),
                    //         ),
                    //         suffixIcon: IconButton(
                    //             onPressed: () {
                    //               log("cehck");
                    //             },
                    //             icon: Icon(
                    //               Icons.check,
                    //               color: Colors.white,
                    //             )),
                    //         focusedBorder: OutlineInputBorder(
                    //           borderSide: const BorderSide(color: Colors.black),
                    //           borderRadius: BorderRadius.circular(15.7),
                    //         ),
                    //         enabledBorder: OutlineInputBorder(
                    //           borderSide: const BorderSide(color: Colors.grey),
                    //           borderRadius: BorderRadius.circular(15.7),
                    //         ),
                    //         hintText: "Add Nightscout Url",
                    //         // prefixIcon: Icon(
                    //         //   Icons.person,
                    //         //   size: 20,
                    //         //   color: Theme.of(context).textTheme.overline?.color,
                    //         // ),
                    //       ),
                    //     )),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 20),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       const SizedBox(
                    //         height: 10,
                    //       ),
                    //       Text(
                    //         "Welcome,",
                    //         style: GoogleFonts.bebasNeue(fontSize: 16, color: theme.primaryColor),
                    //       ),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           Text(
                    //             provider.glucoHistoryModel?.data?.connection?.firstName ?? 'DashBoard',
                    //             style: GoogleFonts.bebasNeue(fontSize: 42, color: theme.primaryColor),
                    //           ),
                    //           Provider.of<HueProvider>(context).deviceListModel == null ||
                    //                   Provider.of<HueProvider>(context).deviceListModel?.data == null
                    //               ? Container(
                    //                   height: 40,
                    //                   width: 40,
                    //                   decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(20)),
                    //                   child: IconButton(
                    //                       onPressed: () {
                    //                         Provider.of<DashBoardProvider>(context, listen: false).selectTab(1);
                    //                       },
                    //                       icon: const Icon(Icons.light)))
                    //               : Container(
                    //                   height: 40,
                    //                   width: 40,
                    //                   decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                    //                   child: IconButton(
                    //                       onPressed: () {
                    //                         Provider.of<DashBoardProvider>(context, listen: false).selectTab(1);
                    //                       },
                    //                       icon: const Icon(
                    //                         Icons.light,
                    //                         color: Colors.green,
                    //                       )))
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    provider.graphListFromServer == null
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
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                                child: Text(
                                  "Today",
                                  style: GoogleFonts.bebasNeue(fontSize: 16, color: theme.primaryColor),
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        inspect(provider.getDefaultData());
                                      },
                                      child: ItemPointsWidget(
                                        title: "Reading time",
                                        value: provider.lastReadingTimestamp,
                                        unit: "",
                                      ),
                                    ),
                                    ItemPointsWidget(
                                      title: "Rading value",
                                      value: provider.lastReadingValue,
                                      unit: "mmol/L",
                                    ),
                                    ItemPointsWidget(
                                      title: "Last reading",
                                      value: provider.minutesSinceLastReading,
                                      unit: "Minutes ago",
                                    ),
                                  ],
                                ),
                              ),
                              // (provider.glucoHistoryModel!.data!.graphData != null &&
                              //         provider.glucoHistoryModel!.data!.graphData != null &&
                              //         provider.glucoHistoryModel!.data!.graphData!.isNotEmpty)
                              provider.graphListFromServer.isNotEmpty || provider.graphListFromNighScout.isNotEmpty
                                  // ?
                                  // SizedBox(
                                  //     height: size.height * 0.62,
                                  //     width: size.width * 0.99,
                                  //     child: WebViewWidget(
                                  //       controller: Provider.of<LibreHomeProvider>(context, listen: false).controller,
                                  //       key: _key,
                                  //       gestureRecognizers: gestureRecognizers,
                                  //     ),
                                  //   )
                                  ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                          child: Text("Blood glucose (mmol/L)", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                        ),
                                        Container(
                                          height: 300,
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: SfCartesianChart(
                                            series: provider.getDefaultData(),

                                            zoomPanBehavior: ZoomPanBehavior(
                                              enablePanning: true,
                                            ),
                                            primaryXAxis: CategoryAxis(
                                              labelStyle: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                              ),
                                              // title: AxisTitle(
                                              //     text: "Time",
                                              //     alignment: ChartAlignment.far,
                                              //     textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                              labelRotation: 0,
                                              isInversed: true,
                                              majorGridLines: const MajorGridLines(width: 0),

                                              minimum: 0,
                                              maximum: max.toDouble(),
                                              interval: interval.toDouble(),
                                            ),
                                            primaryYAxis: NumericAxis(
                                                plotBands: [
                                                  PlotBand(start: 4, end: 10, text: 'Normal', color: Colors.green[300]!),
                                                  PlotBand(start: 10, end: 20, text: 'High', color: Color.fromRGBO(222, 133, 0, 1).withOpacity(0.5)),
                                                  PlotBand(start: 0, end: 4, text: 'Low', color: Colors.red!),
                                                ],
                                                minimum: 0,
                                                maximum: 20,
                                                interval: 4,
                                                // labelFormat: '{value}%',
                                                labelStyle: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                )),
                                            // primaryYAxis: CategoryAxis(
                                            //   majorGridLines: MajorGridLines(width: 0),
                                            // ),

                                            // tooltipBehavior: _tooltipBehavior,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 30),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: const [
                                              Text("Time", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            CustomButton(
                                              "6 Hours",
                                              textColor: is6Hours ? Colors.white : Colors.grey,
                                              width: 100,
                                              onpressed: () {
                                                setState(() {
                                                  max = 6;
                                                  is6Hours = true;
                                                  is12Hours = false;
                                                  is24Hours = false;
                                                  provider.updateGraphDataAccordingtoHours(6);
                                                });
                                              },
                                            ),
                                            CustomButton(
                                              "12 Hours",
                                              textColor: is12Hours ? Colors.white : Colors.grey,
                                              width: 100,
                                              onpressed: () {
                                                setState(() {
                                                  provider.updateGraphDataAccordingtoHours(12);
                                                  max = 12;
                                                  is6Hours = false;
                                                  is12Hours = true;
                                                  is24Hours = false;
                                                });
                                              },
                                            ),
                                            CustomButton(
                                              "24 Hours",
                                              textColor: is24Hours ? Colors.white : Colors.grey,
                                              width: 100,
                                              onpressed: () {
                                                setState(() {
                                                  provider.updateGraphDataAccordingtoHours(24);
                                                  max = 24;
                                                  is6Hours = false;
                                                  is12Hours = false;
                                                  is24Hours = true;
                                                });
                                              },
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  : const Center(
                                      child: Text(
                                      "No Graph Data Found",
                                      style: TextStyle(color: Colors.white),
                                    )),
                              // const SizedBox(
                              //   height: 10,
                              // ),
                              // Center(
                              //   child: GradientContainer(
                              //     radius: 40.7,
                              //     paddinghorizontal: 0,
                              //     paddingvertical: 0,
                              //     child: Row(
                              //       mainAxisSize: MainAxisSize.min,
                              //       children: [
                              //         const SizedBox(
                              //           width: 15,
                              //         ),
                              //         Text(
                              //           "Emergency Calling",
                              //           style: GoogleFonts.roboto(fontSize: 12, color: theme.primaryColor, fontWeight: FontWeight.bold),
                              //         ),
                              //         const SizedBox(
                              //           width: 5,
                              //         ),
                              //         const Icon(
                              //           Icons.more_horiz,
                              //           color: Colors.white,
                              //         ),
                              //         SizedBox(
                              //           height: 35,
                              //           child: Switch.adaptive(
                              //             onChanged: (value) {
                              //               setState(() {
                              //                 isEmergencyNumberOn = value;
                              //               });
                              //             },
                              //             value: isEmergencyNumberOn,
                              //             activeColor: Colors.green,
                              //             activeTrackColor: const Color.fromRGBO(35, 60, 133, 1),
                              //             inactiveThumbColor: Colors.redAccent,
                              //             inactiveTrackColor: Colors.grey,
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              const SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: GradientContainer(
                                  radius: 40.7,
                                  paddinghorizontal: 0,
                                  paddingvertical: 0,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        "SmartLight Sync  ",
                                        style: GoogleFonts.roboto(fontSize: 12, color: theme.primaryColor, fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Icon(
                                        Icons.more_horiz,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        height: 35,
                                        child: Switch.adaptive(
                                          onChanged: (value) {
                                            if (value) {
                                              provider.lightSyncActive(context: context).then((value) {
                                                provider.getlightSyncStaus(context: context);
                                              });
                                            } else {
                                              provider.lightSyncInActive(context: context).then((value) {
                                                provider.getlightSyncStaus(context: context);
                                              });
                                            }
                                            // setState(() {
                                            //   isSmartLightSyncOn = value;
                                            // });
                                          },
                                          value: provider.lightSyncStatus,
                                          activeColor: Colors.green,
                                          activeTrackColor: const Color.fromRGBO(35, 60, 133, 1),
                                          inactiveThumbColor: Colors.redAccent,
                                          inactiveTrackColor: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                  ],
                ),
              ),
      );
    });
  }
}
