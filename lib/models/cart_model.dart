class CartModel {
  bool status;
  CartData data;

  CartModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = json['data'] != null? CartData.fromJson(json['data']) : null;
  }
}

class CartData {
  List<CartItems> cartItems = [];

  CartData.fromJson(Map<String, dynamic> json){
    json['cart_items'].forEach((element) {
      cartItems.add(CartItems.fromJson(element));
    });
  }
}

class CartItems {
  int id;
  int quantity;
  ProductData product;

  CartItems.fromJson(Map<String, dynamic> json){
    id = json['id'];
    quantity = json['quantity'];
    product = json['product'] != null? ProductData.fromJson(json['product']) : null;
  }
}

class ProductData{
  int id;
  dynamic price;
  String image;
  String name;
  String description;

  ProductData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}