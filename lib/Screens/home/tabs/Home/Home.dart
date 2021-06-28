import 'package:conditional_builder/conditional_builder.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social/Cubits/HomeCubit/cubitApp.dart';
import 'package:social/Cubits/HomeCubit/stateApp.dart';
import 'package:social/widgets/CardNews.dart';

import 'package:social/Screens/home/tabs/Home/HeadHome.dart';

class Home extends StatelessWidget {
  Future<Null> refreshList() async {
    return Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubitApp, stateApp>(
      listener: (context, state) {},
      builder: (context, state) {
        return stateApp is LoadinGetPost
            ? CircularProgressIndicator()
            : Scaffold(
                body: RefreshIndicator(
                  onRefresh: () async {
                    cubitApp.get(context).getPost();
                  },
                  child: SingleChildScrollView(
                    // physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          HeadHome(),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return CardNews(
                                  cubitApp.get(context).post[index], index);
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 10);
                            },
                            itemCount: cubitApp.get(context).post.length,
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
}
