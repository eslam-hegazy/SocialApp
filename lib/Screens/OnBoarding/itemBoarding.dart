import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:social/models/onBoardingModel.dart';

class itemBoarding extends StatelessWidget {
  final onBoardingModel model;

  itemBoarding(this.model);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: Lottie.asset(model.image),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.all(10),
          child: Text(
            model.title,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.all(10),
          child: Text(
            model.description,
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
      ],
    );
  }
}
