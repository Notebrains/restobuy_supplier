/// status : 1
/// message : "Invoice List"
/// response : [{"invoice_id":"INV00002"}]

class InvIdApiResModel {
  InvIdApiResModel({
      int? status, 
      String? message, 
      List<Response>? response,}){
    _status = status;
    _message = message;
    _response = response;
}

  InvIdApiResModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['response'] != null) {
      _response = [];
      json['response'].forEach((v) {
        _response?.add(Response.fromJson(v));
      });
    }
  }
  int? _status;
  String? _message;
  List<Response>? _response;

  int? get status => _status;
  String? get message => _message;
  List<Response>? get response => _response;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_response != null) {
      map['response'] = _response?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// invoice_id : "INV00002"

class Response {
  Response({
      String? invoiceId,}){
    _invoiceId = invoiceId;
}

  Response.fromJson(dynamic json) {
    _invoiceId = json['invoice_id'];
  }
  String? _invoiceId;

  String? get invoiceId => _invoiceId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['invoice_id'] = _invoiceId;
    return map;
  }

}