import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_with_side_corner_circle_and_body.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/dialogs/completed_dialog_component.dart';
import 'package:steuermachen/components/popup_loader_component.dart';
import 'package:steuermachen/components/toast_component.dart';
import 'package:steuermachen/constants/app_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/data/view_models/contact/contact_us_provider.dart';
import 'package:steuermachen/utils/input_validation_util.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';

class ContactUsFormScreen extends StatefulWidget {
  const ContactUsFormScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsFormScreen> createState() => _ContactUsFormScreenState();
}

class _ContactUsFormScreenState extends State<ContactUsFormScreen>
    with InputValidationUtil {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _referenceController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _newsController = TextEditingController();
  final GlobalKey<FormState> _contactFormKey = GlobalKey<FormState>();

  late ContactUsProvider _contactUsProvider;
  @override
  void initState() {
    super.initState();
    _contactUsProvider = Provider.of<ContactUsProvider>(context, listen: false);
  }

  _dialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CompletedDialogComponent(
          showBackBtn: false,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const sizedBox4 = SizedBox(
      height: 4,
    );
    const sizedBox15 = SizedBox(
      height: 15,
    );
    final fontStyle = FontStyles.fontRegular(fontSize: 14);
    return Scaffold(
      body: AppBarWithSideCornerCircleAndRoundBody(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Form(
              key: _contactFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 35,
                  ),
                  Text(LocaleKeys.makeContact.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 18, fontWeight: FontWeight.w700)),
                  const SizedBox(
                    height: 23,
                  ),
                  sizedBox4,
                  TextFormField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        labelText: LocaleKeys.firstName.tr(),
                        hintStyle: fontStyle,
                      ),
                      validator: validateFieldEmpty),
                  sizedBox15,
                  TextFormField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        labelText: LocaleKeys.lastName.tr(),
                        hintStyle: fontStyle,
                      ),
                      validator: validateFieldEmpty),
                  sizedBox15,
                  TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: LocaleKeys.emailAddress
                            .tr()
                            .replaceAll("address", ""),
                        hintStyle: fontStyle,
                      ),
                      validator: validateEmail),
                  sizedBox15,
                  TextFormField(
                      controller: _referenceController,
                      decoration: InputDecoration(
                        labelText: LocaleKeys.reference.tr(),
                        hintStyle: fontStyle,
                      ),
                      validator: validateFieldEmpty),
                  sizedBox15,
                  TextFormField(
                      controller: _phoneNoController,
                      decoration: InputDecoration(
                        labelText: LocaleKeys.phoneNo.tr(),
                        hintStyle: fontStyle,
                      ),
                      validator: validatePhone),
                  sizedBox15,
                  SizedBox(
                    height: 5 * 24.0,
                    child: TextFormField(
                        controller: _newsController,
                        decoration: InputDecoration(
                            labelText: LocaleKeys.news.tr(),
                            hintStyle: fontStyle,
                            isDense: true),
                        validator: validateFieldEmpty),
                  ),
                  sizedBox4,
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: AppConstants.bottomBtnPadding,
        child: ButtonComponent(
          btnHeight: 56,
          buttonText: LocaleKeys.send,
          onPressed: () async {
            if (_contactFormKey.currentState!.validate()) {
              PopupLoader.showLoadingDialog(context);
              CommonResponseWrapper res = await _contactUsProvider
                  .submitContactUsForm(ContactUsFormDataCollector(
                      lastName: _lastNameController.text,
                      firstName: _firstNameController.text,
                      email: _emailController.text,
                      reference: _referenceController.text,
                      phoneNo: _phoneNoController.text,
                      news: _newsController.text));
              PopupLoader.hideLoadingDialog(context);
              if (res.status!) {
                _dialog();
              } else {
                ToastComponent.showToast(res.message!, long: true);
              }
            }
          },
        ),
      ),
    );
  }
}
