import 'package:flutter/material.dart';
import 'package:cubit_project/utils/help_method.dart';
import 'package:cubit_project/utils/weight/help_weight.dart';
import 'package:cubit_project/view/dashboard/dashboard.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utils/logger_utils.dart';

class MyTeam11Screen extends StatefulWidget {
  String? url;

  MyTeam11Screen(this.url);

  @override
  State<MyTeam11Screen> createState() => MyTeam11ScreenState();
}

class MyTeam11ScreenState extends State<MyTeam11Screen> {
  WebViewController? controller;

  @override
  void initState() {
    // TODO: implement initState

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..addJavaScriptChannel("AndroidBridge",
          onMessageReceived: (JavaScriptMessage message) {
        HelpMethod().customPrint(
            "object get data team11 ${message.message.toString()}");

        if (message.message.contains("goToLobby")) {
          Navigator.pop(navigatorKey.currentState!.context);
          //Get.to(() => DashBord(2, ""));
          // Get.offAll(() = > DashBord(2, ""));
        }
        if (message.message.contains("goToAddCash")) {
          Navigator.push(
            navigatorKey.currentState!.context,
            MaterialPageRoute(
              builder: (BuildContext context) => DashBoard(),
            ),
          );
        }
        if (message.message.contains("gmng_download://${message}")) {
          HelpWeight().flutterCustomToast("$message");
        }
        HelpMethod().customPrint("BB-----" + message.message);
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
      ..loadRequest(Uri.parse("${widget.url}"));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
            body: Center(
          child: WebViewWidget(
            controller: controller!,
          ),
        )),
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
