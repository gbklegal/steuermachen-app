import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_with_side_corner_circle_and_body.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/error_component.dart';
import 'package:steuermachen/components/loading_component.dart';
import 'package:steuermachen/components/popup_loader_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/components/toast_component.dart';
import 'package:steuermachen/constants/app_constants.dart';
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
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _houseNumberController = TextEditingController();
  final TextEditingController _plzController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _landController = TextEditingController();
  final GlobalKey<FormState> _userFormKey = GlobalKey<FormState>();
  bool loading = true;
  late CommonResponseWrapper response;
  late FormsProvider _formsProvider;
  List<_UserFormModel> formFields = [];
  _addFields() {
    formFields.addAll([
      _UserFormModel(
        controller: _firstNameController,
        labelText: LocaleKeys.firstName.tr(),
        validator: validateFieldEmpty,
      ),
      _UserFormModel(
        controller: _lastNameController,
        labelText: LocaleKeys.surName.tr(),
        validator: validateFieldEmpty,
      ),
      _UserFormModel(
        controller: _streetController,
        labelText: LocaleKeys.street.tr(),
        validator: validateFieldEmpty,
      ),
      _UserFormModel(
        controller: _houseNumberController,
        labelText: LocaleKeys.houseNo.tr(),
        validator: validateFieldEmpty,
      ),
      _UserFormModel(
        controller: _plzController,
        labelText: "plz",
        validator: validateFieldEmpty,
      ),
      _UserFormModel(
        controller: _locationController,
        labelText: "location",
        validator: validateFieldEmpty,
      ),
      _UserFormModel(
        controller: _phoneController,
        labelText: LocaleKeys.phoneNo.tr(),
        validator: validateFieldEmpty,
      ),
      _UserFormModel(
        controller: _emailController,
        labelText: LocaleKeys.email.tr(),
        validator: validateEmail,
      ),
    ]);
  }

  @override
  void initState() {
    super.initState();
    _formsProvider = Provider.of<FormsProvider>(context, listen: false);
    _addFields();
    _formsProvider.getUserProfile().then((value) {
      if (value.status!) {
        if (value.data != null) {
          UserProfileDataCollector user = value.data;
          _firstNameController.text = user.firstName!;
          _lastNameController.text = user.lastName!;
          _streetController.text = user.street!;
          _houseNumberController.text = user.houseNumber!;
          _plzController.text = user.plz!;
          _locationController.text = user.location!;
          _phoneController.text = user.phone!;
          _emailController.text = user.email!;
          _landController.text = user.land!;
        }
      }
      response = value;
      setState(() {
        loading = false;
      });
    });
  }

  static const sizedBox4 = SizedBox(
    height: 4,
  );
  static const sizedBox6 = SizedBox(
    height: 6,
  );
  final fontStyle = FontStyles.fontRegular(fontSize: 14);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBarWithSideCornerCircleAndRoundBody(
        showNotificationIcon: false,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: _states(),
          ),
        ),
      ),
      bottomNavigationBar: _statesBtn(),
    );
  }

  Padding _bottomBtn() {
    return Padding(
      padding: AppConstants.bottomBtnPadding,
      child: ButtonComponent(
        btnHeight: 56,
        buttonText: LocaleKeys.save.tr(),
        onPressed: () async {
          if (_userFormKey.currentState!.validate()) {
            PopupLoader.showLoadingDialog(context);
            CommonResponseWrapper res =
                await _formsProvider.submitUserProfile(UserProfileDataCollector(
              firstName: _firstNameController.text,
              lastName: _lastNameController.text,
              street: _streetController.text,
              houseNumber: _houseNumberController.text,
              plz: _plzController.text,
              location: _locationController.text,
              phone: _phoneController.text,
              email: _emailController.text,
              land: _landController.text,
            ));
            PopupLoader.hideLoadingDialog(context);
            ToastComponent.showToast(res.message!, long: true);
          }
        },
      ),
    );
  }

  Widget _statesBtn() {
    if (loading) {
      return const SizedBox();
    } else if (!loading && !response.status!) {
      return const SizedBox();
    } else {
      return _bottomBtn();
    }
  }

  Widget _states() {
    if (loading) {
      return const LoadingComponent();
    } else if (!loading && !response.status!) {
      return const ErrorComponent();
    } else {
      return _mainBody();
    }
  }

  Padding _mainBody() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Form(
        key: _userFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 35,
            ),
            TextFormField(
              controller: _lastNameController,
              decoration: InputDecoration(
                labelText: LocaleKeys.surName.tr(),
                hintStyle: fontStyle,
              ),
              validator: validateFieldEmpty,
            ),
            sizedBox6,
            TextFormField(
              controller: _firstNameController,
              decoration: InputDecoration(
                labelText: LocaleKeys.firstName.tr(),
                hintStyle: fontStyle,
              ),
              validator: validateFieldEmpty,
            ),
            sizedBox6,
            TextFormField(
              controller: _streetController,
              decoration: InputDecoration(
                labelText: LocaleKeys.street.tr(),
                hintStyle: fontStyle,
              ),
              validator: validateFieldEmpty,
            ),
            sizedBox4,
            TextFormField(
              controller: _houseNumberController,
              decoration: InputDecoration(
                labelText: LocaleKeys.postalCode.tr(),
                hintStyle: fontStyle,
              ),
              validator: validateFieldEmpty,
            ),
            sizedBox4,
            TextFormField(
              controller: _plzController,
              decoration: InputDecoration(
                labelText: LocaleKeys.cityTown.tr(),
                hintStyle: fontStyle,
              ),
              validator: validateFieldEmpty,
            ),
            sizedBox4,
            InkWell(
              onTap: () {
                showCountryPicker(
                  context: context,
                  showPhoneCode:
                      true, // optional. Shows phone code before the country name.
                  onSelect: (Country country) {
                    print('Select country: ${country.displayName}');
                    _locationController.text = country.displayName;
                  },
                );
              },
              child: TextFormField(
                enabled: false,
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: LocaleKeys.selectCountry.tr(),
                  hintStyle: fontStyle,
                ),
                validator: validateFieldEmpty,
              ),
            ),
            sizedBox4,
          ],
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

class _UserFormModel {
  String? Function(String?)? validator;
  TextEditingController? controller;
  String? labelText;

  _UserFormModel({this.controller, this.labelText, this.validator});
}
