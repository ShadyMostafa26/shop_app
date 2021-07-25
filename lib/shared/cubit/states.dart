import 'package:shop_app/models/change_cart_model.dart';
import 'package:shop_app/models/change_favorite_model.dart';
import 'package:shop_app/models/login_model.dart';

abstract class AppStates{}

class AppInitialState extends AppStates{}

class AppChangePassVisible extends AppStates{}

class AppChangeBottomNavState extends AppStates{}

class AppLoginLoadingState extends AppStates{}
class AppLoginSuccessState extends AppStates{
  final LoginModel loginModel;

  AppLoginSuccessState(this.loginModel);
}
class AppLoginErrorState extends AppStates{
  final String error;
  AppLoginErrorState(this.error);
}


class AppRegisterLoadingState extends AppStates{}
class AppRegisterSuccessState extends AppStates{
  final LoginModel registerModel;

  AppRegisterSuccessState(this.registerModel);
}
class AppRegisterErrorState extends AppStates{
  final String error;
  AppRegisterErrorState(this.error);
}


class GetHomeDataLoadingState extends AppStates{}
class GetHomeDataSuccessState extends AppStates{}
class GetHomeDataErrorState extends AppStates{
  final String error;
  GetHomeDataErrorState(this.error);
}

class GetCategoryDataLoadingState extends AppStates{}
class GetCategoryDataSuccessState extends AppStates{}
class GetCategoryDataErrorState extends AppStates{
  final String error;
  GetCategoryDataErrorState(this.error);
}

class ChangeFavoriteSuccessState extends AppStates{
  final ChangeFavoriteModel changeFavoriteModel;

  ChangeFavoriteSuccessState(this.changeFavoriteModel);
}
class ChangeFavoriteState extends AppStates{}
class ChangeFavoriteErrorState extends AppStates{}


class ChangeCartSuccessState extends AppStates{
  final ChangeCartModel changeCartModel;

  ChangeCartSuccessState(this.changeCartModel);
}
class ChangeCartState extends AppStates{}
class ChangeCartErrorState extends AppStates{}

class GetFavoriteDataLoadingState extends AppStates{}
class GetFavoriteDataSuccessState extends AppStates{}
class GetFavoriteDataErrorState extends AppStates{}


class GetCartDataLoadingState extends AppStates{}
class GetCartDataSuccessState extends AppStates{}
class GetCartDataErrorState extends AppStates{}


class GetProfileDataLoadingState extends AppStates{}
class GetProfileDataSuccessState extends AppStates{}
class GetProfileDataErrorState extends AppStates{
  final String error;
  GetProfileDataErrorState(this.error);
}


class UserUpdateLoadingState extends AppStates{}
class UserUpdateSuccessState extends AppStates{}
class UserUpdateErrorState extends AppStates{}


class SearchLoadingState extends AppStates{}
class SearchSuccessState extends AppStates{}
class SearchErrorState extends AppStates{}