import 'package:flutter/material.dart';
import 'package:my_app1/pages/Splash_screen/splashscreen.dart';
import 'package:my_app1/pages/apropos.dart';
import 'package:my_app1/pages/auth/sign_in.dart';
import 'package:my_app1/pages/auth/sign_up.dart';
import 'package:my_app1/pages/client/home_screen_client.dart';
import 'package:my_app1/pages/contacter.dart';
import 'package:my_app1/pages/worker/home_screen_wroker.dart';

class AppRouting {
  static final String splashScreen = "/";
  static final String signIn = "/sign_in";
  static final String signUp = "/sign_up";
  static final String aboutUs = "/about_us";
  static final String HomeClient = "/home_client";
  static final String HomeWorker = "/home_worker";
  static final String contactUs = "/contact_us";
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/sign_in':
        return MaterialPageRoute(builder: (_) => SignIn());
      case '/sign_up':
        return MaterialPageRoute(builder: (_) => SignUp());
      case '/home_client':
        return MaterialPageRoute(builder: (_) => HomeScreenClient());
      case '/home_worker':
        return MaterialPageRoute(builder: (_) => HomeScreenWorker());
      case '/about_us':
        return MaterialPageRoute(builder: (_) => Apropos());
      case '/contact_us':
        return MaterialPageRoute(builder: (_) => Contacter());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
