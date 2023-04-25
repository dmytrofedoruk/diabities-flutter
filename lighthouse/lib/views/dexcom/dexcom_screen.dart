import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lighthouse/global_widgets/custom_gradient_button.dart';
import 'package:lighthouse/mixins/appbar_mixins.dart';
import 'package:lighthouse/providers/libre_home_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import '../../global_widgets/elevated_button.dart';
import 'dexcom_login/loginScreen.dart';

class DexcomHomeScreen extends StatefulWidget {
  const DexcomHomeScreen({super.key});

  @override
  State<DexcomHomeScreen> createState() => _DexcomHomeScreenState();
}

class _DexcomHomeScreenState extends State<DexcomHomeScreen> with AppbarMixin {
  TooltipBehavior? _tooltipBehavior;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // var libreHomeProvider = Provider.of<LibreHomeProvider>(context, listen: false);
      // libreHomeProvider.checkLibreTokenExist().then((value) {
      //   if (value == true) {
      //     Provider.of<LibreHomeProvider>(context, listen: false).libreGetData(
      //       context: context,
      //     );
      //   }
      // });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var libreAuthProvider = Provider.of<LibreAuthProvider>(context, listen: false);
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Scaffold(body: Consumer<LibreHomeProvider>(builder: (context, provider, child) {
      var formmat = DateFormat('MMM dd');
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: provider.isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              // Provider.of<LibreHomeProvider>(context, listen: false).checkLibreTokenExist().then((value) {
                              //   if (value == true) {
                              //     Provider.of<LibreHomeProvider>(context, listen: false).libreGetData(
                              //       context: context,
                              //     );
                              //   }
                              // });
                            },
                            icon: const Icon(
                              Icons.refresh,
                              color: Colors.white,
                            )),
                        IconButton(
                            onPressed: () {
                              // Provider.of<LibreHomeProvider>(context, listen: false).logout(context);
                            },
                            icon: const Icon(
                              Icons.logout,
                              color: Colors.white,
                            ))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome,",
                            style: GoogleFonts.bebasNeue(fontSize: 16, color: Colors.white),
                          ),
                          Text(
                            provider.glucoHistoryModel?.data?.connection?.firstName ?? 'DashBoard',
                            style: GoogleFonts.bebasNeue(fontSize: 42, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    provider.glucoHistoryModel == null
                        ? Center(
                            child: CustomGradientButton(
                              "Connect With Dexcom",
                              width: size.width * 0.8,
                              onpressed: () {
                                showModalBottomSheet<void>(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return const FractionallySizedBox(heightFactor: 0.9, child: DexcomLoginScreen());
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
                        : ListView(
                            children: [
                              Container(
                                height: 400,
                                child: SfCartesianChart(
                                  // title: ChartTitle(text: 'Flutter Chart'),
                                  legend: Legend(isVisible: true, position: LegendPosition.bottom, padding: 10),
                                  series: provider.getDefaultData(),

                                  primaryXAxis: CategoryAxis(
                                      // visibleMaximum: 20,
                                      // visibleMinimum: 5
                                      ),

                                  tooltipBehavior: _tooltipBehavior,
                                ),
                              ),
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
    }));
  }
}
