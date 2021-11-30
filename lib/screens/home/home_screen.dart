import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const AppBarComponent(
        StringConstants.appName,
        imageTitle: AssetConstants.logo,
        backgroundColor: Colors.transparent,
        showBackButton: false,
        showNotificationIcon: true,
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                ),
                color: ColorConstants.formFieldBackground),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset(AssetConstants.topRightRoundCircle),
                ),
                Image.asset(AssetConstants.homeLaptop),
                Padding(
                  padding: const EdgeInsets.only(left: 45, right: 30),
                  child: Text(
                    StringConstants.howWouldYouLikeToMoveForwardWithUs,
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontWeight: FontWeight.w700, fontSize: 28),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(right: 15, bottom: 20),
                  child: Text(
                    "Select catogorie suitable to you",
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontWeight: FontWeight.w400, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Container(
                color: ColorConstants.toxicGreen,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(AssetConstants.icDocument),
                          const SizedBox(width: 15),
                          Text(
                            "Have Tax done online",
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                    fontWeight: FontWeight.w400, fontSize: 20),
                          ),
                        ],
                      ),
                      SvgPicture.asset(AssetConstants.icExclamation),
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}
