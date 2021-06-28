import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Add_Thing extends StatelessWidget {
  final IconData icon;
  final String text;

  Add_Thing(
    this.icon,
    this.text,
  );
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.blue,
        ),
        FlatButton(
          onPressed: () {},
          child: Text(
            text,
            style: TextStyle(
              color: Colors.blue,
              fontFamily: "FredokaOne",
              fontSize: 17,
            ),
          ),
        ),
      ],
    );
  }
}
