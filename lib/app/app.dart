import 'package:flutter/material.dart';

import '../data/route/Routes.dart';
import '../res/AppColor.dart';
import '../utils/logger_utils.dart';


class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      AppLogger.i("Application State => resumed");
    } else if (state == AppLifecycleState.detached) {
      AppLogger.i("Application State => detached");
    } else if (state == AppLifecycleState.inactive) {
      AppLogger.i("Application State => inactive");
    } else if (state == AppLifecycleState.paused) {
   //   AppLogger.i("Application State => paused");
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: AppColor().colorPrimary,
              fontFamily: 'Montserrat',
            ),
            navigatorKey: navigatorKey,
            routes: Routes.getRoutes(),
            builder: (BuildContext context, Widget? child) {
              return MediaQuery(
                  data:
                  MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: child!);
            });
      },
    );
  }
}
