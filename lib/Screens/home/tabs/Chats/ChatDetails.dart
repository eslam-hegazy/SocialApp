import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/Cubits/HomeCubit/cubitApp.dart';
import 'package:social/Cubits/HomeCubit/stateApp.dart';

class ChatDetails extends StatelessWidget {
  final int index;
  final String name;
  final String image;
  ChatDetails(this.name, this.image, this.index);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => cubitApp(),
      child: BlocConsumer<cubitApp, stateApp>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = cubitApp.get(context).users;
          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(image),
                  ),
                  SizedBox(width: 10),
                  Text(
                    model[index].name,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ],
              ),
            ),
            body: Container(),
          );
        },
      ),
    );
  }
}
