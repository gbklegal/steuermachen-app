import 'package:flutter/material.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';

class SelectionCardComponent extends StatelessWidget {
  const SelectionCardComponent({
    Key? key,
    required this.title,
    this.imagePath,
    this.onTap,
  }) : super(key: key);
  final String title;
  final String? imagePath;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 68,
          decoration: BoxDecoration(
            color: ColorConstants.toxicGreen.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 0.5, color: ColorConstants.toxicGreen),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: imagePath != null ? 30 : 10,
              ),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              imagePath != null
                  ? Image.network(
                      imagePath!,
                      color: ColorConstants.black,
                      height: 32,
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
