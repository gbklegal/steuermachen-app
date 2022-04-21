import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/constants/app_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/data/view_models/profile/profile_provider.dart';

class ConfirmBillingComponent extends StatelessWidget {
  const ConfirmBillingComponent({
    Key? key,
    this.onTapOrder,
    required this.amount,
  }) : super(key: key);
  final void Function()? onTapOrder;
  final String amount;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileProvider>(context, listen: false);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.confirmOrder.tr(),
            textAlign: TextAlign.left,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            LocaleKeys.billingAddress.tr(),
            textAlign: TextAlign.left,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const SizedBox(
            height: 15,
          ),
          const Divider(
            thickness: 2,
            color: ColorConstants.mediumGrey,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${provider.getSelectedAddress?.firstName} ${provider.getSelectedAddress?.lastName}",
                textAlign: TextAlign.left,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "${provider.getSelectedAddress?.street} ${provider.getSelectedAddress?.houseNumber}, ${provider.getSelectedAddress?.location}, \n${provider.getSelectedAddress?.land}\n+${provider.getSelectedAddress?.phone}",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 13, fontWeight: FontWeight.w500, height: 1.5),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.total.tr(),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                amount,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const Spacer(),
          Padding(
            padding: AppConstants.bottomBtnPadding,
            child: ButtonComponent(
              buttonText: LocaleKeys.order.tr(),
              onPressed: onTapOrder,
            ),
          )
        ],
      ),
    );
  }
}
