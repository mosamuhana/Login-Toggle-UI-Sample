import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../widgets.dart';
import '../../constants.dart';

class SignUpCard extends StatefulWidget {
  final void Function(String, String, String) onSignup;

  const SignUpCard({Key key, this.onSignup}) : super(key: key);

  @override
  _SignUpCardState createState() => _SignUpCardState();
}

class _SignUpCardState extends State<SignUpCard> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  bool _obscureText = true;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  bool get valid => _formKey.currentState?.validate() ?? false;

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            //overflow: Overflow.visible,
            children: [
              _fieldsCard,
              _submitButton,
            ],
          ),
        ],
      ),
    );
  }

  Widget get _fieldsCard {
    return Form(
      key: _formKey,
      child: Card(
        elevation: 2,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          width: 300,
          //height: 360,
          child: Column(
            children: [
              Padding(
                padding: _fieldPadding,
                child: CustomTextField(
                  focusNode: _nameFocusNode,
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  prefixIcon: Icon(FontAwesomeIcons.user, color: Colors.black),
                  hintText: "Name",
                  validator: (v) => v.length > 0 ? null : 'Enter Name',
                ),
              ),
              _hDivider,
              Padding(
                padding: _fieldPadding,
                child: CustomTextField(
                  focusNode: _emailFocusNode,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icon(FontAwesomeIcons.envelope, color: Colors.black),
                  hintText: 'Email Address',
                  validator: (v) => v.length > 0 ? null : 'Enter email',
                ),
              ),
              _hDivider,
              Padding(
                padding: _fieldPadding,
                child: PasswordTextField(
                  obscureText: _obscureText,
                  onTogglePassword: (v) => setState(() => _obscureText = v),
                  focusNode: _passwordFocusNode,
                  controller: _passwordController,
                  prefixIcon: Icon(FontAwesomeIcons.lock, color: Colors.black),
                  hintText: "Password",
                  validator: (v) => v.length > 0 ? null : 'Enter Password',
                ),
              ),
              _hDivider,
              Padding(
                padding: _fieldPadding,
                child: PasswordTextField(
                  obscureText: _obscureText,
                  onTogglePassword: (v) => setState(() => _obscureText = v),
                  focusNode: _passwordFocusNode,
                  controller: _confirmPasswordController,
                  prefixIcon: Icon(FontAwesomeIcons.lock, color: Colors.black),
                  hintText: "Password Confirmation",
                  validator: (v) => v.length > 0 ? null : 'Enter Confirmation Password',
                ),
              ),
              SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _submitButton {
    return Positioned(
      bottom: 15,
      left: 50,
      right: 50,
      child: Container(
        decoration: buttonDecoration,
        child: MaterialButton(
          highlightColor: Colors.transparent,
          splashColor: endColor,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "SIGN UP",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          onPressed: _onSubmit,
        ),
      ),
    );
  }

  void _onSubmit() {
    if (!valid) return;
    widget.onSignup?.call(
      _nameController.text,
      _emailController.text,
      _passwordController.text,
    );
  }

  final _hDivider = Container(width: 250, height: 1, color: Colors.grey[400]);

  final _fieldPadding = EdgeInsets.symmetric(horizontal: 25, vertical: 20);
}
