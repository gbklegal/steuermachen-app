import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/error_component.dart';
import 'package:steuermachen/components/loading_component.dart';
import 'package:steuermachen/components/popup_loader_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/components/toast_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/strings/error_messages_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/providers/profile/profile_provider.dart';
import 'package:steuermachen/utils/input_validation_util.dart';
import '../wrappers/common_response_wrapper.dart';
import 'button_component.dart';

class UserFormComponent extends StatefulWidget {
  const UserFormComponent(
      {Key? key, this.isAddNewAddress = false, this.showSaveBtn = false})
      : super(key: key);
  final bool? isAddNewAddress;
  final bool showSaveBtn;
  @override
  State<UserFormComponent> createState() => _UserFormComponentState();
}

class _UserFormComponentState extends State<UserFormComponent>
    with InputValidationUtil {
  late ProfileProvider _profileProvider;
  @override
  void initState() {
    super.initState();
    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => _profileProvider.getUserProfile());
  }

  final sizedBox4 = const SizedBox(
    height: 4,
  );
  final fontStyle = FontStyles.fontRegular(fontSize: 14);
  final sizedBox6 = const SizedBox(
    height: 6,
  );
  final List<String> gender = [
    LocaleKeys.mister.tr(),
    LocaleKeys.mrs.tr(),
    LocaleKeys.others.tr(),
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, consumer, child) {
        if (consumer.getBusyStateProfile && consumer.userData == null) {
          return const LoadingComponent();
        } else if (!consumer.getBusyStateProfile && consumer.userData == null) {
          return ErrorComponent(
            message: ErrorMessagesConstants.somethingWentWrong,
            onTap: () async {
              await _profileProvider.getUserProfile();
            },
          );
        } else {
          return _mainBody(consumer, context);
        }
      },
    );
  }

  Column _mainBody(ProfileProvider consumer, BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: !widget.isAddNewAddress!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.salutation.tr(),
                textAlign: TextAlign.left,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var item in gender)
                    InkWell(
                      onTap: () {
                        consumer.setGender(item);
                      },
                      child: Row(
                        children: [
                          Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 0.7,
                                )),
                            padding: const EdgeInsets.all(2),
                            child: Container(
                              height: 12,
                              width: 12,
                              decoration: BoxDecoration(
                                color: item == consumer.genderController.text
                                    ? ColorConstants.primary
                                    : null,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 10),
                            child: _title(
                              item,
                            ),
                          ),
                        ],
                      ),
                    )
                ],
              ),
            ],
          ),
        ),
        Form(
          key: consumer.userFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: consumer.firstNameController,
                decoration: InputDecoration(
                  labelText: LocaleKeys.firstName.tr() + "*",
                  hintStyle: fontStyle,
                ),
                validator: validateName,
              ),
              sizedBox6,
              TextFormField(
                controller: consumer.lastNameController,
                decoration: InputDecoration(
                  labelText: LocaleKeys.lastName.tr() + "*",
                  hintStyle: fontStyle,
                ),
                validator: validateName,
              ),
              sizedBox6,
              Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      controller: consumer.streetController,
                      decoration: InputDecoration(
                        labelText: LocaleKeys.street.tr() + "*",
                        hintStyle: fontStyle,
                      ),
                      validator: validateFieldEmpty,
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Flexible(
                    child: TextFormField(
                      controller: consumer.houseNumberController,
                      decoration: InputDecoration(
                        labelText: LocaleKeys.houseNo.tr() + "*",
                        hintStyle: fontStyle,
                      ),
                      validator: validateFieldEmpty,
                    ),
                  ),
                ],
              ),
              sizedBox4,
              TextFormField(
                controller: consumer.postCodeController,
                decoration: InputDecoration(
                  labelText: LocaleKeys.postcode.tr() + "*",
                  hintStyle: fontStyle,
                ),
                validator: validateFieldEmpty,
              ),
              sizedBox4,
              TextFormField(
                controller: consumer.locationController,
                decoration: InputDecoration(
                  labelText: LocaleKeys.location.tr() + "*",
                  hintStyle: fontStyle,
                ),
                validator: validateFieldEmpty,
              ),
              sizedBox4,
              TextFormField(
                controller: consumer.phoneController,
                decoration: InputDecoration(
                  labelText: LocaleKeys.phone.tr() + "*",
                  hintStyle: fontStyle,
                  hintText: "+4912341234567"
                ),
                validator: validatePhone,
              ),
              sizedBox4,
              !widget.isAddNewAddress!
                  ? TextFormField(
                      controller: consumer.emailController,
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: LocaleKeys.emailAddress.tr() + "*",
                        hintStyle: fontStyle,
                      ),
                      validator: validateEmail,
                    )
                  : const SizedBox(),
              sizedBox4,
              InkWell(
                onTap: () {
                  showCountryPicker(
                    context: context,
                    showPhoneCode:
                        true, // optional. Shows phone code before the country name.
                    onSelect: (Country country) {
                      consumer.countryController.text =
                          country.displayNameNoCountryCode;
                    },
                  );
                },
                child: TextFormField(
                  enabled: false,
                  controller: consumer.countryController,
                  decoration: InputDecoration(
                      labelText: LocaleKeys.country.tr() + "*",
                      hintStyle: fontStyle,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SvgPicture.asset(
                          AssetConstants.icDown,
                          color: ColorConstants.black,
                        ),
                      )),
                  validator: validateFieldEmpty,
                ),
              ),
              sizedBox4,
            ],
          ),
        ),
        Visibility(
          visible: widget.showSaveBtn,
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: ButtonComponent(
              btnHeight: 56,
              buttonText: LocaleKeys.save.tr(),
              onPressed: () async {
                if (consumer.userFormKey.currentState!.validate()) {
                  PopupLoader.showLoadingDialog(context);
                  CommonResponseWrapper res =
                      await consumer.submitUserProfile();
                  PopupLoader.hideLoadingDialog(context);
                  ToastComponent.showToast(res.message!, long: true);
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  TextComponent _title(String val) {
    return TextComponent(
      val,
      style: FontStyles.fontRegular(fontSize: 14),
    );
  }
}
