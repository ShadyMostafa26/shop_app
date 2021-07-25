import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/cache_helper.dart';
import 'package:shop_app/shared/network/helpers.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if(state is AppLoginSuccessState){
            if(state.loginModel.status){
              CacheHelper.saveData(key: 'token', value: state.loginModel.data.token)
              .then((value) {
                token = state.loginModel.data.token;
                navigateAndFinish(context, ShopLayout());
                AppCubit.get(context).getProfile();
              });
            } else{
             showToast(msg: state.loginModel.message,color: Colors.red[900]);
            }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline5.copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Login in now to buy what you want',
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(height: 2.2, fontSize: 15),
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'please enter your email ';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                          hintText: 'Email Address',
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: !AppCubit.get(context).isVisible,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'please enter your password';
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          if (formKey.currentState.validate()) {
                            AppCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                          hintText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(AppCubit.get(context).suffix),
                            onPressed: () {
                              AppCubit.get(context).changePassVisible();
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      ConditionalBuilder(
                        condition: state is! AppLoginLoadingState,
                        builder: (context) => Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            child: Text('LOGIN'),
                            onPressed: () {
                              if (formKey.currentState.validate()) {
                                AppCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          ),
                        ),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Dont have an account ?'),
                          TextButton(
                            child: Text('Register Now'),
                            onPressed: () {
                              navigateTo(context, RegisterScreen());
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
