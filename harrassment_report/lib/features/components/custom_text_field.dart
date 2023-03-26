import 'package:flutter/material.dart';

Widget customTextField(context,
    {controller, fieldState, hintText, obscureText, validation}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5.0),
      color: Colors.grey.shade100,
    ),
    child: TextFormField(
      obscureText: obscureText,
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return validation;
          // || !RegExp(r'^[a-z A-Z]+$').hasMatch(value) ||
          // !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
          //     .hasMatch(value)
          // || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)
        } else {
          return null;
        }
      },
      // obscureText: obscureText,
      decoration: InputDecoration(
        label: Text(hintText),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF707070), width: .5)),
        focusColor: Colors.grey,
        floatingLabelBehavior: FloatingLabelBehavior.values.first,
        fillColor: Colors.grey,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Color(0xFF707070), width: .5)),
        hintText: hintText,
      ),
    ),
  );
}
