import 'package:flutter/material.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';

class ButtonComponent extends StatelessWidget {
  final void Function()? onPressed;
  final String buttonText;
  final double border;
  final double btnHeight;
  final Color? color;
  final Color? disabledColor;
  final TextStyle? textStyle;
  final bool? isDisabled;
  final double? elevation;
  const ButtonComponent(
      {Key? key,
      this.onPressed,
      this.buttonText = '',
      this.border = 0.0,
      this.textStyle,
      this.btnHeight = 48,
      this.isDisabled = false,
      this.disabledColor = ColorConstants.mediumGrey,
      this.elevation = 0,
      this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      
      style: ElevatedButtonTheme.of(context).style?.copyWith(
            minimumSize: MaterialStateProperty.all(
              Size(MediaQuery.of(context).size.width, 48),
            ),
            backgroundColor: color!=null ? MaterialStateProperty.all<Color>(color!):
            MaterialStateProperty.all<Color>(ColorConstants.primary)
            ,
            
            
          ),
      child: Text(  
        buttonText,
        // text: buttonText,
        // ignore: prefer_if_null_operators
        style: textStyle != null
            ? textStyle
            : const TextStyle(fontWeight: FontWeight.w800),
      ),
      onPressed: isDisabled! ? null : (onPressed ?? () => {}),
    );
  }
}
