class HomeModel{
  bool status;
  String message;
  Data data;

  HomeModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    message = json['message'];
    data = json['data'] != null? Data.fromJson(json['data']) : null;
  }
}

//'data' : data.toJson(),

class Data{
  List<Banners> banners = [];
  List<Products> products = [];

  Data.fromJson(Map<String,dynamic> json){
    json['banners'].forEach((element) {
      banners.add(Banners.fromJson(element));
    });

    json['products'].forEach((element) {
      products.add(Products.fromJson(element));
    });
  }
}

class Banners{
  int id;
  String image;
  Category category;

  Banners.fromJson(Map<String,dynamic> json){
    id = json['id'];
    image = json['image'];
    category = json['category'] != null? Category.fromJson(json['category']) : null;
  }
}
class Category{
  int id;
  String image;
  String name;

  Category.fromJson(Map<String,dynamic> json){
    id = json['id'];
    image = json['image'];
    name = json['name'];
  }
}

class Products{
 int id;
 dynamic price;
 dynamic oldPrice;
 dynamic discount;
 String image;
 String name;
 String description;
 List<String> images;
 bool inFavorite;
 bool inCart;

 Products.fromJson(Map<String,dynamic> json){
   id = json['id'];
   price = json['price'];
   oldPrice = json['old_price'];
   discount = json['discount'];
   image = json['image'];
   name = json['name'];
   description = json['description'];
   images = json['images'].cast<String>();
   inFavorite = json['in_favorites'];
   inCart = json['in_cart'];
 }
}

// 'images': images