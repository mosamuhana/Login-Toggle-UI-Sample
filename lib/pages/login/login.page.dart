import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets.dart';
import '../../constants.dart';
import 'signin_card.dart';
import 'signup_card.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  PageController _pageController;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      key: _scaffoldKey,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return true;
        },
        child: SingleChildScrollView(
          child: Container(
            width: width,
            //height: height >= 775 ? height : 775,
            height: height + 100,
            decoration: BoxDecoration(gradient: _gradient),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 50, bottom: 30),
                  child: Image(
                    width: 120,
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/connect.png'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: PageToggler(
                    controller: _pageController,
                    leftTitle: 'Sign In',
                    rightTitle: 'Sign Up',
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: PageView(
                    controller: _pageController,
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: SignInCard(
                          onLogin: onLogin,
                          onGoogleLogin: onGoogleLogin,
                          onFacebookLogin: onFacebookLogin,
                        ),
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: SignUpCard(
                          onSignup: onSignup,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String value) {
    FocusScope.of(context).requestFocus(FocusNode());

    if (_scaffoldKey?.currentState == null) return;

    _scaffoldKey.currentState.removeCurrentSnackBar();

    final snackBar = SnackBar(
      content: Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    );

    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void onLogin(String email, String password) => _showSnackBar('Login with $email');

  void onGoogleLogin() => _showSnackBar('Login with Google');

  void onFacebookLogin() => _showSnackBar('Login with Facebook');

  void onSignup(String name, String email, String password) => _showSnackBar('Signup with $email');

  final _gradient = LinearGradient(
    colors: [startColor, endColor],
    begin: const FractionalOffset(0.5, 0),
    end: const FractionalOffset(0.5, 1),
    stops: [0, 1],
    tileMode: TileMode.clamp,
  );
}
