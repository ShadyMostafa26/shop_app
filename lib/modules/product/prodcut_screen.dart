import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/catgeories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if(state is ChangeFavoriteSuccessState){
          if(!state.changeFavoriteModel.status){
            showToast(
              msg: state.changeFavoriteModel.message,
              color: Colors.green,
            );
          }
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoriesModel !=null,
          builder: (context) => productsBuilder(cubit.homeModel,cubit.categoriesModel,context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productsBuilder(HomeModel model,CategoriesModel categoriesModel,context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                items: model.data.banners.map((e) {
                  return Image.network(
                    e.image,
                    fit: BoxFit.fill,
                    width: double.infinity,
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 200,
                  scrollDirection: Axis.horizontal,
                  reverse: false,
                  autoPlay: true,
                  enableInfiniteScroll: true,
                  autoPlayInterval: Duration(seconds: 3),
                  viewportFraction: 1,
                  autoPlayAnimationDuration: Duration(seconds: 2),
                  autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                ),
              ),
              SizedBox(height: 10),
              Text('Categories',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                SizedBox(height: 4),
               Container(
                 //width: MediaQuery.of(context).size.width,
                 height: 100,
                 child: ListView.separated(
                   physics: BouncingScrollPhysics(),
                   scrollDirection:Axis.horizontal ,
                     itemBuilder: (context, index) => buildCategoryItem(categoriesModel.data.data[index]),
                     separatorBuilder: (context, index) => SizedBox(width: 8),
                     itemCount: categoriesModel.data.data.length,
                 ),
               ),
              GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                crossAxisSpacing: 10,
                childAspectRatio: 1 / 1.8,
                children: List.generate(
                  model.data.products.length,
                  (index) => buildGridProduct(model.data.products[index],context),
                ),
              ),
            ],
          ),
    ),
  );

  Widget buildGridProduct(Products model,context) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  model.image,
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: 180,
                ),
                if(model.discount != 0)
                Container(color: Colors.white,child: Text('DISCOUNT',style: TextStyle(color: Colors.red),),),
              ],
            ),
            SizedBox(height: 3),
            Text('${model.name}',maxLines: 1,overflow: TextOverflow.ellipsis),
            SizedBox(height: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('${model.price} L.E',style: TextStyle(color: Colors.blue,fontSize: 17),),
                if(model.discount != 0)
                Text('${model.oldPrice} L.E',style: TextStyle(color: Colors.red,decoration: TextDecoration.lineThrough),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                     AppCubit.get(context).favorites[model.id]? Icons.favorite : Icons.favorite_border,color: Colors.red,
                  ),
                  onPressed: () {
                    AppCubit.get(context).changeFavorite(model.id);
                  },
                ),
                IconButton(
                  icon: Icon(
                    AppCubit.get(context).carts[model.id]? Icons.remove_shopping_cart : Icons.add_shopping_cart_outlined,color: Colors.red,
                  ),
                  onPressed: () {
                    AppCubit.get(context).changeCart(model.id);
                  },
                ),
              ],
            ),
          ],
        ),
  );

  Widget buildCategoryItem(DataData data) =>  Column(
    children: [
      CircleAvatar(
        radius: 35,
        backgroundImage: NetworkImage(
          '${data.image}',

        ),

      ),
      Text('${data.name}'),
    ],
  );
}
