import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PasswordTextField extends StatefulWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final Widget prefixIcon;
  final bool showToggleIcon;
  final bool obscureText;
  final ValueChanged<bool> onTogglePassword;
  final FormFieldValidator<String> validator;

  PasswordTextField({
    Key key,
    this.focusNode,
    this.controller,
    this.hintText,
    this.showToggleIcon = true,
    this.keyboardType,
    this.prefixIcon,
    this.obscureText = true,
    this.onTogglePassword,
    this.validator,
  }) : super(key: key);

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    _obscureText = widget.obscureText;
    super.initState();
  }

  IconData get toggleIcon => _obscureText ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      focusNode: widget.focusNode,
      controller: widget.controller,
      obscureText: _obscureText,
      keyboardType: widget.keyboardType,
      style: TextStyle(fontSize: 16, color: Colors.black),
      decoration: InputDecoration(
        border: InputBorder.none,
        icon: widget.prefixIcon,
        hintText: widget.hintText,
        hintStyle: TextStyle(fontSize: 17),
        suffixIcon: !widget.showToggleIcon
            ? null
            : GestureDetector(
                onTap: _togglePassword,
                child: Icon(toggleIcon, size: 15, color: Colors.black),
              ),
      ),
    );
  }

  void _togglePassword() {
    _obscureText = !_obscureText;
    setState(() {});
    widget.onTogglePassword?.call(_obscureText);
  }
}
