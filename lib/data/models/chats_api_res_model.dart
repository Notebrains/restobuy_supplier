/// status : 1
/// message : "Chat List"
/// response : [{"ticket_id":"TCKT00001","restaurant_name":"Alam Food & Beverages","replied_by":"Restaurant","message":"Test","datetime":"08:47 AM"},{"ticket_id":"TCKT00001","restaurant_name":"Alam Food & Beverages","replied_by":"Restaurant","message":"Hi","datetime":"09:20 AM"}]

class ChatsApiResModel {
  ChatsApiResModel({
      int? status, 
      String? message, 
      List<Response>? response,}){
    _status = status;
    _message = message;
    _response = response;
}

  ChatsApiResModel.fromJson(dynamic json) {
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

/// ticket_id : "TCKT00001"
/// restaurant_name : "Alam Food & Beverages"
/// replied_by : "Restaurant"
/// message : "Test"
/// datetime : "08:47 AM"

class Response {
  Response({
      String? ticketId, 
      String? restaurantName, 
      String? repliedBy, 
      String? message, 
      String? datetime,}){
    _ticketId = ticketId;
    _restaurantName = restaurantName;
    _repliedBy = repliedBy;
    _message = message;
    _datetime = datetime;
}

  Response.fromJson(dynamic json) {
    _ticketId = json['ticket_id'];
    _restaurantName = json['restaurant_name'];
    _repliedBy = json['replied_by'];
    _message = json['message'];
    _datetime = json['datetime'];
  }
  String? _ticketId;
  String? _restaurantName;
  String? _repliedBy;
  String? _message;
  String? _datetime;

  String? get ticketId => _ticketId;
  String? get restaurantName => _restaurantName;
  String? get repliedBy => _repliedBy;
  String? get message => _message;
  String? get datetime => _datetime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ticket_id'] = _ticketId;
    map['restaurant_name'] = _restaurantName;
    map['replied_by'] = _repliedBy;
    map['message'] = _message;
    map['datetime'] = _datetime;
    return map;
  }

}