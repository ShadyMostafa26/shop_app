class ChangeCartModel {
  bool status;
  String message;
  CartData data;

  ChangeCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null? CartData.fromJson(json['data']) : null;
  }
}


class CartData{
  int id;
  ProductData product;

  CartData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    product = json['product'] != null? ProductData.fromJson(json['product']) : null;
  }
}


class ProductData{
  int id;
  dynamic price;
  String image;

  ProductData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    price = json['price'];
    image = json['image'];
  }
}