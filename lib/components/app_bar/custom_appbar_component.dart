import 'package:flutter/material.dart';
import 'package:steuermachen/components/language_dropdown_component.dart';
import 'package:steuermachen/components/logo_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';

class CustomAppBarComponent extends StatelessWidget {
  const CustomAppBarComponent({
    Key? key,
    this.backIconTitle = LocaleKeys.back,
  }) : super(key: key);
  final String backIconTitle;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: ColorConstants.black,
                ),
              ),
              TextComponent(
                backIconTitle,
                style: const TextStyle(
                    color: ColorConstants.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 17),
              )
            ],
          ),
        ),
        const LogoComponent(
          fontSize: 20,
        ),
        Transform.translate(
          offset: const Offset(0, -12),
          child: const Padding(
            padding: EdgeInsets.only(right: 15),
            child: SizedBox(child: LanguageDropdownComponent()),
          ),
        ),
      ],
    );
  }
}
