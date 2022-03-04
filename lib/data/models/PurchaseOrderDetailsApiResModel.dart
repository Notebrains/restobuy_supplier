/// status : 1
/// message : "Product Order Details"
/// response : {"products":[{"image":"https://mridayaitservices.com/demo/restobuy/uploads/product/fresho-mutton-mince-antibiotic-residue-free-growth-hormone-free-1628493230.jpg","product_name":"Mutton - Mince","variant":"500 g","price":"$400","qty":"2","subtotal":"$800"}],"pdffile":{"pdf":"http://www.africau.edu/images/default/sample.pdf"}}

class PurchaseOrderDetailsApiResModel {
  PurchaseOrderDetailsApiResModel({
      int? status, 
      String? message, 
      Response? response,}){
    _status = status;
    _message = message;
    _response = response;
}

  PurchaseOrderDetailsApiResModel.fromJson(dynamic json) {
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

/// products : [{"image":"https://mridayaitservices.com/demo/restobuy/uploads/product/fresho-mutton-mince-antibiotic-residue-free-growth-hormone-free-1628493230.jpg","product_name":"Mutton - Mince","variant":"500 g","price":"$400","qty":"2","subtotal":"$800"}]
/// pdffile : {"pdf":"http://www.africau.edu/images/default/sample.pdf"}

class Response {
  Response({
      List<Products>? products, 
      Pdffile? pdffile,}){
    _products = products;
    _pdffile = pdffile;
}

  Response.fromJson(dynamic json) {
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products?.add(Products.fromJson(v));
      });
    }
    _pdffile = json['pdffile'] != null ? Pdffile.fromJson(json['pdffile']) : null;
  }
  List<Products>? _products;
  Pdffile? _pdffile;

  List<Products>? get products => _products;
  Pdffile? get pdffile => _pdffile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_products != null) {
      map['products'] = _products?.map((v) => v.toJson()).toList();
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

/// image : "https://mridayaitservices.com/demo/restobuy/uploads/product/fresho-mutton-mince-antibiotic-residue-free-growth-hormone-free-1628493230.jpg"
/// product_name : "Mutton - Mince"
/// variant : "500 g"
/// price : "$400"
/// qty : "2"
/// subtotal : "$800"

class Products {
  Products({
      String? image, 
      String? productName, 
      String? variant, 
      String? price, 
      String? qty, 
      String? subtotal,}){
    _image = image;
    _productName = productName;
    _variant = variant;
    _price = price;
    _qty = qty;
    _subtotal = subtotal;
}

  Products.fromJson(dynamic json) {
    _image = json['image'];
    _productName = json['product_name'];
    _variant = json['variant'];
    _price = json['price'];
    _qty = json['qty'];
    _subtotal = json['subtotal'];
  }
  String? _image;
  String? _productName;
  String? _variant;
  String? _price;
  String? _qty;
  String? _subtotal;

  String? get image => _image;
  String? get productName => _productName;
  String? get variant => _variant;
  String? get price => _price;
  String? get qty => _qty;
  String? get subtotal => _subtotal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image'] = _image;
    map['product_name'] = _productName;
    map['variant'] = _variant;
    map['price'] = _price;
    map['qty'] = _qty;
    map['subtotal'] = _subtotal;
    return map;
  }

}