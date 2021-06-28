import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class defaultTextForm extends StatelessWidget {
  final IconData icon;
  final String label;
  final String hint;
  final TextEditingController controller;
  final Function valid;

  defaultTextForm(
      this.icon, this.label, this.hint, this.controller, this.valid);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: valid,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        prefixIcon: Icon(
          icon,
          color: Color(0xFF18191a),
        ),
        labelText: label,
        hintText: hint,
        hintStyle:
            TextStyle(fontFamily: "BalsamiqSans", fontWeight: FontWeight.bold),
        labelStyle: TextStyle(fontFamily: "FredokaOne"),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
