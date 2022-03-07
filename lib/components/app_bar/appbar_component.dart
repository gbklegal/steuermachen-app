import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/constants/app_constants.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/providers/language_provider.dart';

class AppBarComponent extends StatelessWidget with PreferredSizeWidget {
  final Function()? overrideBackPressed;
  final String? text;
  final String? backText;
  final String? imageTitle;
  final Color backgroundColor;
  final bool? showBackButton;
  final bool? showPersonIcon;
  final bool? showBottomLine;
  final bool? centerTitle;
  final PreferredSizeWidget? bottom;
  final double appBarHeight;
  const AppBarComponent(
    this.text, {
    Key? key,
    this.overrideBackPressed,
    this.imageTitle,
    this.backgroundColor = ColorConstants.white,
    this.showBackButton = true,
    this.showPersonIcon = true,
    this.showBottomLine = true,
    this.backText,
    this.bottom,
    this.appBarHeight = AppConstants.toolbarSize,
    this.centerTitle = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(AppConstants.toolbarSize),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: showBottomLine! ? 0.2 : 0,
              color: ColorConstants.black.withOpacity(showBottomLine! ? 1 : 0),
            ),
          ),
        ),
        child: Consumer<LanguageProvider>(builder: (context, consumer, child) {
          return AppBar(
            backgroundColor: backgroundColor,
            title: _title(),
            leadingWidth: 90,
            // iconTheme: ,
            titleSpacing: -5,
            elevation: 0,
            leading: Visibility(
              visible: showBackButton!,
              child: InkWell(
                onTap: () {
                  /*  overrideBackPressed == null
                                ? Get.back()
                                : overrideBackPressed!(); */
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: ColorConstants.black,
                      ),
                    ),
                    TextComponent(
                      backText ?? LocaleKeys.back.tr(),
                      style: const TextStyle(
                          color: ColorConstants.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 17),
                    )
                  ],
                ),
              ),
            ),
            centerTitle: centerTitle,
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark),
            actions: [
              Visibility(
                visible: showPersonIcon!,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15, top: 5),
                  child: SvgPicture.asset(AssetConstants.icPerson),
                ),
              ),
            ],
            bottom: bottom,
          );
        }),
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
            const SizedBox(width: 5),
            TextComponent(
              text ?? "",
              style: FontStyles.fontBold(
                  fontSize: (context.locale == const Locale('en')) ? 20 : 20),
            )
          ],
        );
      });
    }
    return Consumer<LanguageProvider>(builder: (context, consumer, child) {
      return Padding(
        padding: const EdgeInsets.only(left: 5, bottom: 2),
        child: TextComponent(
          text ?? "",
          style: FontStyles.fontMedium(
              fontSize: (context.locale == const Locale('en')) ? 16 : 14,
              fontWeight: FontWeight.w600),
        ),
      );
    });
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}
