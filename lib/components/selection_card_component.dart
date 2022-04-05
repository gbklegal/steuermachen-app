import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:steuermachen/components/toast_component.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';

class SelectionCardComponent extends StatelessWidget {
  const SelectionCardComponent({
    Key? key,
    required this.title,
    this.imagePath,
    this.onTap,
    this.enabled = true,
  }) : super(key: key);
  final String title;
  final String? imagePath;
  final void Function()? onTap;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: enabled
            ? onTap
            : () => {
                  ToastComponent.showToast(
                      LocaleKeys.alreadySubmittedTaxOfThisYear.tr())
                },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 68,
          decoration: BoxDecoration(
            color: enabled
                ? ColorConstants.toxicGreen.withOpacity(0.1)
                : ColorConstants.grey,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                width: 0.5,
                color:
                    enabled ? ColorConstants.toxicGreen : ColorConstants.grey),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: imagePath != null ? 30 : 10,
              ),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              imagePath != null
                  ? Image.network(
                      imagePath!,
                      color: ColorConstants.black,
                      height: 32,
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
