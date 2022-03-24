import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/src/public_ext.dart';
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
      body: SingleChildScrollView(
          child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder<DocumentSnapshot>(
            future: firestore.collection("faq").doc("content").get(),
       
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                Map<String, dynamic> x =
                    snapshot.data.data() as Map<String, dynamic>;
                FAQContentWrapper res = FAQContentWrapper.fromJson(x);
                return _FAQListTile(
                  faqContentWrapper: res,
                );
              } else if (snapshot.hasError) {
                return const SimpleErrorTextComponent();
              } else {
                return const LoadingComponent();
              }
            }),
      )),
    );
  }
}

class _FAQListTile extends StatefulWidget {
  const _FAQListTile({Key? key, required this.faqContentWrapper})
      : super(key: key);
  final FAQContentWrapper faqContentWrapper;
  @override
  __FAQListTileState createState() => __FAQListTileState();
}

class __FAQListTileState extends State<_FAQListTile> {
  late FAQContentWrapper _wrapper;

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
        if (context.locale == const Locale('en'))
          for (var i = 0; i < _wrapper.en!.length; i++)
            InkWell(
                onTap: () {
                  setState(() {
                    if (_wrapper.en![i].isActive!) {
                      _wrapper.en![i].isActive = false;
                    } else {
                      _wrapper.en![i].isActive = true;
                    }
                  });
                },
                child: questionListTile(_wrapper.en![i], divider))
        else
          for (var i = 0; i < _wrapper.du!.length; i++)
            InkWell(
                onTap: () {
                  setState(() {
                    if (_wrapper.du![i].isActive!) {
                      _wrapper.du![i].isActive = false;
                    } else {
                      _wrapper.du![i].isActive = true;
                    }
                  });
                },
                child: questionListTile(_wrapper.du![i], divider))
      ],
    );
  }

  Container questionListTile(FAQContent faq, Padding divider) {
    return Container(
      color: faq.isActive!
          ? ColorConstants.formFieldBackground
          : ColorConstants.white,
      child: Column(
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
      ),
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
            .copyWith(fontSize: 16, color: ColorConstants.green),
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              faq.title!,
              style: FontStyles.fontMedium(
                  fontSize: 17, fontWeight: FontWeight.w700),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Text(
                faq.answer!,
                style: FontStyles.fontMedium(
                    fontSize: 17, fontWeight: FontWeight.w500),
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
    );
  }
}
