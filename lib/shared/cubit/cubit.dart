import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/cart_model.dart';
import 'package:shop_app/models/catgeories_model.dart';
import 'package:shop_app/models/change_cart_model.dart';
import 'package:shop_app/models/change_favorite_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/category/category_screen.dart';
import 'package:shop_app/modules/favorite/favorite_screen.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/product/prodcut_screen.dart';
import 'package:shop_app/modules/setting/setting_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/cache_helper.dart';
import 'package:shop_app/shared/network/dio_helper.dart';
import 'package:shop_app/shared/network/helpers.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isVisible = false;
  IconData suffix = Icons.visibility;

  void changePassVisible() {
    isVisible = !isVisible;
    suffix = isVisible ? Icons.visibility_off : Icons.visibility;
    emit(AppChangePassVisible());
  }

  int currentIndex = 0;

  List<Widget> screens = [
    ProductScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingScreen(),
  ];

  List<String> titles = [
    'Product',
    'Categories',
    'Favorites',
    'Setting',
  ];

  void changeBottomNav(index) {
    currentIndex = index;
    if (currentIndex == 2) {
      getFavoriteData();
    }

    if (currentIndex == 3) {
      getProfile();
    }
    emit(AppChangeBottomNavState());
  }

  LoginModel loginModel;

  void userLogin({
    @required String email,
    @required String password,
  }) {
    emit(AppLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(AppLoginSuccessState(loginModel));
      getProfile();
    }).catchError((error) {
      print(error.toString());
      emit(AppLoginErrorState(error.toString()));
    });
  }

  LoginModel registerModel;

  void userRegister({
    @required String email,
    @required String name,
    @required String phone,
    @required String password,
  }) {
    emit(AppRegisterLoadingState());
    DioHelper.postData(
      url: 'register',
      data: {
        'email': email,
        'name': name,
        'phone': phone,
        'password': password,
      },
    ).then((value) {
      registerModel = LoginModel.fromJson(value.data);
      emit(AppRegisterSuccessState(registerModel));
      getProfile();
    }).catchError((error) {
      print(error.toString());
      emit(AppRegisterErrorState(error.toString()));
    });
  }

  HomeModel homeModel;
  Map<int, bool> favorites = {};
  Map<int, bool> carts = {};

  void getHomeData() {
    emit(GetHomeDataLoadingState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorite,
        });
        carts.addAll({
          element.id : element.inCart,
        });
      });
      //print(favorites.toString());
      emit(GetHomeDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetHomeDataErrorState(error.toString()));
    });
  }

  CategoriesModel categoriesModel;

  void getCategoryData() {
    DioHelper.getData(
      url: CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(GetCategoryDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetCategoryDataErrorState(error.toString()));
    });
  }

  ChangeFavoriteModel changeFavoriteModel;
  void changeFavorite(int productId) {
    favorites[productId] = !favorites[productId];
    emit(ChangeFavoriteState());

    DioHelper.postData(
      url: FAVORITES,
      token: token,
      data: {
        'product_id': productId,
      },
    ).then((value) {
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);

      if (!changeFavoriteModel.status) {
        favorites[productId] = !favorites[productId];
      } else {
        getFavoriteData();
      }
      emit(ChangeFavoriteSuccessState(changeFavoriteModel));
    }).catchError((error) {
      print(error.toString());
      emit(ChangeFavoriteErrorState());
    });
  }


  ChangeCartModel changeCartModel;
  void changeCart(int productId) {
    carts[productId] = !carts[productId];
    emit(ChangeCartState());

    DioHelper.postData(
      url: 'carts',
      token: token,
      data: {
        'product_id': productId,
      },
    ).then((value) {
      changeCartModel = ChangeCartModel.fromJson(value.data);

      if (!changeCartModel.status) {
        carts[productId] = !carts[productId];
      } else {
        getCartData();
      }
      emit(ChangeCartSuccessState(changeCartModel));
    }).catchError((error) {
      print(error.toString());
      emit(ChangeCartErrorState());
    });
  }


  FavoriteModel favoriteModel;
  void getFavoriteData() {
    emit(GetFavoriteDataLoadingState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      print(favoriteModel.data.currentPage);
      emit(GetFavoriteDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetFavoriteDataErrorState());
    });
  }

  CartModel cartModel;
  void getCartData() {
    emit(GetCartDataLoadingState());
    DioHelper.getData(
      url: 'carts',
      token: token,
    ).then((value) {
      cartModel = CartModel.fromJson(value.data);
      emit(GetCartDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetCartDataErrorState());
    });
  }


  LoginModel userModel;
  void getProfile() {
    emit(GetProfileDataLoadingState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      emit(GetProfileDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetProfileDataErrorState(error.toString()));
    });
  }

  void updateUser({
    String email,
    String name,
    String phone,
  }) {
    emit(UserUpdateLoadingState());
    DioHelper.updateData(
      url: 'update-profile',
      token: token,
      data: {
        'email': email,
        'name': name,
        'phone': phone,
      },
    ).then((value) {
      getProfile();
    }).catchError((error) {
      print(error.toString());
      emit(UserUpdateErrorState());
    });
  }

  void logout(context) {
    CacheHelper.removeData(key: 'token').then((value) {
      if (value) {
        navigateAndFinish(
          context,
          LoginScreen(),
        );
        currentIndex = 0;
      }
    });
  }

  SearchModel searchModel;
  void searchProduct({String s}) {
    emit(SearchLoadingState());
    DioHelper.postData(
      url: 'products/search',
      token: token,
      data: {
        'text': s,
      },
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}
