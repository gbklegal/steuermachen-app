import 'package:flutter/material.dart';

class TextComponent extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final TextStyle? style;
  final TextOverflow? overFlow;
  final int? maxLines;
  final bool? softwrap;
  final double textScaleFactor;
  const TextComponent(this.text,
      {Key? key,
      this.textAlign = TextAlign.left,
      this.style,
      this.overFlow,
      this.maxLines,
      this.softwrap,
      this.textScaleFactor = 1.0})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      softWrap: softwrap,
      overflow: overFlow,
      textAlign: textAlign,
      style: style,
    );
  }
}
