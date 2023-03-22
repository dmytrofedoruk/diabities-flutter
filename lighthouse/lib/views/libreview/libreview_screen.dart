import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lighthouse/mixins/appbar_mixins.dart';
import 'package:lighthouse/providers/libre_auth_provider.dart';
import 'package:lighthouse/providers/libre_home_provider.dart';
import 'package:lighthouse/views/libre_auth/login/loginScreen.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import '../../global_widgets/elevated_button.dart';
import '../auth/autroize/authroize_webview.dart';

class LibreViewScreen extends StatefulWidget {
  const LibreViewScreen({super.key});

  @override
  State<LibreViewScreen> createState() => _LibreViewScreenState();
}

class _LibreViewScreenState extends State<LibreViewScreen> with AppbarMixin {
  TooltipBehavior? _tooltipBehavior;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
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

  @override
  Widget build(BuildContext context) {
    // var libreAuthProvider = Provider.of<LibreAuthProvider>(context, listen: false);
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Scaffold(
        appBar: baseStyleAppBar(title: '', leadingWidget: Container(), actions: [
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
              icon: const Icon(Icons.refresh)),
          IconButton(
              onPressed: () {
                Provider.of<LibreHomeProvider>(context, listen: false).logout(context);
              },
              icon: const Icon(Icons.logout))
        ]),
        body: Consumer<LibreHomeProvider>(builder: (context, provider, child) {
          var formmat = DateFormat('MMM dd');
          return Scaffold(
            body: SingleChildScrollView(
              child: provider.isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Welcome,",
                                style: GoogleFonts.bebasNeue(fontSize: 16, color: Colors.grey.shade800),
                              ),
                              Text(
                                provider.glucoHistoryModel?.data?.connection?.firstName ?? 'DashBoard',
                                style: GoogleFonts.bebasNeue(fontSize: 42),
                              ),
                            ],
                          ),
                        ),
                        provider.glucoHistoryModel == null
                            ? Center(
                                child: CustomButton(
                                  "Connect With Libre",
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
