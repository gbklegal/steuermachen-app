import 'package:flutter/material.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/components/text_progress_bar_component.dart';
import 'package:steuermachen/constants/app_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/utils/input_validation_util.dart';

class FileTaxInfoScreen extends StatefulWidget {
  FileTaxInfoScreen({Key? key}) : super(key: key);

  @override
  _FileTaxInfoScreenState createState() => _FileTaxInfoScreenState();
}

class _FileTaxInfoScreenState extends State<FileTaxInfoScreen>
    with InputValidationUtil {
  final TextEditingController _firstNameController =
      TextEditingController(text: "Osama");
  final TextEditingController _surNameController =
      TextEditingController(text: "Asif");
  final TextEditingController _emailController =
      TextEditingController(text: "osama.asif20@gmail.com");
  final TextEditingController _subjectController =
      TextEditingController(text: "testing subject");
  final TextEditingController _phoneNoController =
      TextEditingController(text: "03092783699");
  final TextEditingController _messageController =
      TextEditingController(text: "testing message");
  final GlobalKey<FormState> _userInfoFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
     const sizedBox4 = SizedBox(
      height: 4,
    );
    const sizedBox6 = SizedBox(
      height: 6,
    );
    final fontStyle = FontStyles.fontRegular(fontSize: 14);
    return Scaffold(
      appBar: const AppBarComponent(
        StringConstants.fillInfo,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const TextProgressBarComponent(
                title: "${StringConstants.step} 4/5",
                progress: 0.8,
              ),
              const SizedBox(
                height: 62,
              ),
              TextComponent(
                StringConstants.surName,
                style: fontStyle,
              ),
             sizedBox4,
              TextFormField(
                decoration: InputDecoration(
                  hintText: StringConstants.enterTitle,
                  hintStyle: fontStyle,
                ),
              ),
              sizedBox6,
              TextComponent(
                StringConstants.firstName,
                style: fontStyle,
              ),
              sizedBox4,
              TextFormField(
                decoration: InputDecoration(
                  hintText: StringConstants.enterTitle,
                  hintStyle: fontStyle,
                ),
              ),
             sizedBox6,
              TextComponent(
                StringConstants.email,
                style: fontStyle,
              ),
              sizedBox4,
              TextFormField(
                decoration: InputDecoration(
                  hintText: StringConstants.enterTitle,
                  hintStyle: fontStyle,
                ),
              ),
              sizedBox6,
              TextComponent(
                StringConstants.road,
                style: fontStyle,
              ),
              sizedBox4,
              TextFormField(
                decoration: InputDecoration(
                  hintText: StringConstants.enterTitle,
                  hintStyle: fontStyle,
                ),
              ),
             sizedBox4,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  sizedBox6,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextComponent(
                          StringConstants.houseNo,
                          style: fontStyle,
                        ),
                       sizedBox4,
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: StringConstants.enterTitle,
                            hintStyle: fontStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextComponent(
                          StringConstants.postcode,
                          style: fontStyle,
                        ),
                      sizedBox4,
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: StringConstants.enterTitle,
                            hintStyle: fontStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              sizedBox4,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  sizedBox6,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextComponent(
                          StringConstants.place,
                          style: fontStyle,
                        ),
                       sizedBox4,
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: StringConstants.enterTitle,
                            hintStyle: fontStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextComponent(
                          StringConstants.phoneNo,
                          style: fontStyle,
                        ),
                        sizedBox4,
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: StringConstants.enterTitle,
                            hintStyle: fontStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: AppConstants.bottomBtnPadding,
        child: ButtonComponent(
          btnHeight: 56,
          buttonText: StringConstants.next.toUpperCase(),
          textStyle:
              FontStyles.fontRegular(color: ColorConstants.white, fontSize: 18),
          onPressed: () {
            Navigator.pushNamed(context, RouteConstants.selectDocumentForScreen,
                arguments: {
                  "showNextBtn": true,
                  "nextRoute": RouteConstants.fileTaxFinalSubmissionScreen
                });
          },
        ),
      ),
    );
  }
}
