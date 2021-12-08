import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:steuermachen/components/app_bar/appbar_with_side_corner_circle_and_body.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';

class SustainabilityScreen extends StatelessWidget {
  const SustainabilityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBarWithSideCornerCircleAndRoundBody(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Image.asset(AssetConstants.sustain),
            ),
            _richText(
                context,
                ColorConstants.formFieldBackground,
                '"TaxGreen - making taxes paperless"',
                "is the campaign of  steuermachen.de, which includes the plan and concrete measures of steuermachen.de to protect our earth. We are committed to digitization and thus to a more sustainable future. With the development of a new tax app, we want to make a concrete contribution to more sustainability in the business sector. With the use of the app from steuermachen.de you not only enjoy more comfort, but also protect the environment by using less paper. In cooperation with Treedom, we give away trees to our customers and plant our own company forest together with you. Treedom is committed to providing long-term support to smallholders around the world. By having a tree planted, you, as a customer, are helping to reduce CO2 emissions and protect the environment.",
                AssetConstants.sustain1),
            _richText(
                context,
                ColorConstants.primary.withOpacity(0.1),
                'How does that go?\n',
                "First of all, choose a tree that you would like to plant. Small farmers in the respective country then take care of your tree and care for it from an early age. With geolocation you can track it at any time and have the opportunity to watch it grow. If your tree bears fruit, these are harvested by the small farmers. They offer them an alternative source of income and at the same time secure their food base. Over the years, your tree will get bigger and bigger, bind more and more CO2 and contribute to the preservation of biodiversity.",
                AssetConstants.sustain2),
            _richText(
                context,
                ColorConstants.green.withOpacity(0.12),
                'We say Thankyou !\n',
                "We would like to thank you for using the tax app. As a user and part of our community, by using steuermachen.de you are making a significant contribution to social and ecological commitment. Without you it would be impossible. Together with you, we let our small company forest grow steadily and thus protect our earth. We say thank you for that!",
                AssetConstants.sustain3)
          ],
        ),
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
}
