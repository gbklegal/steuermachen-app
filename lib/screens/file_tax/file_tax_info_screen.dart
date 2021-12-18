import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/components/text_progress_bar_component.dart';
import 'package:steuermachen/constants/app_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/providers/tax_file_provider.dart';
import 'package:steuermachen/utils/input_validation_util.dart';

class FileTaxInfoScreen extends StatefulWidget {
  const FileTaxInfoScreen({Key? key}) : super(key: key);

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
  final TextEditingController _roadController =
      TextEditingController(text: "testing subject");
  final TextEditingController _phoneNoController =
      TextEditingController(text: "03092783699");
  final TextEditingController _houseNoController =
      TextEditingController(text: "testing message");
  final TextEditingController _postalCodeController =
      TextEditingController(text: "testing message");
  final TextEditingController _placeController =
      TextEditingController(text: "testing message");
  final GlobalKey<FormState> _userInfoFormKey = GlobalKey<FormState>();
  late TaxFileProvider taxFileProvider;
  @override
  void initState() {
    super.initState();
    taxFileProvider = Provider.of<TaxFileProvider>(context, listen: false);
  }

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
      appBar:  AppBarComponent(
        LocaleKeys.fillInfo.tr(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 25),
          child: Form(
            key: _userInfoFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                 TextProgressBarComponent(
                  title: "${LocaleKeys.step.tr()} 4/5",
                  progress: 0.8,
                ),
                const SizedBox(
                  height: 62,
                ),
                _title(LocaleKeys.surName.tr()),
                sizedBox4,
                TextFormField(
                    controller: _surNameController,
                    decoration: InputDecoration(
                      hintText: LocaleKeys.surName.tr(),
                      hintStyle: fontStyle,
                    ),
                    validator: validateFieldEmpty),
                sizedBox6,
                _title(LocaleKeys.firstName.tr()),
                sizedBox4,
                TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      hintText: LocaleKeys.firstName.tr(),
                      hintStyle: fontStyle,
                    ),
                    validator: validateFieldEmpty),
                sizedBox6,
                _title(LocaleKeys.email.tr()),
                sizedBox4,
                TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: LocaleKeys.email.tr(),
                      hintStyle: fontStyle,
                    ),
                    validator: validateFieldEmpty),
                sizedBox6,
                _title(LocaleKeys.road.tr()),
                sizedBox4,
                TextFormField(
                    controller: _roadController,
                    decoration: InputDecoration(
                      hintText: LocaleKeys.road.tr(),
                      hintStyle: fontStyle,
                    ),
                    validator: validateFieldEmpty),
                sizedBox4,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    sizedBox6,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _title(LocaleKeys.houseNo.tr()),
                          sizedBox4,
                          TextFormField(
                              controller: _houseNoController,
                              decoration: InputDecoration(
                                hintText: LocaleKeys.houseNo.tr(),
                                hintStyle: fontStyle,
                              ),
                              validator: validateFieldEmpty),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _title(LocaleKeys.postalCode.tr()),
                          sizedBox4,
                          TextFormField(
                              controller: _postalCodeController,
                              decoration: InputDecoration(
                                hintText: LocaleKeys.postalCode.tr(),
                                hintStyle: fontStyle,
                              ),
                              validator: validateFieldEmpty),
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
                          _title(LocaleKeys.place.tr()),
                          sizedBox4,
                          TextFormField(
                              controller: _placeController,
                              decoration: InputDecoration(
                                hintText: LocaleKeys.place.tr(),
                                hintStyle: fontStyle,
                              ),
                              validator: validateFieldEmpty),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _title(LocaleKeys.phoneNo.tr()),
                          sizedBox4,
                          TextFormField(
                              controller: _phoneNoController,
                              decoration: InputDecoration(
                                hintText: LocaleKeys.phoneNo.tr(),
                                hintStyle: fontStyle,
                              ),
                              validator: validatePhone),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: AppConstants.bottomBtnPadding,
        child: ButtonComponent(
          btnHeight: 56,
          buttonText: LocaleKeys.next.tr().toUpperCase(),
          textStyle:
              FontStyles.fontRegular(color: ColorConstants.white, fontSize: 18),
          onPressed: () {
            if (_userInfoFormKey.currentState!.validate()) {
              taxFileProvider.setUserInformation(UserInformation(
                _surNameController.text,
                _firstNameController.text,
                _emailController.text,
                _roadController.text,
                _houseNoController.text,
                _postalCodeController.text,
                _placeController.text,
                _houseNoController.text,
              ));
              Navigator.pushNamed(
                  context, RouteConstants.selectDocumentForScreen, arguments: {
                "showNextBtn": true,
                "nextRoute": RouteConstants.fileTaxFinalSubmissionScreen
              });
            }
          },
        ),
      ),
    );
  }

  TextComponent _title(String val) {
    return TextComponent(
      val,
      style: FontStyles.fontRegular(fontSize: 14),
    );
  }
}
