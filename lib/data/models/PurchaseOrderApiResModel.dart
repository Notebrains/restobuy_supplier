/// status : 1
/// message : "Product Orders List"
/// response : [{"purchase_order_id":4,"order_id":"PO00004","purchase_amount":"$100","restaurant_name":"Ozora","datetime":"22-02-2022 11:39 AM","total_items":1},{"purchase_order_id":3,"order_id":"PO00003","purchase_amount":"$210","restaurant_name":"Ozora","datetime":"22-02-2022 11:36 AM","total_items":2},{"purchase_order_id":2,"order_id":"PO00002","purchase_amount":"$80","restaurant_name":"Ozora","datetime":"09-02-2022 06:16 AM","total_items":1}]

class PurchaseOrderApiResModel {
  PurchaseOrderApiResModel({
      int? status, 
      String? message, 
      List<Response>? response,}){
    _status = status;
    _message = message;
    _response = response;
}

  PurchaseOrderApiResModel.fromJson(dynamic json) {
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

/// purchase_order_id : 4
/// order_id : "PO00004"
/// purchase_amount : "$100"
/// restaurant_name : "Ozora"
/// datetime : "22-02-2022 11:39 AM"
/// total_items : 1

class Response {
  Response({
      int? purchaseOrderId, 
      String? orderId, 
      String? purchaseAmount, 
      String? restaurantName, 
      String? datetime, 
      int? totalItems,}){
    _purchaseOrderId = purchaseOrderId;
    _orderId = orderId;
    _purchaseAmount = purchaseAmount;
    _restaurantName = restaurantName;
    _datetime = datetime;
    _totalItems = totalItems;
}

  Response.fromJson(dynamic json) {
    _purchaseOrderId = json['purchase_order_id'];
    _orderId = json['order_id'];
    _purchaseAmount = json['purchase_amount'];
    _restaurantName = json['restaurant_name'];
    _datetime = json['datetime'];
    _totalItems = json['total_items'];
  }
  int? _purchaseOrderId;
  String? _orderId;
  String? _purchaseAmount;
  String? _restaurantName;
  String? _datetime;
  int? _totalItems;

  int? get purchaseOrderId => _purchaseOrderId;
  String? get orderId => _orderId;
  String? get purchaseAmount => _purchaseAmount;
  String? get restaurantName => _restaurantName;
  String? get datetime => _datetime;
  int? get totalItems => _totalItems;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['purchase_order_id'] = _purchaseOrderId;
    map['order_id'] = _orderId;
    map['purchase_amount'] = _purchaseAmount;
    map['restaurant_name'] = _restaurantName;
    map['datetime'] = _datetime;
    map['total_items'] = _totalItems;
    return map;
  }

}