import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/popup_loader_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/components/toast_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/data/view_models/tax/declaration_tax/declaration_tax_view_model.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/data/view_models/document/document_view_model.dart';
import 'package:steuermachen/utils/image_picker/media_source_selection_utils.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';
import 'package:steuermachen/wrappers/document/document_option_wrapper.dart';

class DocumentUploadComponent extends StatefulWidget {
  const DocumentUploadComponent({Key? key, required this.data})
      : super(key: key);
  final List<DocumentOptionsData> data;
  @override
  State<DocumentUploadComponent> createState() =>
      _DocumentUploadComponentState();
}

class _DocumentUploadComponentState extends State<DocumentUploadComponent> {
  late DocumentsViewModel _provider;
  String documentTitle = "";
  late DeclarationTaxViewModel declarationTaxViewModel;
  @override
  void initState() {
    _provider = Provider.of<DocumentsViewModel>(context, listen: false);
    declarationTaxViewModel =
        Provider.of<DeclarationTaxViewModel>(context, listen: false);
    super.initState();
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
            // setState(() {
            //   selectImageList = imagePath;
            // });
            await uploadDocument(imagePath);
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
      // setState(() {
      //   selectPDF = result.files.single.path!;
      //   // File file = File();
      // });
      await uploadDocument(result.files.single.path!);
    } else {
      // User canceled the picker
    }
  }

  uploadDocument(String file) async {
    _provider.setFilesForUpload([file]);
    PopupLoader.showLoadingDialog(context);
    CommonResponseWrapper res =
        await _provider.uploadFiles(documentTitle, _provider.selectedTax);
    if (res.status!) {
      await declarationTaxViewModel.fetchTaxFiledYears();
    }
    PopupLoader.hideLoadingDialog(context);
    ToastComponent.showToast(res.message!);
  }

  @override
  Widget build(BuildContext context) {
    return _documentSelection(widget.data);
  }

  Column _documentSelection(List<DocumentOptionsData> data) {
    return Column(
      children: [
        TextComponent(
          LocaleKeys.selectReceiptAndInvoices,
          style: FontStyles.fontMedium(
              lineSpacing: 1.1, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        for (var i = 0; i < data.length; i++) _dropdowns(data, i),
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

  Padding _dropdowns(List<DocumentOptionsData> data, int i) {
    if (documentTitle == "") {
      documentTitle = data[i].options[0];
    }
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: DropdownButtonFormField<String>(
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
        value: documentTitle,
        items: data[i]
            .options
            .map(
              (e) => DropdownMenuItem<String>(
                value: e,
                child: TextComponent(
                  e,
                  style: FontStyles.fontRegular(),
                ),
              ),
            )
            .toList(),
        onChanged: (val) {
          documentTitle = val!;
        },
      ),
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

// data[i].optionType == OptionConstants.yearsList
//             ? years[0].toString()
//             :

// data[i].optionType == OptionConstants.yearsList
//             ? years
//                 .map(
//                   (e) => DropdownMenuItem<String>(
//                     value: e.toString(),
//                     child: TextComponent(
//                       e.toString(),
//                       style: FontStyles.fontRegular(),
//                     ),
//                   ),
//                 )
//                 .toList()
//             : 