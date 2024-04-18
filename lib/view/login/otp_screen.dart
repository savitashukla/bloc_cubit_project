import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshchat_sdk/freshchat_sdk.dart';
import 'package:freshchat_sdk/freshchat_user.dart';
import 'package:cubit_project/utils/help_method.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../data/route/Routes.dart';
import '../../res/AppColor.dart';
import '../../res/ImageRes.dart';
import '../../utils/logger_utils.dart';
import '../../utils/weight/help_weight.dart';
import '../../view_model/cubit/loot_box_cubit/loot_box_cubit.dart';

class OtpScreen extends StatefulWidget {
  String? phone;

  OtpScreen(this.phone);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController controller = TextEditingController();

  late final LootBoxCubit createStoriesCubit;

  String? enterOtp;

  @override
  void initState() {
    // TODO: implement initState

    createStoriesCubit = context.read<LootBoxCubit>();
    createStoriesCubit.secondValuesSet(60);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LootBoxCubit, LootBoxEquatable>(
          builder: (context, state) {
        return Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage(ImageRes().otpCoin))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HelpWeight().testMethod(16.0, FontWeight.w900,
                  AppColor().whiteColor, "AN OTP has been sent to"),
              const SizedBox(
                height: 3,
              ),
              HelpWeight().testMethod(16.0, FontWeight.w900,
                  AppColor().textColorLight, "+91-${widget.phone}"),
              const SizedBox(
                height: 34,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                      navigatorKey.currentState!.context, Routes.login);
                },
                child: HelpWeight().buttonCreateOnlyBorder("Change Number?",
                    AppColor().whiteColor, FontWeight.w900, 16),
              ),
              const SizedBox(
                height: 51,
              ),
              PinCodeTextField(
                showCursor: true,
                autoFocus: false,
                length: 6,
                controller: controller,
                obscureText: false,
                enableActiveFill: true,
                mainAxisAlignment: MainAxisAlignment.center,
                textStyle: TextStyle(
                    fontSize: 15,
                    fontFamily: "UltimaPro",
                    fontWeight: FontWeight.normal,
                    color: AppColor().whiteColor),
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                  borderWidth: 1.5,
                  fieldOuterPadding: const EdgeInsets.only(right: 10),
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  activeColor: AppColor().colorPrimaryLight,
                  inactiveColor: AppColor().colorPrimaryLight,
                  selectedColor: AppColor().colorPrimaryLight,
                  activeFillColor: AppColor().colorPrimaryLight,
                  inactiveFillColor: AppColor().colorPrimaryLight,
                  selectedFillColor: AppColor().colorPrimaryLight,
                  fieldHeight: 43,
                  fieldWidth: 43,
                ),
                animationType: AnimationType.fade,
                animationDuration: const Duration(milliseconds: 300),
                enablePinAutofill: true,
                onChanged: (code) {
                  HelpMethod().customPrint(code);
                  if (code.length == 6) {
                    enterOtp = code;

                    // controller.Otp.value = code;
                  }
                },
                onCompleted: (code) {
                  if (code.length == 6) {
                    enterOtp = code;
                  }
                },
                appContext: context,
              ),
              const SizedBox(
                height: 33,
              ),
              InkWell(
                onTap: () {
                  HelpMethod().customPrint(
                      "otpRequestId check${state.loginResponse!.otpRequestId}");
                  createStoriesCubit.onSubmitOtp(
                      state.loginResponse!.otpRequestId,
                      state.loginResponse!.userId,
                      enterOtp!);
                },
                child: HelpWeight().buttonCreate("VERIFY", 16.0,
                    AppColor().textColorLight, AppColor().buttonShadowC,AppColor().colorPrimary),
              ),
              const SizedBox(
                height: 55,
              ),
              state.secondV > 0
                  ? TweenAnimationBuilder<Duration>(
                      duration: Duration(seconds: state.secondV),
                      tween: Tween(
                          begin: Duration(seconds: state.secondV),
                          end: Duration.zero),
                      onEnd: () {
                        createStoriesCubit.secondValuesSet(00);

                        //   resendTrue.value = true;
                        //  Utils().customPrint('Timer ended');
                      },

                      builder: (BuildContext? context, Duration value,
                          Widget? child) {
                        String seconds = (value.inSeconds % 60)
                            .toInt()
                            .toString()
                            .padLeft(2, '0');
                        String minutes = ((value.inSeconds / 60) % 60)
                            .toInt()
                            .toString()
                            .padLeft(2, '0');

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Container(
                              width: 191,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: Color(0xfff19812), width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),

                              child: Row(

                                mainAxisAlignment: MainAxisAlignment.center,


                                children: [ Text("Resend OTP  ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "UltimaPro"
                                      ,
                                      fontSize: 16,
                                      color: AppColor().colorGrayDark,
                                      fontWeight: FontWeight.w900)),
                                Text("$minutes\:$seconds",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: AppColor().textColorLight,
                                        fontSize: 16,
                                        fontFamily: "UltimaPro",
                                        fontWeight: FontWeight.w900))],),
                            ),

                          ],
                        );
                      })
                  : InkWell(
                      onTap: () {
                        // createStoriesCubit = context.read<LootBoxCubit>();

                        createStoriesCubit.onResendOtp(
                            state.loginResponse!.userId, widget.phone!);
                      },
                      child: HelpWeight().buttonCreateOnlyBorder("Resend OTP",
                          AppColor().textColorLight, FontWeight.w900, 16),
                    ),
              const SizedBox(
                height: 54,
              ),
              InkWell(
                onTap: () async {
                  if (createStoriesCubit.state.publicSetting!.support != null &&
                      createStoriesCubit
                              .state.publicSetting!.support!.whatsappMobile !=
                          null) {
                    HelpMethod().openWhatsappOTPV(createStoriesCubit
                        .state.publicSetting!.support!.whatsappMobile);
                  } else {
                    try {
                      FreshchatUser freshchatUser = await Freshchat.getUser;
                      if (widget.phone != null) {
                        freshchatUser.setPhone("+91", "${widget.phone}");
                      }
                      Freshchat.setUser(freshchatUser);
                    } catch (e) {}
                    Freshchat.showFAQ();
                  }
                },
                child: HelpWeight().testMethod(16.0, FontWeight.w900,
                    AppColor().textColorLight, "Need Support?"),
              )
            ],
          ),
        );
      }),
    );
  }
}
