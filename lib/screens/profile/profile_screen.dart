import 'package:flutter/material.dart';
import 'package:steuermachen/components/app_bar/appbar_with_side_corner_circle_and_body.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/constants/app_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBarWithSideCornerCircleAndRoundBody(
        showNotificationIcon: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 35,
                ),
                TextComponent(
                  StringConstants.surName,
                  style: FontStyles.fontRegular(fontSize: 14),
                ),
                const SizedBox(
                  height: 4,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: StringConstants.surName,
                    hintStyle: FontStyles.fontRegular(fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                TextComponent(
                  StringConstants.firstName,
                  style: FontStyles.fontRegular(fontSize: 14),
                ),
                const SizedBox(
                  height: 4,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: StringConstants.firstName,
                    hintStyle: FontStyles.fontRegular(fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                TextComponent(
                  StringConstants.street,
                  style: FontStyles.fontRegular(fontSize: 14),
                ),
                const SizedBox(
                  height: 4,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: StringConstants.street,
                    hintStyle: FontStyles.fontRegular(fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                TextComponent(
                  StringConstants.postalCode,
                  style: FontStyles.fontRegular(fontSize: 14),
                ),
                const SizedBox(
                  height: 4,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: StringConstants.postalCode,
                    hintStyle: FontStyles.fontRegular(fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                TextComponent(
                  StringConstants.cityTown,
                  style: FontStyles.fontRegular(fontSize: 14),
                ),
                const SizedBox(
                  height: 4,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: StringConstants.cityTown,
                    hintStyle: FontStyles.fontRegular(fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                TextComponent(
                  StringConstants.selectCountry,
                  style: FontStyles.fontRegular(fontSize: 14),
                ),
                const SizedBox(
                  height: 4,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: StringConstants.selectCountry,
                    hintStyle: FontStyles.fontRegular(fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: AppConstants.bottomBtnPadding,
        child: ButtonComponent(
          btnHeight: 56,
          buttonText: StringConstants.save,
          onPressed: () {
            // Navigator.pushNamed(context, RouteConstants.fileTaxUploadDocScreen);
          },
        ),
      ),
    );
  }
}
