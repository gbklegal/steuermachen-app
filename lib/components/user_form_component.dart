import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/providers/profile/profile_provider.dart';
import 'package:steuermachen/utils/input_validation_util.dart';

class UserFormComponent extends StatelessWidget with InputValidationUtil {
  const UserFormComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const sizedBox4 = SizedBox(
      height: 4,
    );
    final fontStyle = FontStyles.fontRegular(fontSize: 14);
    const sizedBox6 = SizedBox(
      height: 6,
    );
    final List<String> gender = [
      LocaleKeys.mister.tr(),
      LocaleKeys.mrs.tr(),
      LocaleKeys.others.tr(),
    ];
    return Consumer<ProfileProvider>(builder: (context, consumer, child) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var item in gender)
                IntrinsicWidth(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    horizontalTitleGap: 0,
                    minLeadingWidth: 0,
                    title: _title(
                      item,
                    ),
                    leading: Radio(
                      value: "",
                      groupValue: '',
                      onChanged: (String? value) {
                        // setState(() {
                        //   _site = value;
                        // });
                      },
                    ),
                  ),
                ),
            ],
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
                  validator: validateFieldEmpty,
                ),
                sizedBox6,
                TextFormField(
                  controller: consumer.lastNameController,
                  decoration: InputDecoration(
                    labelText: LocaleKeys.lastName.tr() + "*",
                    hintStyle: fontStyle,
                  ),
                  validator: validateFieldEmpty,
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
                        // controller: consumer.houseNumberController,
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
                  ),
                  validator: validateFieldEmpty,
                ),
                sizedBox4,
                TextFormField(
                  controller: consumer.emailController,
                  decoration: InputDecoration(
                    labelText: LocaleKeys.emailAddress.tr() + "*",
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
                        consumer.countryController.text = country.displayName;
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
        ],
      );
    });
  }

  TextComponent _title(String val) {
    return TextComponent(
      val,
      style: FontStyles.fontRegular(fontSize: 14),
    );
  }
}
