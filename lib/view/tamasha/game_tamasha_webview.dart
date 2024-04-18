import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cubit_project/utils/help_method.dart';
import 'package:cubit_project/utils/weight/help_weight.dart';
import 'package:cubit_project/view/cricket/game_over_screen_cricket.dart';
import 'package:cubit_project/view/tamasha/game_over_screen_tamasha.dart';
import 'package:cubit_project/view_model/cubit/gamezop_game_list/gamezop_event_list_equatable.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utils/logger_utils.dart';
import '../../view_model/cubit/gamezop_game_list/gamezop_event_list_cubit.dart';

class TamashaWebView extends StatefulWidget {

  String? url;
  String? event_id;
  String? gameid;
  String? playAmount;

  TamashaWebView(
      this.url, this.gameid, this.event_id, this.playAmount, {super.key});

  @override
  State<TamashaWebView> createState() => _TamashaWebViewState();
}

class _TamashaWebViewState extends State<TamashaWebView> {
  WebViewController? controller;

  GamezopEventListCubit? gamezopEventListCubit;

  @override
  void initState() {
    // TODO: implement initState





    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..addJavaScriptChannel("NativeJavascriptInterface",
          onMessageReceived: (JavaScriptMessage message) {
            try {
              var messageJson = json.decode(message.message);
              print("get res....... va$messageJson");

              if (messageJson != null) {
                // When No Play Found
                /*if (messageJson['reason'] == 'normal' ||
                                    messageJson['reason'] == 'refund') {
                                  WebViewController webViewController =
                                  await webViewCompleter.future;
                                  await webViewController.clearCache();
                                  Navigator.of(context).pop();
                                } else {*/

                if (messageJson['reason'] == 'refund') {
                  print("call data use");
                  Future.delayed(const Duration(seconds: 3), () async {
                  /*  WebViewController webViewController =
                    await webViewCompleter.future;
                    await webViewController.clearCache();*/
                    //   Navigator.of(navigatorKey.currentState.context).pop();

                  });
                } else if (messageJson['reason'] == 'data-transfer') {

                  HelpMethod().customPrint("profile user name ");
                  if (messageJson['gameData'] != null &&
                      messageJson['gameData'] != null &&
                      messageJson['gameData']['otherData']
                      ["eventName"] ==
                          "end") {
                    print(
                        "name get ${messageJson['gameData']['otherData']["game_data"][0]["name"]}");
                    for (int index = 0;
                    messageJson['gameData']['otherData']
                    ["game_data"]
                        .length >
                        index;
                    index++) {
                      print(
                          "GO TO LOOP DATA  ${messageJson['gameData']['otherData']["game_data"][index]["name"]}");

                      if ("${gamezopEventListCubit!.state.profileDataC!.username}".compareTo(
                          "${messageJson['gameData']['otherData']["game_data"][index]["name"]}") ==
                          0) {
                        print(
                            "compre name correct  ${messageJson['gameData']['otherData']["game_data"][index]["rank"] == 1}");

                        if (messageJson['gameData']['otherData']
                        ["game_data"][index]["rank"] ==
                            1) {
                          print(
                              "compre rank correct  ${messageJson['gameData']['otherData']["game_data"][index]["rank"]}");


                          Navigator.of(context).pop();
                          Navigator.push(
                            navigatorKey.currentState!.context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  Tamasha_Game_Over(
                                     widget. gameid,
                                      widget. event_id,
                                      widget.  playAmount,


                                      true,
                                      messageJson['gameData']
                                      ['otherData']["game_data"]
                                      [index]["sc"]),
                            ),
                          );
                        } else {

                          Navigator.of(context).pop();
                          Navigator.push(
                            navigatorKey.currentState!.context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  Tamasha_Game_Over(
                                      widget.gameid,
                                      widget.event_id,
                                      widget.playAmount,


                                      false,
                                      messageJson['gameData']
                                      ['otherData']["game_data"]
                                      [index]["sc"]),
                            ),
                          );
                        }
                      }
                    }
                  }
                  else if (messageJson['gameData'] != null &&
                      messageJson['gameData'] != null &&
                      messageJson['gameData']['otherData']
                      ["eventName"] ==
                          "tmRemain")
                  {

                    }
                }
                // }
              }
            } catch (E) {}

            //calling
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
         // "https://flutter.dev"));
          "${widget.url}"));


    gamezopEventListCubit = context.read<GamezopEventListCubit>();


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
      child: BlocBuilder<GamezopEventListCubit,GamezopEventListEquatable>(
        builder: (context,state) {
          return Scaffold(
              body: Center(
            child: WebViewWidget(
              controller: controller!,
            ),
          ));
        }
      ),
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
