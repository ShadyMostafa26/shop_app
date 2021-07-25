import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/cache_helper.dart';
import 'package:shop_app/shared/network/helpers.dart';

class RegisterScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if(state is AppRegisterSuccessState){
          if(state.registerModel.status){
            CacheHelper.saveData(key: 'token', value: state.registerModel.data.token)
                .then((value) {
              token = state.registerModel.data.token;
              navigateAndFinish(context, ShopLayout());
              AppCubit.get(context).getProfile();
            });
          } else{
            showToast(msg: state.registerModel.message,color: Colors.red[900]);
          }
        }
      },
      builder: (context, state) {
        return BlocConsumer<AppCubit,AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return  Scaffold(
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
                            'Register',
                            style: Theme.of(context).textTheme.headline5.copyWith(
                                color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Register now to buy what you want',
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(height: 1.2),
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
                            controller: nameController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'please enter your name ';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.person),
                              hintText: 'Name',
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'please enter your phone ';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.phone),
                              hintText: 'Phone',
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: passwordController,
                            obscureText: !AppCubit.get(context).isVisible,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'please enter your password';
                              }
                              return null;
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
                            condition: state is! AppRegisterLoadingState,
                            builder: (context) => Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                child: Text('REGISTER'),
                                onPressed: () {
                                  if (formKey.currentState.validate()) {
                                    AppCubit.get(context).userRegister(
                                      email: emailController.text,
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                              ),
                            ),
                            fallback: (context) => Center(child: CircularProgressIndicator()),
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
      },
    );
  }
}
