/// status : 1
/// message : "Review List"
/// response : [{"review_id":1,"product_name":"Farm Quail Eggs","rating":5,"review":"nice product","review_by":"Ozora","product_image":"https://mridayaitservices.com/demo/restobuy/uploads/product/40094157_2-fresho-farm-quail-eggs-small-antibiotic-residue-free-1628492715.jpg"}]

class ReviewApiResModel {
  ReviewApiResModel({
      int? status, 
      String? message, 
      List<Response>? response,}){
    _status = status;
    _message = message;
    _response = response;
}

  ReviewApiResModel.fromJson(dynamic json) {
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

/// review_id : 1
/// product_name : "Farm Quail Eggs"
/// rating : 5
/// review : "nice product"
/// review_by : "Ozora"
/// product_image : "https://mridayaitservices.com/demo/restobuy/uploads/product/40094157_2-fresho-farm-quail-eggs-small-antibiotic-residue-free-1628492715.jpg"

class Response {
  Response({
      int? reviewId, 
      String? productName, 
      int? rating, 
      String? review, 
      String? reviewBy, 
      String? productImage,}){
    _reviewId = reviewId;
    _productName = productName;
    _rating = rating;
    _review = review;
    _reviewBy = reviewBy;
    _productImage = productImage;
}

  Response.fromJson(dynamic json) {
    _reviewId = json['review_id'];
    _productName = json['product_name'];
    _rating = json['rating'];
    _review = json['review'];
    _reviewBy = json['review_by'];
    _productImage = json['product_image'];
  }
  int? _reviewId;
  String? _productName;
  int? _rating;
  String? _review;
  String? _reviewBy;
  String? _productImage;

  int? get reviewId => _reviewId;
  String? get productName => _productName;
  int? get rating => _rating;
  String? get review => _review;
  String? get reviewBy => _reviewBy;
  String? get productImage => _productImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['review_id'] = _reviewId;
    map['product_name'] = _productName;
    map['rating'] = _rating;
    map['review'] = _review;
    map['review_by'] = _reviewBy;
    map['product_image'] = _productImage;
    return map;
  }

}