// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lighthouse/helpers/Utils.dart';
import 'package:lighthouse/mixins/appbar_mixins.dart';
import 'package:lighthouse/models/token_model.dart';
import 'package:lighthouse/providers/hue_auth_provider.dart';
import 'package:lighthouse/views/auth/joining_screens/joinning_screen.dart';
import 'package:lighthouse/views/auth/login/loginScreen.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SubscriptionWebview extends StatefulWidget {
  final String SubScriptionUrl;
  const SubscriptionWebview({super.key, required this.SubScriptionUrl});

  @override
  State<SubscriptionWebview> createState() => _SubscriptionWebviewState();
}

bool isLoading = true;

class _SubscriptionWebviewState extends State<SubscriptionWebview> with AppbarMixin {
  late final WebViewController controller;
  response() async {
    String response = await controller.runJavaScriptReturningResult("document.documentElement.innerText") as String;

    // if (response.contains("access_token")) {
    //   var tokenModel = tokensModelFromMap(jsonDecode(response));
    //   await Provider.of<HueAuthProvider>(context, listen: false).accessTokenChanged(tokenModel, context);
    //   log(tokenModel.accessToken.toString());
    // }
    log(response.runtimeType.toString());
    log(jsonDecode(response.toString()));
  }

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            if (url == "https://reminiscent-chill-actress.glitch.me/paymentSuccessPage") {
              Utils.successSnackBar(context, "Payment successful ");
              // Add your URL here
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
                return const LoginScreen();
              }));
            }
          },
          onPageFinished: (String url) async {
            log(url);
            isLoading = false;
            response();
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.SubScriptionUrl));
    super.initState();
  }

  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {Factory(() => EagerGestureRecognizer())};

  final UniqueKey _key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseStyleAppBar(title: "Subscription", actions: [
        IconButton(
            onPressed: () {
              controller.reload();
            },
            icon: const Icon(Icons.refresh)),
      ]),
      body: Stack(
        children: [
          isLoading
              ? const Center(
                  child: Text('Fetching data....'),
                )
              : const SizedBox.shrink(),
          Column(
            children: [
              Expanded(
                child: WebViewWidget(
                  controller: controller,
                  key: _key,
                  gestureRecognizers: gestureRecognizers,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
