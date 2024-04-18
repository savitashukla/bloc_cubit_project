import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cubit_project/utils/help_method.dart';
import 'package:cubit_project/view/cricket/game_over_screen_cricket.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utils/logger_utils.dart';

class CricketWebView extends StatefulWidget {

  String? url;
  String? event_id;
  String? gameid;
  String? playAmount;

  CricketWebView(
      this.url, this.gameid, this.event_id, this.playAmount, {super.key});

  @override
  State<CricketWebView> createState() => _CricketWebViewState();
}

class _CricketWebViewState extends State<CricketWebView> {
  WebViewController? controller;

  @override
  void initState() {
    // TODO: implement initState

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..addJavaScriptChannel("AndroidBridge",
          onMessageReceived: (JavaScriptMessage message) {
            HelpMethod().customPrint("----- wevview onMessageReceived");
         //   String mapVa = message.message;
            Navigator.push(
              navigatorKey.currentState!.context,
              MaterialPageRoute(builder: (context) => GameOverScreenCricket(widget.gameid,widget.event_id,widget.playAmount)),
            );

       /*     final resData = json.decode(message.message);
            HelpMethod().customPrint(
                'Completed Game Over Event Testing ${resData}');
            // call other data
            if (resData["event"] == "match_over" ||
                resData["event"] == "match_result") {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
             *//* WebViewController webViewController =
                  await webViewCompleter.future;
              await webViewController.clearCache();
              Navigator.of(context).pop();
              Get.to((Match_Making_Screen(
                  event_id, gameid, mapVa, playAmount, url1)));*//*
            }*/
          })
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) async {
          /*  if (request.url.startsWith('http://xyads.fuse-cloud.com/')) {
              if (await canLaunch(request.url)) {
                await launch(request.url);
              } else {
                throw 'Could not launch ${request.url}';
              }
            }*/
            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse(
          "${widget.url}"));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool isPop = false;
        await showAlertDialog(context, (alertResponse) {
          Navigator.of(context).pop();
          // This will dismiss the alert dialog
          isPop = alertResponse;
        });
        return isPop;
      },
      child: Scaffold(
          body: Center(
        child: WebViewWidget(
          controller: controller!,
        ),
      )),
    );
  }

  Future showAlertDialog(
      BuildContext context, YesOrNoTapCallback isYesTapped) async {
    AlertDialog alert = AlertDialog(
      elevation: 24,
      content: const Text("Do you want to quit?"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
              //   Get.to(() => GameJobList(gameid, url1, "Ludo"));
              //isYesTapped(true);
            },
            child: const Text("Yes")),
        TextButton(
            onPressed: () {
              isYesTapped(false);
              // Navigator.of(context).pop();
            },
            child: const Text("No")),
      ],
    );
    await showDialog(context: context, builder: (_) => alert);
  }
}

typedef YesOrNoTapCallback = Function(bool);
