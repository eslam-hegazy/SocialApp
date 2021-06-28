import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class defaultBotton extends StatelessWidget {
  final String text;

  defaultBotton(this.text);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        alignment: Alignment.center,
        height: 60,
        width: double.infinity,
        child: Text(
          text,
          style: Theme.of(context).textTheme.headline1,
        ),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
