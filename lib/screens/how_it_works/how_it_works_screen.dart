import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:steuermachen/components/app_bar/appbar_with_side_corner_circle_and_body.dart';
import 'package:steuermachen/components/loading_component.dart';
import 'package:steuermachen/components/simple_error_text_component.dart';
import 'package:steuermachen/constants/app_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/wrappers/how_it_works_wrapper.dart';

class HowItWorksScreen extends StatelessWidget {
  const HowItWorksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBarWithSideCornerCircleAndRoundBody(
      body: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                FutureBuilder<DocumentSnapshot>(
                    future: firestore
                        .collection("how_it_works")
                        .doc("content")
                        .get(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        Map<String, dynamic> x =
                            snapshot.data.data() as Map<String, dynamic>;
                        HowItWorksContentWrapper res =
                            HowItWorksContentWrapper.fromJson(x);
                        return Column(
                          children: [
                            if (context.locale == const Locale('en'))
                              for (var i = 0; i < res.en!.length; i++)
                                _faqSteps(context, (i + 1).toString(),
                                    res.en![i].title!, res.en![i].text!,
                                    showTopLine: i != 0)
                            else
                              for (var i = 0; i < res.du!.length; i++)
                                _faqSteps(context, (i + 1).toString(),
                                    res.du![i].title!, res.du![i].text!,
                                    showTopLine: i != 0)
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return const SimpleErrorTextComponent();
                      } else {
                        return const LoadingComponent();
                      }
                    }),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: AppConstants.bottomBtnPadding,
          child: ElevatedButton(
            style: ElevatedButtonTheme.of(context).style?.copyWith(
                  minimumSize: MaterialStateProperty.all(
                    Size(MediaQuery.of(context).size.width, 56),
                  ),
                ),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteConstants.bottomNavBarScreen, (val) => false);
            },
            child:  Text(
              LocaleKeys.applyNow.tr(),
            ),
          ),
        ),
      ),
    );
  }

  Column _faqSteps(
      BuildContext context, String index, String title, String content,
      {bool showTopLine = true}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 2),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                bottom: 50,
                child: Visibility(
                  visible: showTopLine,
                  child: Container(
                    height: 18,
                    width: 1,
                    color: ColorConstants.green,
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorConstants.green,
                ),
                padding: const EdgeInsets.all(15),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    index,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: ColorConstants.white, fontSize: 17),
                  ),
                ),
              ),
              Positioned(
                top: 50,
                child: Container(
                  height: 22,
                  width: 1,
                  color: ColorConstants.green,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 10),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        Text(
          content,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontWeight: FontWeight.w400, fontSize: 14),
        ),
      ],
    );
  }
}
