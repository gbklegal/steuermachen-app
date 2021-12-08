import 'package:flutter/material.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/text_progress_bar_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';

class FileTaxDoneOrderScreen extends StatelessWidget {
  const FileTaxDoneOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComponent(
        StringConstants.done,
        showBackButton: false,
        showNotificationIcon: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const SizedBox(height: 16),
            const TextProgressBarComponent(
              title: "${StringConstants.step} 5/5",
              progress: 1,
            ),
            const SizedBox(
              height: 48,
            ),
            Container(
              decoration: BoxDecoration(
                color: ColorConstants.formFieldBackground,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.only(
                  top: 25, bottom: 150, left: 15, right: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(AssetConstants.done),
                  const SizedBox(height: 10),
                  const Text(
                    StringConstants.thankYouForOrder,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    StringConstants.impRecEmail,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4, top: 10),
                            child: ButtonComponent(
                              btnHeight: 60,
                              buttonText: StringConstants.goToHome,
                              textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: ColorConstants.white),
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    RouteConstants.bottomNavBarScreen,
                                    (val) => false);
                              },
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4, top: 10),
                            child: ButtonComponent(
                              btnHeight: 60,
                              buttonText: StringConstants.orderNew,
                              textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: ColorConstants.white),
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pushNamed(context,
                                    RouteConstants.maritalStatusScreen);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
