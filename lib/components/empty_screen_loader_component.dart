import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';

class EmptyScreenLoaderComponent extends StatelessWidget {
  const EmptyScreenLoaderComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SpinKitWave(
      color: ColorConstants.toxicGreen,
      size: 40,
      itemCount: 6,
      duration: Duration(milliseconds: 700),
    );
  }
}
