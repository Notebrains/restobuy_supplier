/// status : 1
/// message : "Transactions List"
/// response : [{"id":1,"transaction_id":"TRN00001","invoice_id":"INV00001","transaction_amount":"$80","payment_mode":"Paypal","datetime":"09-02-2022 03:28 PM","transaction_status":"Success"}]

class TransactionApiResModel {
  TransactionApiResModel({
      int? status, 
      String? message, 
      List<Response>? response,}){
    _status = status;
    _message = message;
    _response = response;
}

  TransactionApiResModel.fromJson(dynamic json) {
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

/// id : 1
/// transaction_id : "TRN00001"
/// invoice_id : "INV00001"
/// transaction_amount : "$80"
/// payment_mode : "Paypal"
/// datetime : "09-02-2022 03:28 PM"
/// transaction_status : "Success"

class Response {
  Response({
      int? id, 
      String? transactionId, 
      String? invoiceId, 
      String? transactionAmount, 
      String? paymentMode, 
      String? datetime, 
      String? transactionStatus,}){
    _id = id;
    _transactionId = transactionId;
    _invoiceId = invoiceId;
    _transactionAmount = transactionAmount;
    _paymentMode = paymentMode;
    _datetime = datetime;
    _transactionStatus = transactionStatus;
}

  Response.fromJson(dynamic json) {
    _id = json['id'];
    _transactionId = json['transaction_id'];
    _invoiceId = json['invoice_id'];
    _transactionAmount = json['transaction_amount'];
    _paymentMode = json['payment_mode'];
    _datetime = json['datetime'];
    _transactionStatus = json['transaction_status'];
  }
  int? _id;
  String? _transactionId;
  String? _invoiceId;
  String? _transactionAmount;
  String? _paymentMode;
  String? _datetime;
  String? _transactionStatus;

  int? get id => _id;
  String? get transactionId => _transactionId;
  String? get invoiceId => _invoiceId;
  String? get transactionAmount => _transactionAmount;
  String? get paymentMode => _paymentMode;
  String? get datetime => _datetime;
  String? get transactionStatus => _transactionStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['transaction_id'] = _transactionId;
    map['invoice_id'] = _invoiceId;
    map['transaction_amount'] = _transactionAmount;
    map['payment_mode'] = _paymentMode;
    map['datetime'] = _datetime;
    map['transaction_status'] = _transactionStatus;
    return map;
  }

}