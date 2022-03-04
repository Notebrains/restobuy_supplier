/// status : 1
/// message : "Requisitions List"
/// response : [{"requisition_id":2,"order_id":"RQ00002","restaurant_name":"Ozora","datetime":"09-02-2022 02:56 PM","items":2},{"requisition_id":1,"order_id":"RQ00001","restaurant_name":"Ozora","datetime":"09-02-2022 06:13 AM","items":2}]

class RequisitionApiResModel {
  RequisitionApiResModel({
      int? status, 
      String? message, 
      List<Response>? response,}){
    _status = status;
    _message = message;
    _response = response;
}

  RequisitionApiResModel.fromJson(dynamic json) {
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

/// requisition_id : 2
/// order_id : "RQ00002"
/// restaurant_name : "Ozora"
/// datetime : "09-02-2022 02:56 PM"
/// items : 2

class Response {
  Response({
      int? requisitionId, 
      String? orderId, 
      String? restaurantName, 
      String? datetime, 
      int? items,}){
    _requisitionId = requisitionId;
    _orderId = orderId;
    _restaurantName = restaurantName;
    _datetime = datetime;
    _items = items;
}

  Response.fromJson(dynamic json) {
    _requisitionId = json['requisition_id'];
    _orderId = json['order_id'];
    _restaurantName = json['restaurant_name'];
    _datetime = json['datetime'];
    _items = json['items'];
  }
  int? _requisitionId;
  String? _orderId;
  String? _restaurantName;
  String? _datetime;
  int? _items;

  int? get requisitionId => _requisitionId;
  String? get orderId => _orderId;
  String? get restaurantName => _restaurantName;
  String? get datetime => _datetime;
  int? get items => _items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['requisition_id'] = _requisitionId;
    map['order_id'] = _orderId;
    map['restaurant_name'] = _restaurantName;
    map['datetime'] = _datetime;
    map['items'] = _items;
    return map;
  }

}