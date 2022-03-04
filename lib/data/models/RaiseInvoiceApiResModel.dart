/// status : 1
/// message : "Restaurant List"
/// response : [{"restaurant_id":1,"restaurant_name":"Ozora","email":"tapan@gmail.com"}]

class RaiseInvoiceApiResModel {
  RaiseInvoiceApiResModel({
      int? status, 
      String? message, 
      List<Response>? response,}){
    _status = status;
    _message = message;
    _response = response;
}

  RaiseInvoiceApiResModel.fromJson(dynamic json) {
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

/// restaurant_id : 1
/// restaurant_name : "Ozora"
/// email : "tapan@gmail.com"

class Response {
  Response({
      int? restaurantId, 
      String? restaurantName, 
      String? email,}){
    _restaurantId = restaurantId;
    _restaurantName = restaurantName;
    _email = email;
}

  Response.fromJson(dynamic json) {
    _restaurantId = json['restaurant_id'];
    _restaurantName = json['restaurant_name'];
    _email = json['email'];
  }
  int? _restaurantId;
  String? _restaurantName;
  String? _email;

  int? get restaurantId => _restaurantId;
  String? get restaurantName => _restaurantName;
  String? get email => _email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['restaurant_id'] = _restaurantId;
    map['restaurant_name'] = _restaurantName;
    map['email'] = _email;
    return map;
  }

}