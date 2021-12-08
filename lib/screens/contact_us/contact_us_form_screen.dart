import 'package:flutter/material.dart';
import 'package:steuermachen/components/app_bar/appbar_with_side_corner_circle_and_body.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/dialogs/completed_dialog_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';

class ContactUsFormScreen extends StatefulWidget {
  const ContactUsFormScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsFormScreen> createState() => _ContactUsFormScreenState();
}

class _ContactUsFormScreenState extends State<ContactUsFormScreen> {
  _dialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CompletedDialogComponent(
          showBackBtn: true,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBarWithSideCornerCircleAndRoundBody(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 35,
                ),
                Text(StringConstants.getInTouch,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 24, fontWeight: FontWeight.w700)),
                const SizedBox(
                  height: 23,
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
                  StringConstants.email,
                  style: FontStyles.fontRegular(fontSize: 14),
                ),
                const SizedBox(
                  height: 4,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: StringConstants.email,
                    hintStyle: FontStyles.fontRegular(fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                TextComponent(
                  StringConstants.subject,
                  style: FontStyles.fontRegular(fontSize: 14),
                ),
                const SizedBox(
                  height: 4,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: StringConstants.subject,
                    hintStyle: FontStyles.fontRegular(fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                TextComponent(
                  StringConstants.phoneNo,
                  style: FontStyles.fontRegular(fontSize: 14),
                ),
                const SizedBox(
                  height: 4,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: StringConstants.phoneNo,
                    hintStyle: FontStyles.fontRegular(fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                TextComponent(
                  StringConstants.message,
                  style: FontStyles.fontRegular(fontSize: 14),
                ),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  height: 5 * 24.0,
                  child: TextFormField(
                    maxLines: 5,
                    decoration: InputDecoration(
                        hintText: StringConstants.message,
                        hintStyle: FontStyles.fontRegular(fontSize: 14),
                        isDense: true),
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
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: ButtonComponent(
          btnHeight: 75,
          buttonText: StringConstants.send,
          onPressed: () {
            _dialog();
          },
        ),
      ),
    );
  }
}
