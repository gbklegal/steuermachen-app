import 'package:flutter/material.dart';
import 'package:steuermachen/components/button_component.dart';

class ButtonAuthComponent extends StatelessWidget {
  const ButtonAuthComponent({
    Key? key,
    required this.btnText,
    this.onPressed,
  }) : super(key: key);
  final String btnText;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ButtonComponent(
      onPressed: onPressed,
      buttonText: btnText,
    );
  }
}
