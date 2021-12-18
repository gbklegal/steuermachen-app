import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_with_side_corner_circle_and_body.dart';
import 'package:steuermachen/components/button_component.dart';
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
import 'package:country_picker/country_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with InputValidationUtil {
  final TextEditingController _firstNameController =
      TextEditingController(text: "Osama");
  final TextEditingController _surNameController =
      TextEditingController(text: "Asif");
  final TextEditingController _streetController =
      TextEditingController(text: "North");
  final TextEditingController _postalCodeController =
      TextEditingController(text: "74580");
  final TextEditingController _cityTownController =
      TextEditingController(text: "Karachi");
  final TextEditingController _countryController =
      TextEditingController(text: "Pakistan");
  final GlobalKey<FormState> _userFormKey = GlobalKey<FormState>();

  late FormsProvider _formsProvider;
  @override
  void initState() {
    super.initState();
    _formsProvider = Provider.of<FormsProvider>(context, listen: false);
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
        showNotificationIcon: false,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Form(
                key: _userFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 35,
                    ),
                    _title(LocaleKeys.surName.tr()),
                    sizedBox4,
                    TextFormField(
                      controller: _surNameController,
                      decoration: InputDecoration(
                        hintText: LocaleKeys.surName.tr(),
                        hintStyle: fontStyle,
                      ),
                      validator: validateFieldEmpty,
                    ),
                    sizedBox6,
                    _title(LocaleKeys.firstName.tr()),
                    sizedBox4,
                    TextFormField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        hintText: LocaleKeys.firstName.tr(),
                        hintStyle: fontStyle,
                      ),
                      validator: validateFieldEmpty,
                    ),
                    sizedBox6,
                    _title(LocaleKeys.street.tr()),
                    sizedBox4,
                    TextFormField(
                      controller: _streetController,
                      decoration: InputDecoration(
                        hintText: LocaleKeys.street.tr(),
                        hintStyle: fontStyle,
                      ),
                      validator: validateFieldEmpty,
                    ),
                    sizedBox4,
                    _title(LocaleKeys.postalCode.tr()),
                    sizedBox4,
                    TextFormField(
                      controller: _postalCodeController,
                      decoration: InputDecoration(
                        hintText: LocaleKeys.postalCode.tr(),
                        hintStyle: fontStyle,
                      ),
                      validator: validateFieldEmpty,
                    ),
                    sizedBox4,
                    _title(LocaleKeys.cityTown.tr()),
                    sizedBox4,
                    TextFormField(
                      controller: _cityTownController,
                      decoration: InputDecoration(
                        hintText: LocaleKeys.cityTown.tr(),
                        hintStyle: fontStyle,
                      ),
                      validator: validateFieldEmpty,
                    ),
                    sizedBox4,
                    _title(LocaleKeys.selectCountry.tr()),
                    sizedBox4,
                    InkWell(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          showPhoneCode:
                              true, // optional. Shows phone code before the country name.
                          onSelect: (Country country) {
                            print('Select country: ${country.displayName}');
                            _countryController.text = country.displayName;
                          },
                        );
                      },
                      child: TextFormField(
                        enabled: false,
                        controller: _countryController,
                        decoration: InputDecoration(
                          hintText: LocaleKeys.selectCountry.tr(),
                          hintStyle: fontStyle,
                        ),
                        validator: validateFieldEmpty,
                      ),
                    ),
                    sizedBox4,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: AppConstants.bottomBtnPadding,
        child: ButtonComponent(
          btnHeight: 56,
          buttonText: LocaleKeys.save.tr(),
          onPressed: () async {
            if (_userFormKey.currentState!.validate()) {
              PopupLoader.showLoadingDialog(context);
              CommonResponseWrapper res = await _formsProvider.userProfile(
                  UserProfileDataCollector(
                      _surNameController.text,
                      _firstNameController.text,
                      _streetController.text,
                      _postalCodeController.text,
                      _cityTownController.text,
                      _countryController.text));
              PopupLoader.hideLoadingDialog(context);
              ToastComponent.showToast(res.message!, long: true);
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
