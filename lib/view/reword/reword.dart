import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cubit_project/model/profile_data.dart';
import 'package:cubit_project/utils/help_method.dart';
import 'package:cubit_project/view_model/cubit/gamezop_game_list/gamezop_event_list_cubit.dart';
import 'package:cubit_project/view_model/cubit/gamezop_game_list/gamezop_event_list_equatable.dart';
import 'package:whatsapp_share/whatsapp_share.dart';

import '../../res/AppColor.dart';
import '../../res/ImageRes.dart';
import '../../utils/bridge.dart';
import '../../utils/weight/help_weight.dart';

class Reword extends StatefulWidget {
  const Reword({Key? key}) : super(key: key);

  @override
  State<Reword> createState() => _RewordState();
}

class _RewordState extends State<Reword> {
  GamezopEventListCubit? gamezopEventListCubit;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gamezopEventListCubit = context.read<GamezopEventListCubit>();
    gamezopEventListCubit!.init();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<GamezopEventListCubit,GamezopEventListEquatable>(
        builder: (context,state) {
          return Scaffold(
              backgroundColor: Colors.transparent,
             /* appBar: AppBar(
                flexibleSpace: Image(
                  image: AssetImage(ImageRes().topBg),
                  height: 55,
                  fit: BoxFit.cover,
                ),
                backgroundColor: Colors.transparent,
                title: Center(
                    child: Padding(
                  padding: const EdgeInsets.only(right: 60),
                  child: HelpWeight().testMethod(
                      40.0, FontWeight.w700, AppColor().textColorLight, "Earnzo"),
                )),
              ),*/
              body: Container(
                color: AppColor().colorPrimary,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20,left: 8,right: 8),
                      width: MediaQuery.of(context).size.width,
                      height: 137.028,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: AssetImage(ImageRes().rewordBanner))),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 262,
                      margin: EdgeInsets.only(left: 15,right: 15),
                      decoration: BoxDecoration(
                        color: AppColor().colorPrimaryLight2,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                       // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 22),
                          HelpWeight().testMethod(20.0, FontWeight.w700,
                              AppColor().whiteColor, "REFER FRIEND"),

                          const SizedBox(height: 36),
                          HelpWeight().testMethod(
                              20.0,
                              FontWeight.w900,
                              AppColor().whiteColor,
                              "Invite Friends & Earn Free Coins"),

                          const SizedBox(height: 9),
                          HelpWeight().testMethod(
                              15.0,
                              FontWeight.w400,
                              AppColor().colorPrimaryLightMore,
                              "Copy your code, share it with your friends"),

                          const SizedBox(height: 20),
                          HelpWeight().testMethod(
                              15.0,
                              FontWeight.w400,
                              AppColor().colorPrimaryLightMore,
                              "Your personal code"),

                          const SizedBox(height: 10),
                          Container(
                            height: 45,
                            margin: const EdgeInsets.symmetric(horizontal: 50),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: AppColor().colorPrimaryLight),
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              color: Colors.white,
                              radius: Radius.circular(15),
                              strokeWidth: 1.0,
                              dashPattern: [5, 3],
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      "${getUserReferalCode(state.profileDataC)}",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                          fontFamily: "UltimaPro",
                                          color: AppColor().whiteColor),
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap: () {
                                      Clipboard.setData(ClipboardData(
                                          text:getUserReferalCode(state.profileDataC)));
                                      Fluttertoast.showToast(
                                          msg: "Code copied successfully");
                                      /*   Clipboard.setData(ClipboardData(
                                          text: _userController
                                              .getUserReferalCode()));
                                      Fluttertoast.showToast(
                                          msg: "Code copied successfully");*/
                                    },
                                    child: Container(
                                      width: 90,
                                      margin: const EdgeInsets.only(top: 4,bottom: 4,right: 3),
                                      height: MediaQuery.of(context).size.height,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: AppColor().textColorLight),
                                      padding: const EdgeInsets.only(right: 0),
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 0),
                                        child: Center(
                                          child: Text(
                                            "Copy",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w900,
                                                fontFamily: "UltimaPro",
                                                color: AppColor().whiteColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    HelpWeight().testMethod(15.0, FontWeight.w400,
                        AppColor().colorPrimaryLightMore, "OR"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            String urlCall =
                                "https://gmng.onelink.me/GRb6?af_xp=app&pid=Cross_sale&c=Referral%20code%20pre-fill&is_retargeting=true&af_dp=gmng%3A%2F%2F&referral_code=${state.profileDataC}";
                            var encoded = Uri.encodeFull(urlCall);

                            await WhatsappShare.share(
                                text:
                                "Bro Mere link se GMNG app download kar  Hum dono ko 10-10 rs "
                                    "cash milengy or fir dono sath me khelenge. Mera refer code dalna mat bhulna. code - ${getUserReferalCode(state.profileDataC)}",
                                linkUrl: encoded,
                                phone: "9555775577");
                          },
                          child: const Padding(
                              padding: EdgeInsets.all(5),
                              child: Image(
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                                image: AssetImage('assets/images/whatsapp.png'),
                              )),
                        ),
                        GestureDetector(
                          onTap: () {


                            String urlCall =
                                "https://gmng.onelink.me/GRb6?af_xp=app&pid=Cross_sale&c=Referral%20code%20pre-fill&is_retargeting=true&af_dp=gmng%3A%2F%2F&referral_code=${getUserReferalCode(state.profileDataC)}";
                            var encoded = Uri.encodeFull(urlCall);
                            HelpMethod().shareTelegram(
                                "Bro Mere link se GMNG app download kar $encoded Hum dono ko 10-10 rs "
                                    "cash milengy or fir dono sath me khelenge. Mera refer code dalna mat bhulna. code - ${getUserReferalCode(state.profileDataC)}");
                          },
                          child: const Padding(
                              padding: EdgeInsets.all(5),
                              child: Image(
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                                image: AssetImage('assets/images/telegram.png'),
                              )),
                        ),
                        GestureDetector(
                          onTap: () {


                            String urlCall =
                                "https://gmng.onelink.me/GRb6?af_xp=app&pid=Cross_sale&c=Referral%20code%20pre-fill&is_retargeting=true&af_dp=gmng%3A%2F%2F&referral_code=${getUserReferalCode(state.profileDataC)}";
                            var encoded = Uri.encodeFull(urlCall);

                            NativeBridge().OpenInstagram(
                                "Bro Mere link se GMNG app download kar $encoded Hum dono ko 10-10 rs cash milengy or fir dono sath me khelenge. Mera refer code dalna mat bhulna. code - ${getUserReferalCode(state.profileDataC)}");


                          },
                          child: const Padding(
                              padding: EdgeInsets.all(5),
                              child: Image(
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                                image: AssetImage('assets/images/instagram.png'),
                              )),
                        ),
                        GestureDetector(
                          onTap: () {

                            String urlCall =
                                "https://gmng.onelink.me/GRb6?af_xp=app&pid=Cross_sale&c=Referral%20code%20pre-fill&is_retargeting=true&af_dp=gmng%3A%2F%2F&referral_code=${getUserReferalCode(state.profileDataC)}";
                            var encoded = Uri.encodeFull(urlCall);

                            HelpMethod().funShareS(
                                "Bro Mere link se GMNG app download kar $encoded Hum dono ko 10-10 rs "
                                    "cash milengy or fir dono sath me khelenge. Mera refer code dalna mat bhulna. code - ${getUserReferalCode(state.profileDataC)}");

                          },
                          child: const Padding(
                              padding: EdgeInsets.all(5),
                              child: Image(
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                                image: AssetImage('assets/images/messenger.png'),
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ));
        }
      ),
    );
  }

  String getUserReferalCode(ProfileDataR? profileDataRes) {
    String referral_code = "";
    if (profileDataRes != null &&
        profileDataRes.referral != null &&
        profileDataRes.referral!.length > 0) {
      for (int index=0;profileDataRes.referral!.length>index;index++) {
        if (profileDataRes.referral![index].isActive==true) {
          referral_code = profileDataRes.referral![index].code!;
        }
      }
    }
    return referral_code;
  }
}
