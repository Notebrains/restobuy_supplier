/// status : 1
/// message : "Transaction Price and Transaction Id"
/// response : {"transaction_amount":"80","transaction_id":"TRN00002"}

class TransactionPriceIdApiResModel {
  TransactionPriceIdApiResModel({
      int? status, 
      String? message, 
      Response? response,}){
    _status = status;
    _message = message;
    _response = response;
}

  TransactionPriceIdApiResModel.fromJson(dynamic json) {
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

/// transaction_amount : "80"
/// transaction_id : "TRN00002"

class Response {
  Response({
      String? transactionAmount, 
      String? transactionId,}){
    _transactionAmount = transactionAmount;
    _transactionId = transactionId;
}

  Response.fromJson(dynamic json) {
    _transactionAmount = json['transaction_amount'];
    _transactionId = json['transaction_id'];
  }
  String? _transactionAmount;
  String? _transactionId;

  String? get transactionAmount => _transactionAmount;
  String? get transactionId => _transactionId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['transaction_amount'] = _transactionAmount;
    map['transaction_id'] = _transactionId;
    return map;
  }

}