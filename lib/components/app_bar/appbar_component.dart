import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:steuermachen/constants/app_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';

class AppBarComponent extends StatelessWidget with PreferredSizeWidget {
  final Function()? overrideBackPressed;
  final String? text;
  final String? imageTitle;
  final Color backgroundColor;
  const AppBarComponent(
    this.text, {
    Key? key,
    this.overrideBackPressed,
    this.imageTitle,
    this.backgroundColor = ColorConstants.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(AppConstants.toolbarSize),
      child: AppBar(
        backgroundColor: backgroundColor,
        title: _title(),
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
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark),
      ),
    );
  }

  Widget _title() {
    if (imageTitle != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            imageTitle!,
            height: 28,
          ),
          const SizedBox(width: 10),
          Text(
            text ?? "",
            style: FontStyles.fontBold(fontSize: 24),
          )
        ],
      );
    }
    return Text(
      text ?? "",
      style: FontStyles.fontRegular(fontSize: 16),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(AppConstants.toolbarSize);
}
