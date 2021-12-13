import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';

class LoadingComponent extends StatelessWidget {
  const LoadingComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: const Center(
        child: SpinKitWave(
          color: ColorConstants.primary,
          size: 40,
          itemCount: 6,
          duration: Duration(milliseconds: 700),
        ),
      ),
    );
  }
}
