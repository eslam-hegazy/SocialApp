import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/Cubits/HomeCubit/cubitApp.dart';
import 'package:social/Cubits/HomeCubit/stateApp.dart';
import 'package:social/Screens/home/tabs/Chats/ChatDetails.dart';

class Chats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubitApp, stateApp>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = cubitApp.get(context).users;
        return ConditionalBuilder(
          condition: cubit.length > 0,
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
          builder: (BuildContext context) => Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => Container(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return ChatDetails(
                            cubit[index].name, cubit[index].image, index);
                      }));
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(cubit[index].image),
                        ),
                        SizedBox(width: 15),
                        Text(
                          cubit[index].name,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ],
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => Divider(),
                itemCount: cubit.length,
              ),
            ),
          ),
        );
      },
    );
  }
}
