import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  final searchController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Search'),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: searchController,
                      onFieldSubmitted: (value) {
                        AppCubit.get(context).searchProduct(s: value);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Search...'
                      ),
                    ),
                    if(state is SearchLoadingState)
                      SizedBox(height: 10),
                    if(state is SearchLoadingState)
                      LinearProgressIndicator(),
                    if(state is SearchLoadingState)
                      SizedBox(height: 15),

                    SizedBox(height: 30,),
                    ConditionalBuilder(
                      condition: AppCubit.get(context).searchModel != null,
                      builder: (context) => ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => searchItem(AppCubit.get(context).searchModel.data.data[index]),
                        separatorBuilder: (context, index) => Divider(height: 10,color: Colors.black,),
                        itemCount: AppCubit.get(context).searchModel.data.data.length,
                      ),
                      fallback: (context) => Container(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget searchItem(SearchDataData model) =>  Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Expanded(
        child: Container(
          height: 140,
          width: 140,
          child: Image.network(
            '${model.image}',
            // fit: BoxFit.cover,
          ),
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${model.name}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 10,),
            Text('${model.price} L.E',style: TextStyle(color: Colors.blue,fontSize: 17),),
            // SizedBox(height: 10,),
          ],
        ),
      ),
    ],
  );
}
