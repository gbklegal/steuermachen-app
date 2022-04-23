import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:steuermachen/components/app_bar/appbar_with_side_corner_circle_and_body.dart';
import 'package:steuermachen/components/loading_component.dart';
import 'package:steuermachen/components/simple_error_text_component.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/wrappers/faq_wrapper.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBarWithSideCornerCircleAndRoundBody(
      showBackButton: false,
      body: InkWell(
        onTap: () async {
          // for (var e in faqJson) {
          //   await firestore.collection("faq_content").add(e);
          // }
        },
        child: SingleChildScrollView(
            child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                future: firestore.collection("faq_content").get(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List<Map<String, dynamic>> x = [];
                    for (var item in snapshot.data.docs) {
                      x.add(item.data() as Map<String, dynamic>);
                    }
                    List<FAQContentWrapper> faqContent = [];
                    for (var element in x) {
                      FAQContentWrapper res = FAQContentWrapper.fromJson(element);
                      faqContent.add(res);
                    }
                    return _FAQListTile(
                      faqContentWrapper: faqContent,
                    );
                  } else if (snapshot.hasError) {
                    return const SimpleErrorTextComponent();
                  } else {
                    return const LoadingComponent();
                  }
                })),
      ),
    );
  }
}

class _FAQListTile extends StatefulWidget {
  const _FAQListTile({Key? key, required this.faqContentWrapper})
      : super(key: key);
  final List<FAQContentWrapper> faqContentWrapper;
  @override
  __FAQListTileState createState() => __FAQListTileState();
}

class __FAQListTileState extends State<_FAQListTile> {
  late List<FAQContentWrapper> _wrapper;

  @override
  void initState() {
    super.initState();
    _wrapper = widget.faqContentWrapper;
  }

  @override
  Widget build(BuildContext context) {
    const divider = Padding(
      padding: EdgeInsets.symmetric(horizontal: 18),
      child: Divider(
        thickness: 1,
        height: 4,
      ),
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Text(
            LocaleKeys.frequentlyAskedQuestion.tr(),
            style:
                Theme.of(context).textTheme.headline6!.copyWith(fontSize: 22),
          ),
        ),
        for (var i = 0; i < _wrapper.length; i++)
          if (context.locale == const Locale('en'))
            InkWell(
              onTap: () {
                setState(() {
                  if (_wrapper[i].en!.isActive!) {
                    _wrapper[i].en!.isActive = false;
                  } else {
                    _wrapper[i].en!.isActive = true;
                  }
                });
              },
              child: questionListTile(_wrapper[i].en!, divider),
            )
          else
            InkWell(
              onTap: () {
                setState(() {
                  if (_wrapper[i].du!.isActive!) {
                    _wrapper[i].du!.isActive = false;
                  } else {
                    _wrapper[i].du!.isActive = true;
                  }
                });
              },
              child: questionListTile(_wrapper[i].du!, divider),
            )
      ],
    );
  }

  Column questionListTile(FAQContent faq, Padding divider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FAQQuestion(
          faq: faq,
        ),
        divider,
        _FAQAnswer(
          faq: faq,
        ),
      ],
    );
  }
}

class _FAQQuestion extends StatelessWidget {
  const _FAQQuestion({
    Key? key,
    required this.faq,
  }) : super(key: key);

  final FAQContent faq;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        faq.question!,
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(fontSize: 16, color: ColorConstants.plantGreen),
      ),
      trailing: const Icon(
        Icons.keyboard_arrow_down_outlined,
        size: 32,
      ),
    );
  }
}

class _FAQAnswer extends StatelessWidget {
  const _FAQAnswer({
    Key? key,
    required this.faq,
  }) : super(key: key);

  final FAQContent faq;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: faq.isActive!,
      child: Container(
         color: ColorConstants.toxicGreen.withOpacity(0.18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text(
                  faq.answer!,
                  style: FontStyles.fontMedium(
                      fontSize: 13, fontWeight: FontWeight.w500),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 10),
              //   child: Text(
              //     "Read more",
              //     style: FontStyles.fontMedium(
              //         fontSize: 15,
              //         fontWeight: FontWeight.bold,
              //         color: ColorConstants.primary),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
