import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/catgeories_model.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => buildCategories(cubit.categoriesModel.data.data[index]),
          separatorBuilder: (context, index) => Divider(height: 1,thickness: 1,),
          itemCount: cubit.categoriesModel.data.data.length,
        );
      },
    );
  }

  Widget buildCategories(DataData model) => Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Row(
        children: [
          Container(
            height: 140,
            width: 140,
            child: Image.network(
              '${model.image}',
              fit: BoxFit.fill,
            ),
          ),
             SizedBox(width: 5),
          Text('${model.name}'),
          Spacer(),
          IconButton(
              icon: Icon(Icons.arrow_forward_ios_outlined),
              onPressed: () {},
          ),
        ],
      ),
    ],
  );
}
