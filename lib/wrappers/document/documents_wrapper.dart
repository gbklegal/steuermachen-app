class DocumentsWrapper {
  DocumentsWrapper({
    required this.documentTitle,
    required this.url,
  });
  late final String documentTitle;
  late final String url;
  
  DocumentsWrapper.fromJson(Map<String, dynamic> json){
    documentTitle = json['document_title'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['document_title'] = documentTitle;
    _data['url'] = url;
    return _data;
  }
}