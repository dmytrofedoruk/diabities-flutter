// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lighthouse/models/token_model.dart';
import 'package:lighthouse/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AuthroizeWebview extends StatefulWidget {
  const AuthroizeWebview({super.key});

  @override
  State<AuthroizeWebview> createState() => _AuthroizeWebviewState();
}

bool isLoading = true;

class _AuthroizeWebviewState extends State<AuthroizeWebview> {
  late final WebViewController controller;
  response() async {
    String response = await controller.runJavaScriptReturningResult("document.documentElement.innerText") as String;
    if (response.contains("access_token")) {
      var tokenModel = tokensModelFromMap(jsonDecode(response));
      await Provider.of<AuthProvider>(context, listen: false).accessTokenChanged(tokenModel, context);
      log(tokenModel.accessToken.toString());
    }
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
          onPageStarted: (String url) {},
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
      ..loadRequest(Uri.parse('https://reminiscent-chill-actress.glitch.me/authorize'));
    super.initState();
  }

  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {Factory(() => EagerGestureRecognizer())};

  final UniqueKey _key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          isLoading
              ? const Center(
                  child: Text('Fetching data....'),
                )
              : const SizedBox.shrink(),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel")),
                    IconButton(
                        onPressed: () {
                          controller.reload();
                        },
                        icon: const Icon(Icons.refresh)),
                  ],
                ),
              ),
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
