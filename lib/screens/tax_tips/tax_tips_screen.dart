import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:steuermachen/components/app_bar/appbar_with_side_corner_circle_and_body.dart';
import 'package:steuermachen/components/error_component.dart';
import 'package:steuermachen/components/loading_component.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/screens/tax_tips/tax_tips_detail_screen.dart';
import 'package:steuermachen/screens/tax_tips/tax_tips_top_component.dart';
import 'package:steuermachen/wrappers/tax_tips_wrapper.dart';

class TaxTipsScreen extends StatelessWidget {
  const TaxTipsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBarWithSideCornerCircleAndRoundBody(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<DocumentSnapshot>(
                  future: firestore
                      .collection("featured_article")
                      .doc("content")
                      .get(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      Map<String, dynamic> x =
                          snapshot.data.data() as Map<String, dynamic>;
                      TaxTipsContentWrapper res =
                          TaxTipsContentWrapper.fromJson(x);
                      return Column(
                        children: [
                          if (context.locale == const Locale('en'))
                            for (var i = 0; i < res.en!.length; i++)
                              if (i == 0)
                                InkWell(
                                  onTap: () {
                                    _navigateToDetail(context, res.en![i]);
                                  },
                                  child: TaxTipTopComponent(
                                    title: res.en![i].title,
                                    subtitle: res.en![i].subtitle,
                                    publishedDate:
                                        res.en![i].publishedDate.toString(),
                                    articleBy: res.en![i].articleBy,
                                    image: res.en![i].image,
                                    readTime: res.en![i].readTime,
                                  ),
                                )
                              else
                                InkWell(
                                  onTap: () {
                                    _navigateToDetail(context, res.en![i]);
                                  },
                                  child: const _ListItems(),
                                )
                          else
                            for (var i = 0; i < res.du!.length; i++)
                              if (i == 0)
                                InkWell(
                                  onTap: () {
                                    _navigateToDetail(context, res.du![i]);
                                  },
                                  child: TaxTipTopComponent(
                                    title: res.du![i].title,
                                    subtitle: res.du![i].subtitle,
                                    publishedDate:
                                        res.du![i].publishedDate.toString(),
                                    articleBy: res.du![i].articleBy,
                                    image: res.du![i].image,
                                    readTime: res.du![i].readTime,
                                  ),
                                )
                              else
                                InkWell(
                                  onTap: () {
                                    _navigateToDetail(context, res.du![i]);
                                  },
                                  child: const _ListItems(),
                                )
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return const ErrorComponent();
                    } else {
                      return const LoadingComponent();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  _navigateToDetail(context, TaxTipsContent content) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaxTipsDetailScreen(taxTipsContent: content),
      ),
    );
  }
}

class _ListItems extends StatelessWidget {
  const _ListItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
