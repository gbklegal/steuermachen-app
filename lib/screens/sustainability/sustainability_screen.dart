import 'dart:convert';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:steuermachen/components/app_bar/appbar_with_side_corner_circle_and_body.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/wrappers/sustainability_content_wrapper.dart';

class SustainabilityScreen extends StatelessWidget {
  const SustainabilityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBarWithSideCornerCircleAndRoundBody(
      body: SingleChildScrollView(
        child: FutureBuilder<dynamic>(
            future: firestore.collection("sustainability").doc("content").get(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data as DocumentSnapshot;
                Map<String, dynamic> x = data.data() as Map<String, dynamic>;
                SustainabilityContentWrapper res =
                    SustainabilityContentWrapper.fromJson(x);
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: Image.asset(AssetConstants.sustain),
                    ),
                    if (context.locale == const Locale('en'))
                      for (var i = 0; i < res.en!.length; i++)
                        _richText(context, getColor(i), '${res.en![i].title}',
                            '${res.en![i].text}', getAsset(i))
                    else
                      for (var i = 0; i < res.du!.length; i++)
                        _richText(context, getColor(i), '${res.du![i].title}',
                            '${res.du![i].text}', getAsset(i)),
                  ],
                );
              } else {
                return const Center(
                  child: SpinKitWave(
                    color: ColorConstants.primary,
                    size: 40,
                    itemCount: 6,
                    duration: Duration(milliseconds: 700),
                  ),
                );
              }
            }),
      ),
    );
  }

  Container _richText(BuildContext context, Color containerColor, String span1,
      String span2, String backgroundImage) {
    return Container(
      decoration: BoxDecoration(
        color: containerColor,
        image: DecorationImage(
          image: AssetImage(backgroundImage),
        ),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              text: span1,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: ColorConstants.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700),
              children: <TextSpan>[
                TextSpan(
                    text: span2,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 14,
                        height: 1.5,
                        color: ColorConstants.black.withOpacity(0.8)),
                    recognizer: TapGestureRecognizer()..onTap = () {})
              ],
            ),
          )
        ],
      ),
    );
  }

  Color getColor(int i) {
    if (i == 0) {
      return ColorConstants.formFieldBackground;
    } else if (i == 1) {
      return ColorConstants.primary.withOpacity(0.1);
    } else if (i == 2) {
      return ColorConstants.green.withOpacity(0.12);
    }
    return ColorConstants.formFieldBackground;
  }

  String getAsset(int i) {
    if (i == 0) {
      return AssetConstants.sustain1;
    } else if (i == 1) {
      return AssetConstants.sustain2;
    } else if (i == 2) {
      return AssetConstants.sustain3;
    }
    return AssetConstants.sustain1;
  }
}
