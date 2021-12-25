import 'package:flutter/material.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';

class ChoiceTextAuthComponent extends StatelessWidget {
  const ChoiceTextAuthComponent({Key? key, required this.text})
      : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14, bottom: 22),
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: ColorConstants.black.withOpacity(0.5)),
      ),
    );
  }
}
