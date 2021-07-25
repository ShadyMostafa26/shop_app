class FavoriteModel {
  bool status;
  FavoriteData data;

  FavoriteModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = json['data'] != null? FavoriteData.fromJson(json['data']) : null;
  }
}

class FavoriteData {
  int currentPage;
  List<Data> data = [];

  FavoriteData.fromJson(Map<String, dynamic> json){
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(Data.fromJson(element));
    });
  }
}

class Data {
  int id;
  ProductData product;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    product = json['product'] != null? ProductData.fromJson(json['product']) : null;
  }
}

class ProductData{
  int id;
  dynamic price;
  String image;
  String name;

  ProductData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
  }
}