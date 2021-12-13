import 'package:flutter/material.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';

class TaxTipTopComponent extends StatelessWidget {
  const TaxTipTopComponent(
      {Key? key,
      this.title,
      this.subtitle,
      this.articleBy,
      this.publishedDate,
      this.readTime,
      this.image})
      : super(key: key);
  final String? title, subtitle, articleBy, publishedDate, readTime, image;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50, left: 15),
          child: Text(
            StringConstants.featuredArticle,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 15),
          child: Text(
            "WIDOW'S PENSION",
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.network(
              "https://images.unsplash.com/photo-1586749874058-30b75a9b3e29?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8d2lkb3d8ZW58MHx8MHx8&w=1000&q=80",
              height: 179,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 15),
          child: Text(
            "Widow's Pension: What Should You Know?",
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 15),
              child: Text(
                "BY DIANA PROSVIRKINA\nNOVEMBER 29, 2021 ",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, right: 15),
              child: Text(
                "4 min read",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
