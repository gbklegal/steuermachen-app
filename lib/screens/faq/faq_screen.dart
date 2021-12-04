import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:steuermachen/components/app_bar/appbar_with_side_corner_circle_and_body.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  List<Map<String, dynamic>> faqItem = [
    {"title": LocaleKeys.faqItem1.tr(), "active": false, "route": ""},
    {"title": LocaleKeys.faqItem2.tr(), "active": false, "route": ""},
    {"title": LocaleKeys.faqItem3.tr(), "active": false, "route": ""},
    {"title": LocaleKeys.faqItem4.tr(), "active": false, "route": ""},
    {"title": LocaleKeys.faqItem5.tr(), "active": false, "route": ""},
    {"title": LocaleKeys.faqItem6.tr(), "active": false, "route": ""},
    {"title": LocaleKeys.faqItem7.tr(), "active": false, "route": ""},
  ];
  @override
  Widget build(BuildContext context) {
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
              Container(
                color: faqItem[i]["active"]!
                    ? ColorConstants.formFieldBackground
                    : ColorConstants.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        for (var element in faqItem) {
                          element["active"] = false;
                        }
                        setState(() {
                          faqItem[i]["active"] = true;
                        });
                      },
                      child: ListTile(
                        title: Text(
                          faqItem[i]["title"]!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  fontSize: 16, color: ColorConstants.green),
                        ),
                        trailing: const Icon(
                          Icons.keyboard_arrow_down_outlined,
                          size: 32,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: Divider(
                        thickness: 1,
                        height: 4,
                      ),
                    ),
                    Visibility(
                      visible: faqItem[i]["active"]!,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "1.1. Procedure for an order",
                              style: FontStyles.fontMedium(
                                  fontSize: 17, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "Rhe easy way to your tax return",
                              style: FontStyles.fontMedium(
                                  fontSize: 17, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "You will immediately receive a checklist by email with which you can sort your tax-relevant documents yourself.",
                              style: FontStyles.fontMedium(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "Read more",
                                style: FontStyles.fontMedium(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: ColorConstants.primary),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
