import 'package:flutter/material.dart';
import 'package:flutter_application_1/feature/screen/home/screen/cartScreen.dart';
import 'package:flutter_application_1/feature/screen/home/screen/favoriteScreen.dart';
import 'package:flutter_application_1/feature/screen/home/screen/personalScreen.dart';
import 'package:flutter_application_1/feature/screen/home/screen/productDetailScreen.dart';
import 'package:flutter_application_1/feature/screen/home/screen/searchScreen.dart';
import 'package:flutter_application_1/feature/screen/login/screen/login.index..dart';
import 'package:flutter_application_1/feature/screen/home/screen/homeScreen.dart';
import 'package:flutter_application_1/feature/screen/login/screen/register.index.dart';

const String welcomeViewRoute = '/welcome';
const String homeViewRoute = 'home';
const String loginViewRoute = 'login';
const String registerViewRoute = 'register';
const String favoriteViewRoute = 'favorite';
const String personalViewRoute = 'personal';
const String searchViewRoute = 'search';
const String cartViewRoute = 'cart';
const String productDetailViewRoute = 'productDetail';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case homeViewRoute:
      return MaterialPageRoute(builder: (context) => HomeScreen());

    case cartViewRoute:
      return MaterialPageRoute(builder: (context) => CartScreen());

    case productDetailViewRoute:
      return MaterialPageRoute(
        builder: (context) => ProductDetailScreen(),
      );

    case favoriteViewRoute:
      return MaterialPageRoute(
        builder: (context) => FavoriteScreen(),
      );

    case personalViewRoute:
      return MaterialPageRoute(builder: (context) => PersonalScreen());

    case loginViewRoute:
      var argument = settings.arguments.toString();
      return MaterialPageRoute(builder: (context) => LoginScreen());

    case registerViewRoute:
      return MaterialPageRoute(builder: (context) => RegisterScreen());

    case searchViewRoute:
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
    return const Placeholder();
  }
}

class Error extends StatelessWidget {
  const Error({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
