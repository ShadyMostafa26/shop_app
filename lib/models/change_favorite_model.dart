class ChangeFavoriteModel {
  bool status;
  String message;
  FavoriteData data;

  ChangeFavoriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null? FavoriteData.fromJson(json['data']) : null;
  }
}


class FavoriteData{
  int id;
  ProductData product;

FavoriteData.fromJson(Map<String, dynamic> json){
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