import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_with_side_corner_circle_and_body.dart';
import 'package:steuermachen/components/loading_component.dart';
import 'package:steuermachen/components/simple_error_text_component.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/providers/tax_tips_provider.dart';
import 'package:steuermachen/screens/tax_tips/tax_tips_detail_screen.dart';
import 'package:steuermachen/screens/tax_tips/tax_tips_top_component.dart';
import 'package:steuermachen/utils/utils.dart';
import 'package:steuermachen/wrappers/faq_wp_wrapper.dart';

class TaxTipsScreen extends StatelessWidget {
  const TaxTipsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TaxTipsProvider provider =
        Provider.of<TaxTipsProvider>(context, listen: false);
    return AppBarWithSideCornerCircleAndRoundBody(
      showBackButton: false,
      body: FutureBuilder<List<TaxTipsWrapper>?>(
        future: provider.fetchTaxTips(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<TaxTipsWrapper>? tips = snapshot.data;
            return Padding(
              padding: const EdgeInsets.only(top: 15),
              child: ListView.builder(
                  itemCount: tips!.length,
                  itemBuilder: (context, i) {
                    if (i == 0) {
                      return InkWell(
                        onTap: () {
                          _navigateToDetail(context, tips[i]);
                        },
                        child: TaxTipTopComponent(
                          title: tips[i].title!.rendered,
                          subtitle: tips[i].embedded!.wpFeaturedmedia![0].altText,
                          publishedDate: tips[i]
                              .embedded!
                              .wpFeaturedmedia![0]
                              .date
                              .toString(),
                          articleBy: tips[i].embedded!.author![0].name,
                          image: tips[i].embedded!.wpFeaturedmedia![0].sourceUrl,
                          readTime: "",
                        ),
                      );
                    } else {
                      return InkWell(
                        onTap: () {
                          _navigateToDetail(context, tips[i]);
                        },
                        child: _ListItems(
                          title: tips[i].title!.rendered,
                          subtitle: tips[i].embedded!.wpFeaturedmedia![0].altText,
                          publishedDate: tips[i]
                              .embedded!
                              .wpFeaturedmedia![0]
                              .date
                              .toString(),
                          articleBy: tips[i].embedded!.author![0].name,
                          image: tips[i].embedded!.wpFeaturedmedia![0].sourceUrl,
                          readTime: "",
                        ),
                      );
                    }
                  }),
            );
          } else if (snapshot.hasError) {
            return const SimpleErrorTextComponent();
          } else {
            return const LoadingComponent();
          }
        },
      ),
    );
  }

  _navigateToDetail(context, TaxTipsWrapper content) {
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
    this.title,
    this.subtitle,
    this.articleBy,
    this.publishedDate,
    this.readTime,
    this.image,
  }) : super(key: key);
  final String? title, subtitle, articleBy, publishedDate, readTime, image;
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
                image!,
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
                      title!,
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
                            "BY $articleBy\n${Utils.dateFormatter(publishedDate!)}",
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
                            readTime!,
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
