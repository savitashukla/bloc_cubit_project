import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cubit_project/res/AppColor.dart';
import 'package:cubit_project/utils/help_method.dart';
import 'package:cubit_project/utils/weight/help_weight.dart';
import 'package:cubit_project/view_model/cubit/loot_box_cubit/loot_box_cubit.dart';
import 'package:cubit_project/view_model/cubit/wallet/wallet_cubit.dart';

import '../../res/ImageRes.dart';

class AppbarCustom extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final bool? menuicon;
  final bool? iconnotifiction;
  final bool? is_supporticon;
  final bool? is_whatsappicon;
  final bool? menuback;
  final bool? is_wallaticon;
  final Widget? child;
  final Function? onPressed;
  final Function? onTitleTapped;

  @override
  final Size preferredSize;

  //const TopBar({Key key}) : super(key: key);
  AppbarCustom(
      {@required this.title,
      @required this.menuicon,
      @required this.menuback,
      this.iconnotifiction,
      this.is_wallaticon,
      this.is_supporticon,
      this.is_whatsappicon,
      this.child,
      this.onPressed,
      this.onTitleTapped})
      : preferredSize = Size.fromHeight(60.0);

  @override
  State<AppbarCustom> createState() => _AppbarCustomState();
}

class _AppbarCustomState extends State<AppbarCustom>
    with TickerProviderStateMixin {
  Tween<double> _tween = Tween(begin: .85, end: 1.1);
  bool isAnimationActive = false;

  WalletCubit? walletCubit;

  //bool isNormalWidget=false;

  @override
  dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();


    walletCubit = context.read<WalletCubit>();

    walletCubit!.init();

    //_controller.repeat(reverse: false);

    //coin animation work
    /*if (AppString.isUserFTR.value == true && AppString.helperCountAnimation == 0) {
      Future.delayed(const Duration(milliseconds: 5000), () {
        isAnimationActive = true;
        _controller.forward();
        setState(() {});
        AppString.helperCountAnimation++;
      });
    }*/

    /*Future.delayed(const Duration(milliseconds: 5500), () {
      isAnimationActive = false;
      setState(() {});
    });*/

    //_controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: BlocBuilder<LootBoxCubit, LootBoxEquatable>(
      builder: (context, state) {
        return SizedBox(
            height: 60,
            child: Container(
              padding: EdgeInsets.all(5),
              //color:AppColor().colorPrimary,
              //color: Colors.red,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: AssetImage(ImageRes().topBg))),

              // color: AppColor().colorPrimary,
              child: state.currentIndex == 4
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: HelpWeight().testMethod(
                              40.0,
                              FontWeight.w700,
                              AppColor().textColorLight,
                              "Earnzo"),
                        ),
                    ],
                  )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 18),
                          child: Center(
                            child: HelpWeight().testMethod(
                                40.0,
                                FontWeight.w700,
                                AppColor().textColorLight,
                                "Earnzo"),
                          ),
                        ),
                        InkWell(
                          onTap: (){



                            if(context.read<LootBoxCubit>().state.onlyNumber!.compareTo("9829953786")==0)
                            {
                           //   Fluttertoast.showToast(msg: "Under Maintenance");
                            }
                            else
                            {
                              context.read<LootBoxCubit>().changeIndex(4);

                            }



                          },
                          child: Container(
                            //  width:110,
                              height: 37,
                              margin: EdgeInsets.only(right: 15),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                  border: Border.all(
                                      color: const Color(0xffe3e3e3),
                                      width: 3),
                                  color: const Color(0xff1a8415)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12),
                                    child: Image(
                                        width: 22,
                                        height: 22,
                                        image: AssetImage(
                                            ImageRes().lootCoinIcon)),
                                  ),
                                  Padding(
                                    padding:  const EdgeInsets.only(left: 7,top: 4,right: 7),
                                    child: walletCubit!.state.walletCoin != null? Text(
                                      '${walletCubit!.state.walletCoin!.balance!>1000?HelpMethod.replace3digit(walletCubit!.state.walletCoin!.balance):walletCubit!.state.walletCoin!.balance}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontFamily: "UltimaPro",
                                        color: AppColor().whiteColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ):Text(
                                      '0',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontFamily: "UltimaPro",
                                        color: AppColor().whiteColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )

                                    /*HelpWeight().testMethod(
                                        20.0,

                                        FontWeight.w700,
                                        AppColor().whiteColor,
                                        "75")*/,
                                  )
                                ],
                              )),
                        )
                      ],
                    ),
            ));
      },
    ));
  }
}
