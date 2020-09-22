import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../widgets.dart';
import '../../constants.dart';

class SignInCard extends StatefulWidget {
  final void Function(String, String) onLogin;
  final VoidCallback onGoogleLogin;
  final VoidCallback onFacebookLogin;

  const SignInCard({
    Key key,
    this.onLogin,
    this.onGoogleLogin,
    this.onFacebookLogin,
  }) : super(key: key);

  @override
  _SignInCardState createState() => _SignInCardState();
}

class _SignInCardState extends State<SignInCard> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool get valid => _formKey.currentState?.validate() ?? false;

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
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
            children: [
              _fieldsCard,
              _submitButton,
            ],
          ),
          _forgotPassword,
          _orLine,
          _socialButtons,
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          width: 300,
          //height: 190,
          child: Column(
            children: [
              Padding(
                padding: _fieldPadding,
                child: CustomTextField(
                  focusNode: _emailFocusNode,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Email Address',
                  prefixIcon: Icon(FontAwesomeIcons.envelope, color: Colors.black, size: 22),
                  validator: (v) => v.length > 0 ? null : 'Enter email',
                ),
              ),
              _hDivider,
              Padding(
                padding: _fieldPadding,
                child: PasswordTextField(
                  focusNode: _passwordFocusNode,
                  controller: _passwordController,
                  hintText: 'Password',
                  prefixIcon: Icon(FontAwesomeIcons.lock, size: 22, color: Colors.black),
                  validator: (v) => v.length > 0 ? null : 'Enter password',
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
              "LOGIN",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          onPressed: _onSubmit,
        ),
      ),
    );
  }

  Widget get _forgotPassword {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: FlatButton(
        onPressed: () {},
        child: Text(
          "Forgot Password?",
          style: TextStyle(decoration: TextDecoration.underline, color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  Widget get _socialButtons {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10, right: 40),
          child: GestureDetector(
            onTap: () {
              widget.onFacebookLogin?.call();
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              child: Icon(FontAwesomeIcons.facebookF, color: Color(0xFF0084ff)),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: GestureDetector(
            onTap: () {
              widget.onGoogleLogin?.call();
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              child: Icon(FontAwesomeIcons.google, color: Color(0xFF0084ff)),
            ),
          ),
        ),
      ],
    );
  }

  Widget get _orLine {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white10, Colors.white],
                begin: const FractionalOffset(0, 0),
                end: const FractionalOffset(1, 1),
                stops: [0, 1],
                tileMode: TileMode.clamp,
              ),
            ),
            width: 100,
            height: 1,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Text(
              "Or",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.white10],
                begin: const FractionalOffset(0, 0),
                end: const FractionalOffset(1, 1),
                stops: [0, 1],
                tileMode: TileMode.clamp,
              ),
            ),
            width: 100,
            height: 1,
          ),
        ],
      ),
    );
  }

  void _onSubmit() {
    if (!valid) return;
    widget.onLogin?.call(_emailController.text, _passwordController.text);
  }

  final _hDivider = Container(width: 250, height: 1, color: Colors.grey[400]);

  final _fieldPadding = EdgeInsets.symmetric(horizontal: 25, vertical: 20);
}
