import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:line_icons/line_icons.dart';
import 'package:social/Cubits/HomeCubit/cubitApp.dart';
import 'package:social/Cubits/HomeCubit/stateApp.dart';
import 'package:social/Screens/Login/login.dart';
import 'package:social/Screens/home/Add_Posts.dart';

import 'package:social/network/local/CacheHelper.dart';

class HomeScreen extends StatelessWidget {
  GlobalKey bottomNavigationKey = GlobalKey();

  Widget build(BuildContext context) {
    return BlocProvider<cubitApp>(
      create: (BuildContext context) => cubitApp()
        ..getUserDate()
        ..getUsers(),
      child: BlocConsumer<cubitApp, stateApp>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            bottomNavigationBar: CurvedNavigationBar(
              key: bottomNavigationKey,
              onTap: (value) {
                cubitApp.get(context).changeIndex(value);
              },
              index: cubitApp.get(context).index,
              buttonBackgroundColor: Color(0xff01142F),
              backgroundColor: Color(0xff01142F),
              animationCurve: Curves.easeInOut,
              color: Color(0xFF18191a),
              animationDuration: Duration(milliseconds: 600),
              items: <Widget>[
                Icon(
                  LineIcons.home,
                  size: 30,
                  color: Colors.white,
                ),
                Icon(
                  Icons.chat_bubble_outline,
                  size: 30,
                  color: Colors.white,
                ),
                Icon(
                  Icons.supervised_user_circle,
                  size: 30,
                  color: Colors.white,
                ),
                Icon(
                  Icons.settings,
                  size: 30,
                  color: Colors.white,
                ),
              ],
            ),
            appBar: AppBar(
              title: Text(
                  cubitApp.get(context).title[cubitApp.get(context).index],
                  style: Theme.of(context).textTheme.headline2),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return Add_Posts();
                    }));
                  },
                  icon: Icon(Icons.post_add_outlined),
                ),
                IconButton(
                  onPressed: () {
                    Cachehelper.removeDate(key: 'token').then((value) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) {
                        return login();
                      }));
                    }).catche((error) {
                      print(error.toString());
                    });
                  },
                  icon: Icon(Icons.notification_important),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search),
                ),
              ],
            ),
            body: cubitApp.get(context).screen[cubitApp.get(context).index],
          );
        },
      ),
    );
  }
}
