import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/constants/app_constants.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/providers/language_provider.dart';

class AppBarComponent extends StatelessWidget with PreferredSizeWidget {
  final Function()? overrideBackPressed;
  final String? text;
  final String? imageTitle;
  final Color backgroundColor;
  final bool? showBackButton;
  final bool? showNotificationIcon;
  const AppBarComponent(
    this.text, {
    Key? key,
    this.overrideBackPressed,
    this.imageTitle,
    this.backgroundColor = ColorConstants.white,
    this.showBackButton = true,
    this.showNotificationIcon = false,
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
        leading: Visibility(
          visible: showBackButton!,
          child: Row(
            children: [
              IconButton(
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
              // const Text(StringConstants.back)
            ],
          ),
        ),
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark),
        actions: [
          Visibility(
            visible: showNotificationIcon!,
            child: Padding(
              padding: const EdgeInsets.only(right: 15, top: 5),
              child: SvgPicture.asset(AssetConstants.icNotification),
            ),
          ),
        ],
      ),
    );
  }

  Widget _title() {
    if (imageTitle != null) {
      return Consumer<LanguageProvider>(builder: (context, consumer, child) {
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
      });
    }
    return Consumer<LanguageProvider>(builder: (context, consumer, child) {
      return Text(
        text ?? "",
        style: FontStyles.fontMedium(fontSize: 16, fontWeight: FontWeight.w600),
      );
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(AppConstants.toolbarSize);
}
