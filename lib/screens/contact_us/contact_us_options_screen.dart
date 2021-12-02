import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';

class ContactUsOptionScreen extends StatefulWidget {
  const ContactUsOptionScreen({Key? key}) : super(key: key);

  @override
  _ContactUsOptionScreenState createState() => _ContactUsOptionScreenState();
}

class _ContactUsOptionScreenState extends State<ContactUsOptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const AppBarComponent(
        StringConstants.appName,
        imageTitle: AssetConstants.logo,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(AssetConstants.topRightRoundCircle),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 110),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: ColorConstants.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 1,
                    spreadRadius: 1,
                    color: ColorConstants.black.withOpacity(0.05),
                  ),
                ],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 35,
                    ),
                    Image.asset(AssetConstants.contactUs),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(StringConstants.howCanWeHelpYou,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontSize: 24)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(StringConstants.getInTouchWithUs,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 20)),
                    const SizedBox(
                      height: 23,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _emailAndCallUs(context, AssetConstants.email,
                            StringConstants.emailUs),
                        const SizedBox(
                          width: 40,
                        ),
                        _emailAndCallUs(context, AssetConstants.phoneCall,
                            StringConstants.callUs),
                      ],
                    ),
                    const SizedBox(
                      height: 23,
                    ),
                    Text(
                        "${StringConstants.orUseOur} ${StringConstants.contactUs} ${StringConstants.form}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(fontSize: 15)),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 55, vertical: 15),
                      child: ElevatedButton(
                        style: ElevatedButtonTheme.of(context).style?.copyWith(
                              minimumSize: MaterialStateProperty.all(
                                Size(MediaQuery.of(context).size.width, 55),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                  ColorConstants.toxicGreen),
                            ),
                        onPressed: () {},
                        child: const Text(
                          StringConstants.chatWithUs,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _emailAndCallUs(
      BuildContext context, String assetName, String btnName) {
    return Container(
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
