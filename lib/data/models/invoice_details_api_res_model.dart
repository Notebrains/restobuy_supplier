/// status : 1
/// message : "Invoice Details"
/// response : {"restaurant_name":"Ozora","purchase_order_id":"PO00006","invoice_id":"INV00002","invoice_amount":"$450","datetime":"24-01-2022 12:51:32","pdf":"http://www.africau.edu/images/default/sample.pdf","products":[{"image":"https://mridayaitservices.com/demo/restobuy/uploads/product/40094157_2-fresho-farm-quail-eggs-small-antibiotic-residue-free-1628492715.jpg","product_name":"Farm Quail Eggs","variant":"4 x 6 Pcs Multipack","price":"$300","qty":"1","subtotal":"$300"},{"image":"https://mridayaitservices.com/demo/restobuy/uploads/product/40094157_2-fresho-farm-quail-eggs-small-antibiotic-residue-free-1628492715.jpg","product_name":"Farm Quail Eggs","variant":"6 Pcs","price":"$75","qty":"2","subtotal":"$150"}]}

class InvoiceDetailsApiResModel {
  InvoiceDetailsApiResModel({
      int? status, 
      String? message, 
      Response? response,}){
    _status = status;
    _message = message;
    _response = response;
}

  InvoiceDetailsApiResModel.fromJson(dynamic json) {
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

/// restaurant_name : "Ozora"
/// purchase_order_id : "PO00006"
/// invoice_id : "INV00002"
/// invoice_amount : "$450"
/// datetime : "24-01-2022 12:51:32"
/// pdf : "http://www.africau.edu/images/default/sample.pdf"
/// products : [{"image":"https://mridayaitservices.com/demo/restobuy/uploads/product/40094157_2-fresho-farm-quail-eggs-small-antibiotic-residue-free-1628492715.jpg","product_name":"Farm Quail Eggs","variant":"4 x 6 Pcs Multipack","price":"$300","qty":"1","subtotal":"$300"},{"image":"https://mridayaitservices.com/demo/restobuy/uploads/product/40094157_2-fresho-farm-quail-eggs-small-antibiotic-residue-free-1628492715.jpg","product_name":"Farm Quail Eggs","variant":"6 Pcs","price":"$75","qty":"2","subtotal":"$150"}]

class Response {
  Response({
      String? restaurantName, 
      String? purchaseOrderId, 
      String? invoiceId, 
      String? invoiceAmount, 
      String? datetime, 
      String? pdf, 
      List<Products>? products,}){
    _restaurantName = restaurantName;
    _purchaseOrderId = purchaseOrderId;
    _invoiceId = invoiceId;
    _invoiceAmount = invoiceAmount;
    _datetime = datetime;
    _pdf = pdf;
    _products = products;
}

  Response.fromJson(dynamic json) {
    _restaurantName = json['restaurant_name'];
    _purchaseOrderId = json['purchase_order_id'];
    _invoiceId = json['invoice_id'];
    _invoiceAmount = json['invoice_amount'];
    _datetime = json['datetime'];
    _pdf = json['pdf'];
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products?.add(Products.fromJson(v));
      });
    }
  }
  String? _restaurantName;
  String? _purchaseOrderId;
  String? _invoiceId;
  String? _invoiceAmount;
  String? _datetime;
  String? _pdf;
  List<Products>? _products;

  String? get restaurantName => _restaurantName;
  String? get purchaseOrderId => _purchaseOrderId;
  String? get invoiceId => _invoiceId;
  String? get invoiceAmount => _invoiceAmount;
  String? get datetime => _datetime;
  String? get pdf => _pdf;
  List<Products>? get products => _products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['restaurant_name'] = _restaurantName;
    map['purchase_order_id'] = _purchaseOrderId;
    map['invoice_id'] = _invoiceId;
    map['invoice_amount'] = _invoiceAmount;
    map['datetime'] = _datetime;
    map['pdf'] = _pdf;
    if (_products != null) {
      map['products'] = _products?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// image : "https://mridayaitservices.com/demo/restobuy/uploads/product/40094157_2-fresho-farm-quail-eggs-small-antibiotic-residue-free-1628492715.jpg"
/// product_name : "Farm Quail Eggs"
/// variant : "4 x 6 Pcs Multipack"
/// price : "$300"
/// qty : "1"
/// subtotal : "$300"

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