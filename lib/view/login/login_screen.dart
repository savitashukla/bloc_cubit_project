import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cubit_project/res/ImageRes.dart';
import 'package:cubit_project/view_model/cubit/loot_box_cubit/loot_box_cubit.dart';

import '../../res/AppColor.dart';
import '../../utils/weight/help_weight.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController controller = TextEditingController();

  late final LootBoxCubit createStoriesCubit;

  @override
  void initState() {
    createStoriesCubit = context.read<LootBoxCubit>();
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage(ImageRes().loginScreen))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 48),
              child: Image(image: AssetImage(ImageRes().loginCoin)),
            ),
            const SizedBox(
              height: 15,
            ),
            HelpWeight().testMethod(
                80.0, FontWeight.w700, AppColor().textColorLight, "Earnzo"),
            const SizedBox(
              height: 25,
            ),
            _editTitleTextFieldNumber(),
            const SizedBox(
              height: 27,
            ),
            InkWell(
              onTap: () {
                createStoriesCubit.onSubmitLogin(controller.text);
                //  Navigator.pushNamed(context, Routes.otpScreen);
              },
              child: HelpWeight().buttonCreate("LOGIN", 16.0,AppColor().textColorLight,AppColor().buttonShadowC,AppColor().colorPrimary),
            )
          ],
        ),
      ),
    );
  }

  // call weight
  Widget _editTitleTextFieldNumber() {
    controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length));
    return Container(
      // padding: EdgeInsets.only(bottom: 0),
      margin: const EdgeInsets.symmetric(horizontal: 25),
      height: 52,

      child: TextField(
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.bottom,
        onTap: () {},

        controller: controller,
        style: TextStyle(color: AppColor().colorGray, fontFamily: "UltimaPro"),
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(10),
        ],
        decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,


            fillColor: AppColor().colorPrimaryLight,
            hintStyle: TextStyle(
              color: AppColor().whiteColor,
              fontFamily: "UltimaPro",
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide:
                  BorderSide(color: AppColor().colorPrimaryLight, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide:
                  BorderSide(color: AppColor().colorPrimaryLight, width: 1.5),
            ),
            hintText: "Enter Phone Number"),
        onChanged: (text) {


          //  Utils().customPrint("First text field: $text");
        },
        autofocus: false,
      ),
    );
  }
}
