import 'package:flutter/material.dart';

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
    return ElevatedButton(
      style: ElevatedButtonTheme.of(context).style?.copyWith(
            minimumSize: MaterialStateProperty.all(
              Size(MediaQuery.of(context).size.width, 56),
            ),
          ),
      onPressed: onPressed,
      child: Text(
        btnText,
      ),
    );
  }
}
