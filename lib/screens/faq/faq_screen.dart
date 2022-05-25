import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_with_side_corner_circle_and_body.dart';
import 'package:steuermachen/components/error_component.dart';
import 'package:steuermachen/components/loading_component.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/data/view_models/faq_provider.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/services/networks/api_response_states.dart';
import 'package:steuermachen/wrappers/faq_wrapper.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  void initState() {
    // context.read<FaqProvider>().fetchFaqs();
    super.initState();
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
    return AppBarWithSideCornerCircleAndRoundBody(
      showBackButton: false,
      body: Consumer<FaqProvider>(
        builder: (context, consumer, child) {
          if (consumer.faqs.status == Status.loading) {
            return const LoadingComponent();
          } else if (consumer.faqs.status == Status.error) {
            return ErrorComponent(
              onTap: () async => await consumer.fetchFaqs(),
              message: consumer.faqs.message!,
            );
          } else {
            List<FAQContentModel>? tips = consumer.faqs.data;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Text(
                    LocaleKeys.frequentlyAskedQuestion.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 22),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: tips!.length,
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              if (tips[i].isActive!) {
                                tips[i].isActive = false;
                              } else {
                                tips[i].isActive = true;
                              }
                            });
                          },
                          child: questionListTile(tips[i], divider),
                        );
                      }),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Column questionListTile(FAQContentModel faq, Padding divider) {
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

  final FAQContentModel faq;

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

  final FAQContentModel faq;

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
