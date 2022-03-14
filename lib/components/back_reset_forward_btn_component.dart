import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';

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
          _iconText(AssetConstants.icBackNav, "Back", onTapBack, context),
          _iconText(AssetConstants.icReset, "Start new", onTapReset, context),
          Visibility(
            visible: showContinueBtn!,
            child: _iconText(AssetConstants.icForwardNav, "Continue",
                onTapContinue, context),
          ),
        ],
      ),
    );
  }

  InkWell _iconText(String iconName, String btnName, void Function()? onTap,
      BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(
            height: 48,
            child: SvgPicture.asset(
              iconName,
              height: AssetConstants.icReset == iconName ? 48 : 25,
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
