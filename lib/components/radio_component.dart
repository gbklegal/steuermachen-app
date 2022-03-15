
import 'package:flutter/material.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';

class RadioComponent extends StatelessWidget {
  const RadioComponent({
    Key? key,
    this.onTap,
    required this.title,
    required this.isSelected,
  }) : super(key: key);
  final void Function()? onTap;
  final String title;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(18),
      child: InkWell(
        onTap: onTap,
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
                  color: isSelected
                      ? ColorConstants.primary
                      : ColorConstants.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 10),
                child: TextComponent(title,
                    textAlign: TextAlign.left,
                    style: FontStyles.fontMedium(
                        fontSize: 16, letterSpacing: 0.3, lineSpacing: 1.1)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}