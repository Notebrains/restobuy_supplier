/// status : 1
/// message : "Invoice List"
/// response : [{"id":2,"purchase_order_id":"PO00001","invoice_id":"INV00002","invoice_amount":"$30","restaurant_name":"Ozora","datetime":"25-02-2022 12:43 PM"},{"id":3,"purchase_order_id":"PO00004","invoice_id":"INV00003","invoice_amount":"$42","restaurant_name":"Ozora","datetime":"25-02-2022 02:39 PM"}]

class InvoiceApiResModel {
  InvoiceApiResModel({
      int? status, 
      String? message, 
      List<Response>? response,}){
    _status = status;
    _message = message;
    _response = response;
}

  InvoiceApiResModel.fromJson(dynamic json) {
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

/// id : 2
/// purchase_order_id : "PO00001"
/// invoice_id : "INV00002"
/// invoice_amount : "$30"
/// restaurant_name : "Ozora"
/// datetime : "25-02-2022 12:43 PM"

class Response {
  Response({
      int? id, 
      String? purchaseOrderId, 
      String? invoiceId, 
      String? invoiceAmount, 
      String? restaurantName, 
      String? datetime,}){
    _id = id;
    _purchaseOrderId = purchaseOrderId;
    _invoiceId = invoiceId;
    _invoiceAmount = invoiceAmount;
    _restaurantName = restaurantName;
    _datetime = datetime;
}

  Response.fromJson(dynamic json) {
    _id = json['id'];
    _purchaseOrderId = json['purchase_order_id'];
    _invoiceId = json['invoice_id'];
    _invoiceAmount = json['invoice_amount'];
    _restaurantName = json['restaurant_name'];
    _datetime = json['datetime'];
  }
  int? _id;
  String? _purchaseOrderId;
  String? _invoiceId;
  String? _invoiceAmount;
  String? _restaurantName;
  String? _datetime;

  int? get id => _id;
  String? get purchaseOrderId => _purchaseOrderId;
  String? get invoiceId => _invoiceId;
  String? get invoiceAmount => _invoiceAmount;
  String? get restaurantName => _restaurantName;
  String? get datetime => _datetime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['purchase_order_id'] = _purchaseOrderId;
    map['invoice_id'] = _invoiceId;
    map['invoice_amount'] = _invoiceAmount;
    map['restaurant_name'] = _restaurantName;
    map['datetime'] = _datetime;
    return map;
  }

}