import 'package:easy_localization/src/public_ext.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/empty_screen_loader_component.dart';
import 'package:steuermachen/components/error_component%20copy.dart';
import 'package:steuermachen/components/popup_loader_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/components/toast_component.dart';
import 'package:steuermachen/constants/app_constants.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/providers/document/document_provider.dart';
import 'package:steuermachen/utils/image_picker/media_source_selection_utils.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';
import 'package:steuermachen/wrappers/document/document_option_wrapper.dart';

class SelectDocumentForScreen extends StatefulWidget {
  const SelectDocumentForScreen(
      {Key? key,
      this.showNextBtn = false,
      this.onNextBtnRoute,
      this.uploadBtnNow = false,
      this.showRoundBody = true})
      : super(key: key);

  final bool? showNextBtn;
  final bool? uploadBtnNow;
  final String? onNextBtnRoute;
  final bool? showRoundBody;
  @override
  State<SelectDocumentForScreen> createState() =>
      _SelectDocumentForScreenState();
}

class _SelectDocumentForScreenState extends State<SelectDocumentForScreen> {
  CommonResponseWrapper? response;
  late List<String> selectImageList = [];
  late String selectPDF;
  User? user = FirebaseAuth.instance.currentUser;
  late DocumentsProvider _provider;
  int year = DateTime.now().year;
  List<int> years = [];
  @override
  void initState() {
    super.initState();
    _getYearList();
    _provider = Provider.of<DocumentsProvider>(context, listen: false);
    WidgetsBinding.instance!.addPostFrameCallback((_) =>
        _provider.getDocumentOptionsData().then((value) => response = value));
  }

  _getYearList() {
    for (var i = 4; i >= 0; i--) {
      int tempYear = year - i;
      years.add(tempYear);
    }
    return years;
  }

  _openCameraGallerySelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MediaSourceSelectionWidget(
          onTapGallery: () {
            Navigator.pop(context);
          },
          onTapCamera: () {},
          onImagePath: (String imagePath) async {
            setState(() {
              selectImageList.add(imagePath);
            });
          },
        );
      },
    );
  }

  _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      setState(() {
        selectPDF = result.files.single.path!;
        // File file = File();
      });
      await uploadDocument();
    } else {
      // User canceled the picker
    }
  }

  uploadDocument() async {
    _provider.setFilesForUpload([selectPDF, ...selectImageList]);
    PopupLoader.showLoadingDialog(context);
    CommonResponseWrapper res = await _provider.uploadFiles();
    PopupLoader.hideLoadingDialog(context);
    ToastComponent.showToast(res.message!);
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
      body: Consumer<DocumentsProvider>(
            builder: (context, consumer, child) {
          if (consumer.getBusyStateDocument || response == null) {
            return const EmptyScreenLoaderComponent();
          } else if (!response!.status!) {
            return ErrorComponent(
              message: response!.message!,
              onTap: () async {
                consumer.setBusyStateDocument = true;
                await _provider
                    .getDocumentOptionsData()
                    .then((value) => response = value);
                consumer.setBusyStateDocument = false;
              },
            );
          } else {
            DocumentOptionsWrappers currentYearTaxViewWrapper =
                response!.data as DocumentOptionsWrappers;
            if (context.locale == const Locale('en')) {
              return _mainBody(context);
            } else {
             return _mainBody(context);
            }
          }
        }), 
      bottomNavigationBar: Visibility(
        visible: widget.showNextBtn! || widget.uploadBtnNow!,
        child: Padding(
          padding: AppConstants.bottomBtnPadding,
          child: ButtonComponent(
            btnHeight: 56,
            buttonText: widget.uploadBtnNow!
                ? LocaleKeys.upload.tr()
                : LocaleKeys.next.tr().toUpperCase(),
            textStyle: FontStyles.fontRegular(
                color: ColorConstants.white, fontSize: 18),
            onPressed: () async {
              // _provider
              //     .setFilesForUpload([...selectPDFList, ...selectImageList]);
              // if (widget.uploadBtnNow!) {
              //   PopupLoader.showLoadingDialog(context);
              //   CommonResponseWrapper res = await _provider.uploadFiles();
              //   PopupLoader.hideLoadingDialog(context);
              //   ToastComponent.showToast(res.message!);
              // } else {
              //   Navigator.pushNamed(context, widget.onNextBtnRoute!);
              // }
            },
          ),
        ),
      ),
    );
  }

  SingleChildScrollView _mainBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            _documentSelection(context),
            TextComponent(
              LocaleKeys.documentOverview,
              style: FontStyles.fontMedium(
                  fontSize: 18, fontWeight: FontWeight.w600),
            ),
            for (var i = 0; i < years.length; i++) _taxYears(years[i])
          ],
        ),
      ),
    );
  }

  Padding _taxYears(int year) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RouteConstants.documentOverviewScreen);
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.3),
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextComponent(
                "tax year $year",
                style: FontStyles.fontMedium(fontSize: 16),
              ),
              SvgPicture.asset(
                AssetConstants.icForward,
                height: 14,
              )
            ],
          ),
        ),
      ),
    );
  }

  Column _documentSelection(BuildContext context) {
    return Column(
      children: [
        TextComponent(
          LocaleKeys.selectReceiptAndInvoices,
          style: FontStyles.fontMedium(
              lineSpacing: 1.1, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        DropdownButtonFormField<int>(
          decoration: const InputDecoration(
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
          icon: SvgPicture.asset(
            AssetConstants.icDown,
            color: ColorConstants.black,
            height: 10,
          ),
          value: 1,
          items: <DropdownMenuItem<int>>[
            DropdownMenuItem<int>(
              value: 1,
              child: TextComponent(
                "Please select",
                style: FontStyles.fontRegular(),
              ),
            ),
          ],
          onChanged: (val) {},
        ),
        const SizedBox(
          height: 15,
        ),
        DropdownButtonFormField<int>(
          decoration: const InputDecoration(
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
          icon: SvgPicture.asset(
            AssetConstants.icDown,
            color: ColorConstants.black,
            height: 10,
          ),
          value: 1,
          items: <DropdownMenuItem<int>>[
            DropdownMenuItem<int>(
              value: 1,
              child: TextComponent(
                "Please select",
                style: FontStyles.fontRegular(),
              ),
            ),
          ],
          onChanged: (val) {},
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Row(
            children: [
              Expanded(child: _useCameraBtn(context)),
              const SizedBox(
                width: 10,
              ),
              Expanded(child: _uploadBtn(context)),
            ],
          ),
        ),
      ],
    );
  }

  Column _useCameraBtn(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButtonTheme.of(context).style?.copyWith(
                minimumSize: MaterialStateProperty.all(
                  Size(MediaQuery.of(context).size.width, 54.5),
                ),
              ),
          onPressed: () {
            _openCameraGallerySelectionDialog();
          },
          child: SvgPicture.asset(AssetConstants.icCamera),
        )
      ],
    );
  }

  InkWell _uploadBtn(BuildContext context) {
    return InkWell(
      onTap: () async {
        await _pickFile();
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 0.8, color: ColorConstants.primary),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: TextComponent(
                LocaleKeys.uploadMediaFromLibrary,
                style: FontStyles.fontMedium(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
