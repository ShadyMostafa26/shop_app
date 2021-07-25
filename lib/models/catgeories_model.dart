class CategoriesModel{
  bool status;
  String message;
  Data data;

  CategoriesModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    message = json['message'];
    data = json['data'] != null? Data.fromJson(json['data']) : null;
  }
}

class Data{
  int currentPage;
  List<DataData> data = [];

  Data.fromJson(Map<String,dynamic> json){
    currentPage = json['current_page'];

    json['data'].forEach((element) {
      data.add(DataData.fromJson(element));
    });
  }
}

class DataData{
 int id;
 String name;
 String image;
 dynamic price;

 DataData.fromJson(Map<String,dynamic> json){
   id = json['id'];
   name = json['name'];
   image = json['image'];
 }
}