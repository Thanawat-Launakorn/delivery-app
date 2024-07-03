import 'package:flutter/material.dart';
import 'package:flutter_application_1/feature/screen/home/screen/cartScreen.dart';
import 'package:flutter_application_1/feature/screen/home/screen/homeScreen.dart';
import 'package:flutter_application_1/feature/screen/home/screen/searchScreen.dart';
import 'package:flutter_application_1/feature/screen/login/screen/login.index..dart';
import 'package:flutter_application_1/feature/screen/home/screen/personalScreen.dart';
import 'package:flutter_application_1/feature/screen/home/screen/favoriteScreen.dart';
import 'package:flutter_application_1/feature/screen/login/screen/register.index.dart';
import 'package:flutter_application_1/feature/screen/home/screen/lastLocationScreen.dart';
import 'package:flutter_application_1/feature/screen/home/screen/productDetailScreen.dart';
import 'package:flutter_application_1/feature/screen/home/screen/categoryDetailScreen.dart';
import 'package:flutter_application_1/route/app_arguments.dart';

class AppRoutes {
  static const login = '/';
  static const home = '/home';
  static const cart = '/cart';
  static const register = '/register';
  static const favorite = '/favorite';
  static const settings = '/settings';
  static const lastLocation = '/lastLocation';
  static const productDetail = '/productDetail';
  static const searchProduct = '/searchProduct';
  static const categoryDetail = '/categoryDetail';
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.home:
      Widget builder(BuildContext context) {
        return HomeScreen();
      }

      return MaterialPageRoute(builder: builder);

    case AppRoutes.cart:
      Widget builder(BuildContext context) {
        return CartScreen();
      }

      return MaterialPageRoute(builder: builder);

    case AppRoutes.lastLocation:
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            LastLocationScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      );

    case AppRoutes.categoryDetail:
      Widget builder(BuildContext context) {
        final args = settings.arguments as CategoryDetailArguments;
        return CategoryDetailScreen(
          arguments: args,
        );
      }

      return MaterialPageRoute(builder: builder);

    case AppRoutes.productDetail:
      return MaterialPageRoute(
        builder: (context) => ProductDetailScreen(),
      );

    case AppRoutes.favorite:
      return MaterialPageRoute(
        builder: (context) => FavoriteScreen(),
      );

    case AppRoutes.settings:
      return MaterialPageRoute(builder: (context) => PersonalScreen());

    case AppRoutes.login:
      var argument = settings.arguments.toString();
      return MaterialPageRoute(builder: (context) => LoginScreen());

    case AppRoutes.register:
      return MaterialPageRoute(builder: (context) => RegisterScreen());

    case AppRoutes.searchProduct:
      return MaterialPageRoute(
        builder: (context) => SearchScreen(),
      );

    default:
      return MaterialPageRoute(builder: (context) => UndefinedScreen());
  }
}

class UndefinedScreen extends StatelessWidget {
  const UndefinedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Error extends StatelessWidget {
  const Error({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
