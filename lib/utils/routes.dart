import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_med_ui/components/bottom_navigation_widget.dart';
import 'package:insta_med_ui/screens/forgot_password_screen.dart';
import 'package:insta_med_ui/screens/get_started_screen.dart';
import 'package:insta_med_ui/screens/homescreen/HistoryScree.dart';

import 'package:insta_med_ui/screens/homescreen/InputScreen.dart';
import 'package:insta_med_ui/screens/homescreen/ChatScreen.dart'; 

import 'package:insta_med_ui/screens/homescreen/profile.dart';
import 'package:insta_med_ui/screens/login_screen.dart';
import 'package:insta_med_ui/screens/register_screen.dart';
import 'package:insta_med_ui/screens/splash_screen.dart';
import 'package:insta_med_ui/screens/verify_screen.dart';


class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return CupertinoPageRoute(builder: (_) => SplashScreen());
      case '/getStarted':
        return CupertinoPageRoute(builder: (_) => GetStartedScreen());
      case '/login':
        return CupertinoPageRoute(builder: (_) => LoginScreen());
      case '/register':
        return CupertinoPageRoute(builder: (_) => RegisterScreen());
      case '/forgotPassword':
        return CupertinoPageRoute(builder: (_) => ForgotPasswordScreen());
      case '/verify':
        return CupertinoPageRoute(builder: (_) => VerifyScreen());
      case '/home':
        return CupertinoPageRoute(builder: (_) => BottomNavigationWidget());
      case '/history':
        return CupertinoPageRoute(builder: (_) => HistoryScreen());
      case '/input':
        return CupertinoPageRoute(builder: (_) => InputScreen());
      case '/chat':
        return CupertinoPageRoute(builder: (_) => ChatScreen());
      case '/profile':
        return CupertinoPageRoute(builder: (_) => ProfileScreen());
      default:
        return CupertinoPageRoute(builder: (_) => SplashScreen()); // Default route
    }
  }
}
