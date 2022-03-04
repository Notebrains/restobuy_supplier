/// status : 1
/// message : "Restaurant List and Ticket Id"
/// response : {"restaurant":[{"restaurant_id":1,"restaurant_name":"Ozora"}],"ticket_id":"TCKT00004"}

class RaiseDisputeApiResModel {
  RaiseDisputeApiResModel({
      int? status, 
      String? message, 
      Response? response,}){
    _status = status;
    _message = message;
    _response = response;
}

  RaiseDisputeApiResModel.fromJson(dynamic json) {
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

/// restaurant : [{"restaurant_id":1,"restaurant_name":"Ozora"}]
/// ticket_id : "TCKT00004"

class Response {
  Response({
      List<Restaurant>? restaurant, 
      String? ticketId,}){
    _restaurant = restaurant;
    _ticketId = ticketId;
}

  Response.fromJson(dynamic json) {
    if (json['restaurant'] != null) {
      _restaurant = [];
      json['restaurant'].forEach((v) {
        _restaurant?.add(Restaurant.fromJson(v));
      });
    }
    _ticketId = json['ticket_id'];
  }
  List<Restaurant>? _restaurant;
  String? _ticketId;

  List<Restaurant>? get restaurant => _restaurant;
  String? get ticketId => _ticketId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_restaurant != null) {
      map['restaurant'] = _restaurant?.map((v) => v.toJson()).toList();
    }
    map['ticket_id'] = _ticketId;
    return map;
  }

}

/// restaurant_id : 1
/// restaurant_name : "Ozora"

class Restaurant {
  Restaurant({
      int? restaurantId, 
      String? restaurantName,}){
    _restaurantId = restaurantId;
    _restaurantName = restaurantName;
}

  Restaurant.fromJson(dynamic json) {
    _restaurantId = json['restaurant_id'];
    _restaurantName = json['restaurant_name'];
  }
  int? _restaurantId;
  String? _restaurantName;

  int? get restaurantId => _restaurantId;
  String? get restaurantName => _restaurantName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['restaurant_id'] = _restaurantId;
    map['restaurant_name'] = _restaurantName;
    return map;
  }

}