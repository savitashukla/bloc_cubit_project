import 'package:flutter/material.dart';
import 'package:cubit_project/utils/logger_utils.dart';


showProgressIma() async {
    showGeneralDialog(
      context: navigatorKey.currentState!.context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      // transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            height: 100,
            width: 100,
            color: Colors.transparent,
            child: const Image(
                height: 100,
                width: 100,
                //color: Colors.transparent,
                fit: BoxFit.fill,
                image:AssetImage("assets/images/progresbar_images.gif")),
          ),
        );
      },
    );

}


showProgress() async {
  showGeneralDialog(
    context: navigatorKey.currentState!.context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    // transitionDuration: Duration(milliseconds: 200),
    pageBuilder: (_, __, ___) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );

}

showProgressUnity(BuildContext context, String message, bool isDismissible) async {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.5),
    // transitionDuration: Duration(milliseconds: 200),
    pageBuilder: (_, __, ___) {
      return Center(
        child: Container(
          height: 100,
          width: 100,
          color: Colors.transparent,
          child: const Image(
              height: 100,
              width: 100,
              //color: Colors.transparent,
              fit: BoxFit.fill,
              image:AssetImage("assets/images/progresbar_images.gif")),

          //image:AssetImage("assets/images/progresbar_images.gif")),
        ),
      );
    },
  );

}

hideProgress() async {
  Navigator.pop(navigatorKey.currentState!.context);

}


//new progress bar not dissmissible
showProgressDismissible(BuildContext context, String message, bool isDismissible) async {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: isDismissible,
    barrierColor: Colors.black.withOpacity(0.5),
    // transitionDuration: Duration(milliseconds: 200),
    pageBuilder: (_, __, ___) {
      return Center(
        child: Container(
          height: 100,
          width: 100,
          color: Colors.transparent,
          child: const Image(
              height: 100,
              width: 100,
              //color: Colors.transparent,
              fit: BoxFit.fill,
              image:AssetImage("assets/images/progresbar_images.gif")),

          //image:AssetImage("assets/images/progresbar_images.gif")),
        ),
      );
    },
  );

}

