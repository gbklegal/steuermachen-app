import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/wrappers/easy_tax/easy_tax_initial_view_wrapper.dart';

class InitialEasyTaxComponent extends StatelessWidget {
  const InitialEasyTaxComponent({Key? key, this.onPressed, required this.data})
      : super(key: key);
  final void Function()? onPressed;
  final EasyTaxInitialViewData data;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Text(
          data.pageTitle,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 15),
        _adviceCard(context, data.title, data.subtitle, "${data.price.toString()} ${data.currencySymbol}"),
        const SizedBox(height: 25),
        for (var i = 0; i < data.advicePoints.length; i++)
          _advicePoints(context, data.advicePoints[i]),
        const SizedBox(height: 45),
        ButtonComponent(
          buttonText: LocaleKeys.applyNowForAfee.tr(),
          onPressed: onPressed,
        ),
        const SizedBox(height: 25),
      ],
    );
  }

  Padding _advicePoints(BuildContext context, String points) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2, right: 5),
            child: Icon(
              Icons.check_circle,
              size: 20,
              color: ColorConstants.toxicGreen,
            ),
          ),
          Flexible(
            child: Text(
              points,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }

  ClipRRect _adviceCard(
      BuildContext context, String title, String subtitle, String price) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Column(
        children: [
          Container(
            color: ColorConstants.formFieldBackground,
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Image.asset(AssetConstants.taxAdvice),
                const SizedBox(width: 20),
                Flexible(
                  child: Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: ColorConstants.black.withOpacity(0.49),
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Flexible(
                //   child: Text(
                //     subtitle,
                //     style: Theme.of(context).textTheme.bodyText1!.copyWith(
                //         fontSize: 16,
                //         fontWeight: FontWeight.w500,
                //         color: ColorConstants.white),
                //   ),
                // ),
                Text(
                  price,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
