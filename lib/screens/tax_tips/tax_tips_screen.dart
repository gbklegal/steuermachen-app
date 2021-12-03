import 'package:flutter/material.dart';
import 'package:steuermachen/components/app_bar/appbar_with_side_corner_circle_and_body.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/screens/tax_tips/tax_tips_top_component.dart';

class TaxTipsScreen extends StatelessWidget {
  const TaxTipsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBarWithSideCornerCircleAndRoundBody(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TaxTipTopComponent(),
            for (var i = 0; i < 5; i++)
              InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                        context, RouteConstants.taxTipsDetailScreen);
                  },
                  child: _listItems(context)),
          ],
        ),
      ),
    );
  }

  Padding _listItems(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: ColorConstants.formFieldBackground,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                "https://images.unsplash.com/photo-1586749874058-30b75a9b3e29?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8d2lkb3d8ZW58MHx8MHx8&w=1000&q=80",
                height: 50,
                width: 71,
                fit: BoxFit.cover,
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15),
                    child: Text(
                      "Widow's Pension: What Should You Know?",
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 15),
                          child: Text(
                            "BY DIANA PROSVIRKINA\nNOVEMBER 29, 2021 ",
                            textAlign: TextAlign.left,
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 8,
                                    ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, right: 15),
                          child: Text(
                            "4 min read",
                            textAlign: TextAlign.left,
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                          ),
                        ),
                      ],
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
