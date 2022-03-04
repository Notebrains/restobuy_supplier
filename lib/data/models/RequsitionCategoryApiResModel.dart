/// status : 1
/// message : "Category List"
/// response : [{"category_id":1,"category_name":"Bakery, Cakes & Dairy","image":"https://mridayaitservices.com/demo/restobuy/uploads/category/thumb-1-1627647837.jpg","icon":""},{"category_id":2,"category_name":"Egg, Meat & Fish","image":"https://mridayaitservices.com/demo/restobuy/uploads/category/thumb-1-1627883393.jpg","icon":""},{"category_id":3,"category_name":"Foodgrains, Oil & Masala","image":"https://mridayaitservices.com/demo/restobuy/uploads/category/thumb-1-1627651363.jpg","icon":""},{"category_id":4,"category_name":"Fruit & Vegetables","image":"https://mridayaitservices.com/demo/restobuy/uploads/category/logo1-1627651562.png","icon":""},{"category_id":5,"category_name":"Beverages","image":"https://mridayaitservices.com/demo/restobuy/uploads/category/beverages-630861 (1)-1628491561.png","icon":""}]

class RequsitionCategoryApiResModel {
  RequsitionCategoryApiResModel({
      int? status, 
      String? message, 
      List<Response>? response,}){
    _status = status;
    _message = message;
    _response = response;
}

  RequsitionCategoryApiResModel.fromJson(dynamic json) {
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

/// category_id : 1
/// category_name : "Bakery, Cakes & Dairy"
/// image : "https://mridayaitservices.com/demo/restobuy/uploads/category/thumb-1-1627647837.jpg"
/// icon : ""

class Response {
  Response({
      int? categoryId, 
      String? categoryName, 
      String? image, 
      String? icon,}){
    _categoryId = categoryId;
    _categoryName = categoryName;
    _image = image;
    _icon = icon;
}

  Response.fromJson(dynamic json) {
    _categoryId = json['category_id'];
    _categoryName = json['category_name'];
    _image = json['image'];
    _icon = json['icon'];
  }
  int? _categoryId;
  String? _categoryName;
  String? _image;
  String? _icon;

  int? get categoryId => _categoryId;
  String? get categoryName => _categoryName;
  String? get image => _image;
  String? get icon => _icon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['category_id'] = _categoryId;
    map['category_name'] = _categoryName;
    map['image'] = _image;
    map['icon'] = _icon;
    return map;
  }

}