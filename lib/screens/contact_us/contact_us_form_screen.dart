import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_with_side_corner_circle_and_body.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/dialogs/completed_dialog_component.dart';
import 'package:steuermachen/components/popup_loader_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/components/toast_component.dart';
import 'package:steuermachen/constants/app_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/providers/forms_provider.dart';
import 'package:steuermachen/utils/input_validation_util.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';

class ContactUsFormScreen extends StatefulWidget {
  const ContactUsFormScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsFormScreen> createState() => _ContactUsFormScreenState();
}

class _ContactUsFormScreenState extends State<ContactUsFormScreen>
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
  final GlobalKey<FormState> _contactFormKey = GlobalKey<FormState>();

  late FormsProvider _formsProvider;
  @override
  void initState() {
    super.initState();
    _formsProvider = Provider.of<FormsProvider>(context, listen: false);
  }

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
    const sizedBox4 = SizedBox(
      height: 4,
    );
    const sizedBox6 = SizedBox(
      height: 6,
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
                  Text(LocaleKeys.getInTouch.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 24, fontWeight: FontWeight.w700)),
                  const SizedBox(
                    height: 23,
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
                      validator: validateEmail),
                  sizedBox6,
                  _title(LocaleKeys.subject.tr()),
                  sizedBox4,
                  TextFormField(
                      controller: _subjectController,
                      decoration: InputDecoration(
                        hintText: LocaleKeys.subject.tr(),
                        hintStyle: fontStyle,
                      ),
                      validator: validateFieldEmpty),
                  sizedBox4,
                  _title(LocaleKeys.phoneNo.tr()),
                  sizedBox4,
                  TextFormField(
                      controller: _phoneNoController,
                      decoration: InputDecoration(
                        hintText: LocaleKeys.phoneNo.tr(),
                        hintStyle: fontStyle,
                      ),
                      validator: validatePhone),
                  sizedBox4,
                  _title(LocaleKeys.message.tr()),
                  sizedBox4,
                  SizedBox(
                    height: 5 * 24.0,
                    child: TextFormField(
                        controller: _messageController,
                        maxLines: 5,
                        decoration: InputDecoration(
                            hintText: LocaleKeys.message.tr(),
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
              CommonResponseWrapper res = await _formsProvider
                  .submitContactUsForm(ContactUsFormDataCollector(
                      _surNameController.text,
                      _firstNameController.text,
                      _emailController.text,
                      _subjectController.text,
                      _phoneNoController.text,
                      _messageController.text));
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

  TextComponent _title(String val) {
    return TextComponent(
      val,
      style: FontStyles.fontRegular(fontSize: 14),
    );
  }
}
