import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/utils/utils.dart';

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
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: TextComponent(
            LocaleKeys.featuredArticle.tr(),
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 15),
          child: TextComponent(
            title!,
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
              image!,
              height: 179,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 15),
          child: Text(
            subtitle!,
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
                "BY $articleBy\n${Utils.dateFormatter(publishedDate!)} ",
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
                readTime!,
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
