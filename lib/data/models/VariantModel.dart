/// variant : [{"unit":"1Kg","qty":"100","price":"10"},{"unit":"2kg","qty":"100","price":"20"}]

class VariantModel {
   String unit;
   String qty;
   String price;

  VariantModel(this.unit, this.qty, this.price);

  Map<String, dynamic> toMap() {
    return {
      'unit': unit,
      'quantity': qty,
      'cost': price,
    };
  }
}