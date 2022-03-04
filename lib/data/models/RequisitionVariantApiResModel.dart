/// status : 1
/// message : "Variant List"
/// response : [{"unit":"6 Pcs"},{"unit":"4 x 6 Pcs Multipack"},{"unit":"5 x 6 Pcs Multipack"}]

class RequisitionVariantApiResModel {
  RequisitionVariantApiResModel({
      int? status, 
      String? message, 
      List<Response>? response,}){
    _status = status;
    _message = message;
    _response = response;
}

  RequisitionVariantApiResModel.fromJson(dynamic json) {
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

/// unit : "6 Pcs"

class Response {
  Response({
      String? unit,}){
    _unit = unit;
}

  Response.fromJson(dynamic json) {
    _unit = json['unit'];
  }
  String? _unit;

  String? get unit => _unit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unit'] = _unit;
    return map;
  }

}