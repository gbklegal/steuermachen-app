import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:steuermachen/components/app_bar/appbar_with_side_corner_circle_and_body.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
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
    path: 'smith@example.com',
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
    return AppBarWithSideCornerCircleAndRoundBody(body: _mainBody(context));
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
        Text(LocaleKeys.howCanWeHelpYou.tr(),
            style:
                Theme.of(context).textTheme.headline6!.copyWith(fontSize: 24)),
        const SizedBox(
          height: 10,
        ),
        Text(LocaleKeys.getInTouchWithUs.tr(),
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
              child: _emailAndCallUs(
                  context, AssetConstants.email, LocaleKeys.emailUs.tr()),
            ),
            const SizedBox(
              width: 40,
            ),
            InkWell(
              onTap: () async {
                await _makePhoneCall("03092783699");
              },
              child: _emailAndCallUs(
                  context, AssetConstants.phoneCall, LocaleKeys.callUs.tr()),
            ),
          ],
        ),
        const SizedBox(
          height: 23,
        ),
        Text(
            "${LocaleKeys.orUseOur.tr()} ${LocaleKeys.contactUs.tr()} ${LocaleKeys.form.tr()}",
            style:
                Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 15)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 15),
          child: ElevatedButton(
            style: ElevatedButtonTheme.of(context).style?.copyWith(
                  minimumSize: MaterialStateProperty.all(
                    Size(MediaQuery.of(context).size.width, 55),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all(ColorConstants.toxicGreen),
                ),
            onPressed: () {
              Navigator.pushNamed(context, RouteConstants.contactUsFormScreen);
            },
            child: Text(
              LocaleKeys.contactForm.tr(),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ],
    );
  }

  Container _emailAndCallUs(
      BuildContext context, String assetName, String btnName) {
    return Container(
      width: 130,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xffF1F6FC),
          boxShadow: [
            BoxShadow(
                color: ColorConstants.black.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2))
          ]),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Column(
        children: [
          Image.asset(assetName),
          const SizedBox(
            height: 15,
          ),
          Text(btnName,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 20)),
        ],
      ),
    );
  }
}
