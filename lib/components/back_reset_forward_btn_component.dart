import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';

class BackResetForwardBtnComponent extends StatelessWidget {
  const BackResetForwardBtnComponent({
    Key? key,
    this.onTapBack,
    this.onTapContinue,
    this.onTapReset,
    this.showContinueBtn = true,
  }) : super(key: key);
  final void Function()? onTapBack;
  final void Function()? onTapContinue;
  final void Function()? onTapReset;
  final bool? showContinueBtn;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _iconText(AssetConstants.icBackNav, LocaleKeys.back.tr(), onTapBack,
              context),
          _iconText(AssetConstants.icReset, LocaleKeys.startNew.tr(),
              onTapReset, context),
          Visibility(
            visible: showContinueBtn!,
            child: _iconText(AssetConstants.icForwardNav,
                LocaleKeys.continueText.tr(), onTapContinue, context),
          ),
        ],
      ),
    );
  }

  GestureDetector _iconText(String iconName, String btnName,
      void Function()? onTap, BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(
            height: 48,
            child: SvgPicture.asset(
              iconName,
              height: AssetConstants.icReset == iconName ? 40 : 33,
            ),
          ),
          Text(
            btnName,
            textAlign: TextAlign.left,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontWeight: FontWeight.w500, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
