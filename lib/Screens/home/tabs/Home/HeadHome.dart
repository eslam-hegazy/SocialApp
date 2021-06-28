import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeadHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.20,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(
                    "https://image.freepik.com/free-photo/colleagues-giving-fist-bump_53876-64857.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.bottomRight,
            height: MediaQuery.of(context).size.height * 0.20,
            child: Text(
              "Communicate With Friends",
              style: Theme.of(context).textTheme.headline2,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}
