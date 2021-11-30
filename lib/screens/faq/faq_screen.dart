import 'package:flutter/material.dart';
import 'package:steuermachen/components/app_bar/appbar_with_side_corner_circle_and_body.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({Key? key}) : super(key: key);

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
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                bottom: 50,
                child: Container(
                  height: 22,
                  width: 1,
                  color: ColorConstants.green,
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorConstants.green,
                ),
                padding: const EdgeInsets.all(18),
                child: Text(
                  "1",
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
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 10),
            child: Text(
              "asasd",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          Text(
            "Fill out the order form, select the desired tax year for which you would like to have the income tax return drawn up and simply send the form.",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontWeight: FontWeight.w400, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
