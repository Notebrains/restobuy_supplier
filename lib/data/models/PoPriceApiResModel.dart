/// status : 1
/// message : "PO Price and Invoice Id"
/// response : {"purchase_amount":"800","invoice_id":"INV00002"}

class PoPriceApiResModel {
  PoPriceApiResModel({
      int? status, 
      String? message, 
      Response? response,}){
    _status = status;
    _message = message;
    _response = response;
}

  PoPriceApiResModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _response = json['response'] != null ? Response.fromJson(json['response']) : null;
  }
  int? _status;
  String? _message;
  Response? _response;

  int? get status => _status;
  String? get message => _message;
  Response? get response => _response;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_response != null) {
      map['response'] = _response?.toJson();
    }
    return map;
  }

}

/// purchase_amount : "800"
/// invoice_id : "INV00002"

class Response {
  Response({
      String? purchaseAmount, 
      String? invoiceId,}){
    _purchaseAmount = purchaseAmount;
    _invoiceId = invoiceId;
}

  Response.fromJson(dynamic json) {
    _purchaseAmount = json['purchase_amount'];
    _invoiceId = json['invoice_id'];
  }
  String? _purchaseAmount;
  String? _invoiceId;

  String? get purchaseAmount => _purchaseAmount;
  String? get invoiceId => _invoiceId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['purchase_amount'] = _purchaseAmount;
    map['invoice_id'] = _invoiceId;
    return map;
  }

}