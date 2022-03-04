/// status : 1
/// message : "Product List"
/// response : [{"product_id":2,"product_name":"Farm Quail Eggs"},{"product_id":1,"product_name":"Mutton - Mince"}]

class RequisitionProductApiResModel {
  RequisitionProductApiResModel({
      int? status, 
      String? message, 
      List<Response>? response,}){
    _status = status;
    _message = message;
    _response = response;
}

  RequisitionProductApiResModel.fromJson(dynamic json) {
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

/// product_id : 2
/// product_name : "Farm Quail Eggs"

class Response {
  Response({
      int? productId, 
      String? productName,}){
    _productId = productId;
    _productName = productName;
}

  Response.fromJson(dynamic json) {
    _productId = json['product_id'];
    _productName = json['product_name'];
  }
  int? _productId;
  String? _productName;

  int? get productId => _productId;
  String? get productName => _productName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_id'] = _productId;
    map['product_name'] = _productName;
    return map;
  }

}