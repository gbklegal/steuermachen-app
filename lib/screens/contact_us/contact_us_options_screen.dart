import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:steuermachen/components/app_bar/appbar_with_side_corner_circle_and_body.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsOptionScreen extends StatefulWidget {
  const ContactUsOptionScreen({Key? key}) : super(key: key);

  @override
  _ContactUsOptionScreenState createState() => _ContactUsOptionScreenState();
}

class _ContactUsOptionScreenState extends State<ContactUsOptionScreen> {
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'dialog@steuermachen.de',
  );

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  @override
  Widget build(BuildContext context) {
    return AppBarWithSideCornerCircleAndRoundBody(
      body: _mainBody(context),
    );
  }

  Column _mainBody(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 35,
        ),
        Image.asset(AssetConstants.contactUs),
        const SizedBox(
          height: 24,
        ),
        TextComponent(LocaleKeys.whatCanWeDoForYou,
            style:
                Theme.of(context).textTheme.headline5!.copyWith(fontSize: 24)),
        const SizedBox(
          height: 10,
        ),
        TextComponent(LocaleKeys.contactUs,
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 20)),
        const SizedBox(
          height: 23,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                await launch(emailLaunchUri.toString());
              },
              child: _contactOptions(
                  context, AssetConstants.icSend, LocaleKeys.emailToUs),
            ),
            const SizedBox(
              width: 40,
            ),
            InkWell(
              onTap: () async {
                await _makePhoneCall("0911-80190910");
              },
              child: _contactOptions(
                  context, AssetConstants.icChat, LocaleKeys.chatWithExpert),
            ),
          ],
        ),
        const SizedBox(
          height: 23,
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, RouteConstants.contactUsFormScreen);
          },
          child: _contactOptions(
              context, AssetConstants.icChat, LocaleKeys.useOurContactForm),
        ),
      ],
    );
  }

  Container _contactOptions(
      BuildContext context, String assetName, String btnName) {
    return Container(
      width: 130,
      height: (context.locale == const Locale('en')) ? 130 : 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xffF1F6FC),
        boxShadow: [
          BoxShadow(
              color: ColorConstants.black.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2))
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          SvgPicture.asset(assetName),
          const SizedBox(
            height: 5,
          ),
          Flexible(
            child: TextComponent(
              btnName,
              style: FontStyles.fontRegular(fontSize: 13),
              // overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
