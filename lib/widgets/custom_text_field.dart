import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final String hintText;
  final bool showToggleIcon;
  final Widget prefixIcon;
  final TextInputType keyboardType;
  //final TextCapitalization textCapitalization;
  final FormFieldValidator<String> validator;

  CustomTextField({
    Key key,
    this.focusNode,
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.showToggleIcon = true,
    this.keyboardType,
    //this.textCapitalization,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      focusNode: focusNode,
      controller: controller,
      keyboardType: keyboardType,
      //textCapitalization: textCapitalization,
      style: TextStyle(fontSize: 16, color: Colors.black),
      decoration: InputDecoration(
        border: InputBorder.none,
        icon: prefixIcon,
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 17),
      ),
    );
  }
}
