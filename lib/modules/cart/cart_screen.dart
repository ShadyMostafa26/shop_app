import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/cart_model.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Cart'),
          ),
          body: ConditionalBuilder(
            condition: state is! GetCartDataLoadingState && AppCubit.get(context).cartModel != null,
            builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildFavoriteItem(AppCubit.get(context).cartModel.data.cartItems[index],context),
              separatorBuilder: (context, index) =>SizedBox(height: 15,),
              itemCount: AppCubit.get(context).cartModel.data.cartItems.length,
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget buildFavoriteItem(CartItems model,context)=> Padding(
    padding: const EdgeInsets.symmetric(vertical: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Container(
            height: 140,
            width: 140,
            child: Image.network(
              '${model.product.image}',
              // fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${model.product.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 10,),
              Text('${model.product.price} L.E',style: TextStyle(color: Colors.blue,fontSize: 17),),
              // SizedBox(height: 10,),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      AppCubit.get(context).favorites[model.product.id]? Icons.favorite : Icons.favorite_border,color: Colors.red,
                    ),
                    onPressed: () {
                      AppCubit.get(context).changeFavorite(model.product.id);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      AppCubit.get(context).carts[model.product.id]? Icons.remove_shopping_cart : Icons.add_shopping_cart_outlined,color: Colors.red,
                    ),
                    onPressed: () {
                      AppCubit.get(context).changeCart(model.product.id);
                    },
                  ),
                ],
              ),

            ],
          ),
        ),
      ],
    ),
  );
}
