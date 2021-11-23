import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:steuermachen/constants/app_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/style/font_styles_constants.dart';

class AppBarComponent extends StatelessWidget {
  final Function()? overrideBackPressed;
  final String? text;

  const AppBarComponent(
    this.text, {
    Key? key,
    this.overrideBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(AppConstants.toolbarSize),
      child: AppBar(
        backgroundColor: ColorConstants.white,
        title: Text(
          text ?? "",
          style: FontStyles.fontRegular(fontSize: 16),
        ),
        // iconTheme: ,
        titleSpacing: -5,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: ColorConstants.black,
          ),
          onPressed: () {
            /*  overrideBackPressed == null
                ? Get.back()
                : overrideBackPressed!(); */
          },
        ),
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark),
      ),
    );
  }
}
