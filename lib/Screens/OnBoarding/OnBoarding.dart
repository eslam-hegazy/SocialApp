// ignore: must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:social/Cubits/onBoardingCubit/cubit.dart';
import 'package:social/Cubits/onBoardingCubit/state.dart';

import 'package:social/Screens/Login/login.dart';

import 'itemBoarding.dart';

class OnBoarding extends StatelessWidget {
  var pageViewController = PageController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<cubit>(
        create: (BuildContext context) => cubit(),
        child: BlocConsumer<cubit, state>(
          listener: (context, state) {},
          builder: (context, state) {
            var data = cubit.get(context);
            return Scaffold(
              appBar: AppBar(
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) {
                          return login();
                        }));
                      },
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          color: Colors.orange,
                          fontFamily: "PermanentMarker",
                        ),
                      )),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.only(right: 12, left: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: PageView.builder(
                        controller: pageViewController,
                        onPageChanged: (index) {
                          if (index == data.board.length - 1) {
                            data.changeindex(true);
                            print("true");
                          } else {
                            print("False");
                          }
                        },
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return itemBoarding(data.board[index]);
                        },
                        itemCount: data.board.length,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SmoothPageIndicator(
                            controller: pageViewController,
                            count: data.board.length,
                            effect: ExpandingDotsEffect(
                              spacing: 5,
                              dotHeight: 10,
                              dotWidth: 10,
                              dotColor: Colors.grey,
                              activeDotColor: Colors.orange,
                            ),
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              if (data.end == true) {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (_) {
                                  return login();
                                }));
                              } else {
                                pageViewController.nextPage(
                                    duration: Duration(milliseconds: 600),
                                    curve: Curves.easeInOutQuint);
                              }
                            },
                            child: Icon(Icons.arrow_forward_outlined),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
