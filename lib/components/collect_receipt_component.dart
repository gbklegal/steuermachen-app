
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';

class CollectReceiptsComponent extends StatelessWidget {
  const CollectReceiptsComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteConstants.documentOverviewScreen,
            arguments: {"uploadBtn": false});
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: ColorConstants.primary, width: 1),
          borderRadius: const BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        child: ListTile(
          leading: SvgPicture.asset(
            AssetConstants.icReceipts,
            height: 18,
            color: ColorConstants.black,
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              LocaleKeys.collectReceipts.tr(),
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.w500, fontSize: 14, letterSpacing: -0.3),
            ),
          ),
          trailing: SvgPicture.asset(
            AssetConstants.icForward,
            height: 12,
          ),
        ),
      ),
    );
  }
}
