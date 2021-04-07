import 'package:alemadmin/adminScreens/admin_home.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'adminScreens/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: SplashScreen(
          seconds: 3,
          navigateAfterSeconds: AdminHome(),
          image: Image.asset('images/logo.png'),
          backgroundColor: Colors.white,
          styleTextUnderTheLoader: new TextStyle(),
          photoSize: MediaQuery.of(context).size.height / 4,
          loaderColor: Colors.red,
        )),
      ),
    );
  }
}
