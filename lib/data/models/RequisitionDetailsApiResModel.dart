/// status : 1
/// message : "Requisitions Product List"
/// response : {"requisitions_product":[{"requisition_id":6,"product_name":"Fruits and Vegitables","image":"https://mridayaitservices.com/demo/restobuy/uploads/product/download (2)-1629288288.jpg","variant":"2 Kg","price":"$100","qty":"3","subtotal":300,"status":"Available"},{"requisition_id":5,"product_name":"Fruits","image":"https://mridayaitservices.com/demo/restobuy/uploads/product/culture-2-1643263670.png","variant":"1Kg","price":"$10","qty":"5","subtotal":50,"status":"Partially Available"}],"pdffile":{"pdf":"http://www.africau.edu/images/default/sample.pdf"}}

class RequisitionDetailsApiResModel {
  RequisitionDetailsApiResModel({
      int? status, 
      String? message, 
      Response? response,}){
    _status = status;
    _message = message;
    _response = response;
}

  RequisitionDetailsApiResModel.fromJson(dynamic json) {
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

/// requisitions_product : [{"requisition_id":6,"product_name":"Fruits and Vegitables","image":"https://mridayaitservices.com/demo/restobuy/uploads/product/download (2)-1629288288.jpg","variant":"2 Kg","price":"$100","qty":"3","subtotal":300,"status":"Available"},{"requisition_id":5,"product_name":"Fruits","image":"https://mridayaitservices.com/demo/restobuy/uploads/product/culture-2-1643263670.png","variant":"1Kg","price":"$10","qty":"5","subtotal":50,"status":"Partially Available"}]
/// pdffile : {"pdf":"http://www.africau.edu/images/default/sample.pdf"}

class Response {
  Response({
      List<RequisitionsProduct>? requisitionsProduct, 
      Pdffile? pdffile,}){
    _requisitionsProduct = requisitionsProduct;
    _pdffile = pdffile;
}

  Response.fromJson(dynamic json) {
    if (json['requisitions_product'] != null) {
      _requisitionsProduct = [];
      json['requisitions_product'].forEach((v) {
        _requisitionsProduct?.add(RequisitionsProduct.fromJson(v));
      });
    }
    _pdffile = json['pdffile'] != null ? Pdffile.fromJson(json['pdffile']) : null;
  }
  List<RequisitionsProduct>? _requisitionsProduct;
  Pdffile? _pdffile;

  List<RequisitionsProduct>? get requisitionsProduct => _requisitionsProduct;
  Pdffile? get pdffile => _pdffile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_requisitionsProduct != null) {
      map['requisitions_product'] = _requisitionsProduct?.map((v) => v.toJson()).toList();
    }
    if (_pdffile != null) {
      map['pdffile'] = _pdffile?.toJson();
    }
    return map;
  }

}

/// pdf : "http://www.africau.edu/images/default/sample.pdf"

class Pdffile {
  Pdffile({
      String? pdf,}){
    _pdf = pdf;
}

  Pdffile.fromJson(dynamic json) {
    _pdf = json['pdf'];
  }
  String? _pdf;

  String? get pdf => _pdf;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pdf'] = _pdf;
    return map;
  }

}

/// requisition_id : 6
/// product_name : "Fruits and Vegitables"
/// image : "https://mridayaitservices.com/demo/restobuy/uploads/product/download (2)-1629288288.jpg"
/// variant : "2 Kg"
/// price : "$100"
/// qty : "3"
/// subtotal : 300
/// status : "Available"

class RequisitionsProduct {
  RequisitionsProduct({
      int? requisitionId, 
      String? productName, 
      String? image, 
      String? variant, 
      String? price, 
      String? qty, 
      int? subtotal, 
      String? status,}){
    _requisitionId = requisitionId;
    _productName = productName;
    _image = image;
    _variant = variant;
    _price = price;
    _qty = qty;
    _subtotal = subtotal;
    _status = status;
}

  RequisitionsProduct.fromJson(dynamic json) {
    _requisitionId = json['requisition_id'];
    _productName = json['product_name'];
    _image = json['image'];
    _variant = json['variant'];
    _price = json['price'];
    _qty = json['qty'];
    _subtotal = json['subtotal'];
    _status = json['status'];
  }
  int? _requisitionId;
  String? _productName;
  String? _image;
  String? _variant;
  String? _price;
  String? _qty;
  int? _subtotal;
  String? _status;

  int? get requisitionId => _requisitionId;
  String? get productName => _productName;
  String? get image => _image;
  String? get variant => _variant;
  String? get price => _price;
  String? get qty => _qty;
  int? get subtotal => _subtotal;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['requisition_id'] = _requisitionId;
    map['product_name'] = _productName;
    map['image'] = _image;
    map['variant'] = _variant;
    map['price'] = _price;
    map['qty'] = _qty;
    map['subtotal'] = _subtotal;
    map['status'] = _status;
    return map;
  }

}