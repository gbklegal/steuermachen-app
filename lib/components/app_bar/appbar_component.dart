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
  final bool? showNotificationIcon;
  final bool? showBottomLine;
  const AppBarComponent(
    this.text, {
    Key? key,
    this.overrideBackPressed,
    this.imageTitle,
    this.backgroundColor = ColorConstants.white,
    this.showBackButton = true,
    this.showNotificationIcon = true,
    this.showBottomLine = true,
    this.backText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(AppConstants.toolbarSize),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: showBottomLine! ? 2 : 0,
              color: ColorConstants.greyBottomBar
                  .withOpacity(showBottomLine! ? 0.2 : 0),
            ),
          ),
        ),
        child: AppBar(
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
        style: FontStyles.fontMedium(fontSize: 16, fontWeight: FontWeight.w400),
      );
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(AppConstants.toolbarSize);
}
