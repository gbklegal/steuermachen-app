import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';

class SelectDocumentForScreen extends StatelessWidget {
  const SelectDocumentForScreen({Key? key}) : super(key: key);

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
                    Flexible(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Text(
                            StringConstants.document,
                            style: FontStyles.fontBold(fontSize: 24),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Image.asset(AssetConstants.submitDocument),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            ElevatedButton(
                              style: ElevatedButtonTheme.of(context)
                                  .style
                                  ?.copyWith(
                                    minimumSize: MaterialStateProperty.all(
                                      Size(MediaQuery.of(context).size.width, 70),
                                    ),
                                  ),
                              onPressed: () {},
                              child: const Text(
                                StringConstants.useCamera,
                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.normal),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
