import 'package:flutter/material.dart';
import 'package:steuermachen/components/app_bar/appbar_with_side_corner_circle_and_body.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';

class HowItWorksScreen extends StatelessWidget {
  const HowItWorksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> content = [
      {
        "title": "Apply for the desired tax return",
        "content":
            "Fill out the order form, select the desired tax year for which you would like to have the income tax return drawn up and simply send the form."
      },
      {
        "title": "Prepare and send documents",
        "content":
            "Fill out the order form, select the desired tax year for which you want to have the income tax return made and simply submit the form."
      },
      {
        "title":
            "Your personal tax office offers the solution for your tax return",
        "content":
            "Fill out the order form, select the desired tax year for which you want to have the income tax return made and simply submit the form."
      },
      {
        "title": "Done: you get yours audited tax assessment",
        "content":
            "Fill out the order form, select the desired tax year for which you want to have the income tax return made and simply submit the form."
      },
    ];
    return AppBarWithSideCornerCircleAndRoundBody(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              for (var i = 0; i < content.length; i++)
                _faqSteps(context, (i + 1).toString(), content[i]["title"]!,
                    content[i]["content"]!,
                    showTopLine: i != 0),
              const SizedBox(height: 50),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: ElevatedButton(
                  style: ElevatedButtonTheme.of(context).style?.copyWith(
                        minimumSize: MaterialStateProperty.all(
                          Size(MediaQuery.of(context).size.width, 70),
                        ),
                      ),
                  onPressed: () {},
                  child: const Text(
                    StringConstants.applyNow,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
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
                    height: 26,
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
                padding: const EdgeInsets.all(18),
                child: Text(
                  index,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: ColorConstants.white, fontSize: 24),
                ),
              ),
              Positioned(
                top: 50,
                child: Container(
                  height: 26,
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
                .bodyText1!
                .copyWith(fontWeight: FontWeight.w700),
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
