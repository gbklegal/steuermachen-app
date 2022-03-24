import 'package:flutter/material.dart';

class TitleTextAuthComponent extends StatelessWidget {
  const TitleTextAuthComponent({Key? key, required this.title})
      : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.start,
      style: Theme.of(context)
          .textTheme
          .headline5
          ?.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.3),
    );
  }
}
