import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/empty_screen_loader_component.dart';
import 'package:steuermachen/components/error_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/data/view_models/profile/profile_provider.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';
import 'package:steuermachen/wrappers/user_wrapper.dart';

class SelectBillingAddressScreen extends StatefulWidget {
  const SelectBillingAddressScreen({Key? key}) : super(key: key);

  @override
  State<SelectBillingAddressScreen> createState() =>
      _SelectBillingAddressScreenState();
}

class _SelectBillingAddressScreenState
    extends State<SelectBillingAddressScreen> {
  CommonResponseWrapper? response;
  late ProfileProvider provider;

  @override
  void initState() {
    provider = Provider.of<ProfileProvider>(context, listen: false);
    WidgetsBinding.instance!.addPostFrameCallback(
        (_) => provider.getUserAddresses().then((value) => response = value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComponent(
        StringConstants.appName,
        imageTitle: AssetConstants.logo,
        backgroundColor: Colors.transparent,
        showBackButton: true,
        showPersonIcon: false,
        showBottomLine: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Consumer<ProfileProvider>(builder: (context, consumer, child) {
          if (consumer.getBusyStateProfile || response == null) {
            return const EmptyScreenLoaderComponent();
          } else if (!response!.status!) {
            return ErrorComponent(
              message: response!.message!,
              onTap: () async {
                await provider.getUserAddresses().then((value) {
                  setState(() {
                    response = value;
                  });
                });
              },
            );
          } else {
            if (response?.data == null) {
              return _AddNewAddress(
                onTap: () async {
                  var res = await Navigator.pushNamed(
                      context, RouteConstants.addNewBillingAddressScreen);
                  if (res != null) {
                    await provider.getUserAddresses().then((value) {
                      setState(() {
                        response = value;
                      });
                    });
                  }
                },
              );
            } else {
              List<UserWrapper> addressess =
                  response!.data as List<UserWrapper>;
              if (context.locale == const Locale('en')) {
                return _mainBody(context, addressess);
              } else {
                return _mainBody(context, addressess);
              }
            }
          }
        }),
      ),
    );
  }

  SingleChildScrollView _mainBody(
      BuildContext context, List<UserWrapper> addresses) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 35,
          ),
          Text(
            LocaleKeys.selectBillingAddress.tr(),
            textAlign: TextAlign.left,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const SizedBox(
            height: 15,
          ),
          for (var i = 0; i < addresses.length; i++)
            _addressWidget(context, addresses[i]),
          const SizedBox(
            height: 15,
          ),
          _AddNewAddress(
            onTap: () async {
              var res = await Navigator.pushNamed(
                  context, RouteConstants.addNewBillingAddressScreen);
              if (res != null) {
                await provider.getUserAddresses().then((value) {
                  setState(() {
                    response = value;
                  });
                });
              }
            },
          ),
          const SizedBox(
            height: 35,
          ),
        ],
      ),
    );
  }

  Padding _addressWidget(BuildContext context, UserWrapper address) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.2, color: ColorConstants.black),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.firstName! + " " + address.lastName!,
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${address.street} ${address.houseNumber}, ${address.location}, \n${address.land}\n+${address.phone}",
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 13, fontWeight: FontWeight.w500, height: 1.5),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            InkWell(
              onTap: () {
                var provider =
                    Provider.of<ProfileProvider>(context, listen: false);
                provider.setSelectedAddress = address;
                Navigator.pop(context, true);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: ColorConstants.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(15),
                child: Text(
                  LocaleKeys.useThisAddress.tr(),
                  textAlign: TextAlign.left,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: ColorConstants.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _AddNewAddress extends StatelessWidget {
  const _AddNewAddress({
    Key? key,
    this.onTap,
  }) : super(key: key);
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.2, color: ColorConstants.black),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LocaleKeys.addNewAddress.tr(),
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            SvgPicture.asset(
              AssetConstants.icForwardNav,
              height: 14,
            )
          ],
        ),
      ),
    );
  }
}
