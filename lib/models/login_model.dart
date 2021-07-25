class LoginModel{
  bool status;
  String message;
  Data data;

  LoginModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    message = json['message'];
    data = json['data'] !=null? Data.fromJson(json['data']) : null;
  }
}

class Data{
  int id;
  String name;
  String email;
  String phone;
  String token;

  Data.fromJson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    token = json['token'];
  }
}