/// status : 1
/// message : "Purchase Orders List"
/// response : [{"purchase_order_id":"PO00001"}]

class PoListApiResModel {
  PoListApiResModel({
      int? status, 
      String? message, 
      List<Response>? response,}){
    _status = status;
    _message = message;
    _response = response;
}

  PoListApiResModel.fromJson(dynamic json) {
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

/// purchase_order_id : "PO00001"

class Response {
  Response({
      String? purchaseOrderId,}){
    _purchaseOrderId = purchaseOrderId;
}

  Response.fromJson(dynamic json) {
    _purchaseOrderId = json['purchase_order_id'];
  }
  String? _purchaseOrderId;

  String? get purchaseOrderId => _purchaseOrderId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['purchase_order_id'] = _purchaseOrderId;
    return map;
  }

}