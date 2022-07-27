import 'package:flutter/material.dart';
import 'package:note_app_flutter/app/router/route_name.dart';
import 'package:note_app_flutter/views/sign_up/sign_up.dart';
import 'package:note_app_flutter/views/user/user.dart';
import 'package:page_transition/page_transition.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final arg = settings.arguments;
    switch (settings.name) {
      case RouteName.signUp:
        return PageTransition(
            child: const SignUpView(),
            type: PageTransitionType.rightToLeftWithFade);
      case RouteName.user:
        return PageTransition(
            child: const UserView(),
            type: PageTransitionType.rightToLeftWithFade);
      default:
        return _errRoute();
    }
  }

  static Route<dynamic> _errRoute() {
    return MaterialPageRoute(
        builder: (context) => const Scaffold(
              body: Center(
                child: Text("no route"),
              ),
            ));
  }
}
