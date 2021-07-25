class SearchModel {
  bool status;
  SearchData data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null? SearchData.fromJson(json['data']) : null;
  }
}


class SearchData{
  List<SearchDataData> data = [];

  SearchData.fromJson(Map<String, dynamic> json){
    json['data'].forEach((element) {
      data.add(SearchDataData.fromJson(element));
    });
  }
}

class SearchDataData{
  int id;
  dynamic price;
  String name;
  String image;

  SearchDataData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    price = json['price'];
    name = json['name'];
    image = json['image'];
  }

}

