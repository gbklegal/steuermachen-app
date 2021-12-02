import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:steuermachen/components/app_bar/appbar_with_side_corner_circle_and_body.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> faqItem = [
      {"title": LocaleKeys.faqItem1.tr(), "route": ""},
      {"title": LocaleKeys.faqItem2.tr(), "route": ""},
      {"title": LocaleKeys.faqItem3.tr(), "route": ""},
      {"title": LocaleKeys.faqItem4.tr(), "route": ""},
      {"title": LocaleKeys.faqItem5.tr(), "route": ""},
      {"title": LocaleKeys.faqItem6.tr(), "route": ""},
      {"title": LocaleKeys.faqItem7.tr(), "route": ""},
    ];

    return AppBarWithSideCornerCircleAndRoundBody(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Text(
                LocaleKeys.frequentlyAskedQuestion.tr(),
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontSize: 22),
              ),
            ),
            for (var i = 0; i < faqItem.length; i++)
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      faqItem[i]["title"]!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 16, color: ColorConstants.green),
                    ),
                    trailing: const Icon(
                      Icons.keyboard_arrow_down_outlined,
                      size: 32,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: Divider(
                      thickness: 1,
                      height: 4,
                    ),
                  )
                ],
              )
          ],
        ),
      ),
    );
  }
}
