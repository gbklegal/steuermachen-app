class SendMailModel {
  SendMailModel({
    required this.pdf,
    required this.sendmail,
  });
  late final SendMailPdfModel pdf;
  late final bool sendmail;
  
  SendMailModel.fromJson(Map<String, dynamic> json){
    pdf = SendMailPdfModel.fromJson(json['pdf']);
    sendmail = json['sendmail'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['pdf'] = pdf.toJson();
    _data['sendmail'] = sendmail;
    return _data;
  }
}

class SendMailPdfModel {
  SendMailPdfModel({
    required this.url,
    required this.fileName,
  });
  late final String url;
  late final String fileName;
  
  SendMailPdfModel.fromJson(Map<String, dynamic> json){
    url = json['url'];
    fileName = json['file_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['url'] = url;
    _data['file_name'] = fileName;
    return _data;
  }
}