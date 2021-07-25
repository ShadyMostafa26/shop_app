import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/cache_helper.dart';
import 'package:shop_app/shared/network/dio_helper.dart';
import 'package:shop_app/shared/network/helpers.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
 await CacheHelper.init();
  Bloc.observer = MyBlocObserver();

  token = CacheHelper.getData(key: 'token');
  print(token);

  Widget widget;
  if(token != null){
    widget = ShopLayout();
  }else{
    widget = LoginScreen();
  }
  runApp(MyApp(startWidget: widget,));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
   MyApp({ this.startWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> AppCubit()..getHomeData()..getCategoryData()..getProfile()..getCartData(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Shop",
            color: Colors.white,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              appBarTheme:AppBarTheme(
                backwardsCompatibility: false,
                iconTheme: IconThemeData(
                    color: Colors.black
                ),
                actionsIconTheme: IconThemeData(
                  color: Colors.black,
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark
                ),
                elevation: 0.0,
                color: Colors.white,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Colors.white,
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.grey,
                showUnselectedLabels: true,
                type:BottomNavigationBarType.fixed,
              ),
            ),
            home: startWidget,
          );
        },
      ),
    );
  }
}
