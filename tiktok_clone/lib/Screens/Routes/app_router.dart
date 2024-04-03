import 'package:flutter/material.dart';
import 'package:tiktok_clone/Screens/Login_signup_screen/login_screen.dart';
import 'package:tiktok_clone/Screens/Login_signup_screen/signup_screen.dart';
import 'package:tiktok_clone/Screens/ProfileScreen/profile_screen.dart';
import 'package:tiktok_clone/Screens/comments/comments_screen.dart';
import 'package:tiktok_clone/Screens/home/home_screen.dart';
import 'package:tiktok_clone/Screens/video/conform_screen.dart';

class AppRoute {
  Route getRoutesForApp(RouteSettings config) {
    final Map<String, dynamic>? arguments =
        config.arguments as Map<String, dynamic>?;
    switch (config.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case "/login":
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case "/home":
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case "/profile":
        if (arguments != null) {
          return MaterialPageRoute(
            builder: (_) => ProfileScreen(uid: arguments['uid']),
          );
        } else {
          return MaterialPageRoute(builder: (_) => const HomeScreen());
        }
      case "/comment":
        if (arguments != null) {
          return MaterialPageRoute(
            builder: (_) => CommentsScreen(id: arguments['id']),
          );
        } else {
          return MaterialPageRoute(builder: (_) => const HomeScreen());
        }
      case "/conform":
        if (arguments != null) {
          return MaterialPageRoute(
            builder: (_) => ConformScreen(
              videoFile: arguments['videoFile'],
              videPath: arguments['videoPath'],
            ),
          );
        } else {
          return MaterialPageRoute(builder: (_) => const HomeScreen());
        }
      default:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
    }
  }
}
