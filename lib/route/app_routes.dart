import 'package:flutter/material.dart';
import 'package:flutter_application_1/route/app_arguments.dart';
import 'package:flutter_application_1/feature/screen/home/screen/ordersScreen.dart';
import 'package:flutter_application_1/feature/screen/home/screen/successOrder.dart';
import 'package:flutter_application_1/feature/screen/home/screen/cartScreen.dart';
import 'package:flutter_application_1/feature/screen/home/screen/homeScreen.dart';
import 'package:flutter_application_1/feature/screen/home/screen/searchScreen.dart';
import 'package:flutter_application_1/feature/screen/login/screen/login.index..dart';
import 'package:flutter_application_1/feature/screen/home/screen/checkoutScreen.dart';
import 'package:flutter_application_1/feature/screen/home/screen/personalScreen.dart';
import 'package:flutter_application_1/feature/screen/home/screen/favoriteScreen.dart';
import 'package:flutter_application_1/feature/screen/login/screen/register.index.dart';
import 'package:flutter_application_1/feature/screen/home/screen/myAddressScreen.dart';
import 'package:flutter_application_1/feature/screen/home/screen/categoryAllScreen.dart';
import 'package:flutter_application_1/feature/screen/home/screen/lastLocationScreen.dart';
import 'package:flutter_application_1/feature/screen/home/screen/productDetailScreen.dart';
import 'package:flutter_application_1/feature/screen/home/screen/categoryDetailScreen.dart';

class AppRoutes {
  static const login = '/';
  static const home = '/home';
  static const cart = '/cart';
  static const checkout = '/checkout';
  static const register = '/register';
  static const favorite = '/favorite';
  static const settings = '/settings';
  static const categoryAll = '/categoryAll';
  static const lastLocation = '/lastLocation';
  static const successOrder = '/successOrder';
  static const productDetail = '/productDetail';
  static const searchProduct = '/searchProduct';
  static const categoryDetail = '/categoryDetail';
  static const myaddresses = '/myAddresses';
  static const orders = '/orders';
}

class AppGenerateRoutes {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        Widget builder(BuildContext context) {
          return const HomeScreen();
        }

        return MaterialPageRoute(builder: builder);

      case AppRoutes.cart:
        Widget builder(BuildContext context) {
          return const CartScreen();
        }

        return MaterialPageRoute(builder: builder);

      case AppRoutes.lastLocation:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const LastLocationScreen(),
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

      case AppRoutes.categoryAll:
        Widget builder(BuildContext context) {
          return const CategoryAllScreen();
        }

        return MaterialPageRoute(builder: builder);

      case AppRoutes.productDetail:
        Widget builder(BuildContext context) {
          final args = settings.arguments as ProductDetailArguments;
          return ProductDetailScreen(arguments: args);
        }

        return MaterialPageRoute(builder: builder);

      case AppRoutes.checkout:
        Widget builder(BuildContext context) {
          final args = settings.arguments as CheckoutArguments;
          return CheckOutScreen(
            arguments: args,
          );
        }
        return MaterialPageRoute(builder: builder);

      case AppRoutes.successOrder:
        Widget builder(BuildContext context) {
          return const SuccessOrder();
        }
        return MaterialPageRoute(builder: builder);

      case AppRoutes.orders:
        Widget builder(BuildContext context) {
          return const OrderScreen();
        }

        return MaterialPageRoute(builder: builder);

      case AppRoutes.myaddresses:
        Widget builder(BuildContext context) {
          return const MyAdressScreen();
        }
        return MaterialPageRoute(builder: builder);

      case AppRoutes.favorite:
        return MaterialPageRoute(
          builder: (context) => const FavoriteScreen(),
        );

      case AppRoutes.settings:
        return MaterialPageRoute(builder: (context) => const PersonalScreen());

      case AppRoutes.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      case AppRoutes.register:
        return MaterialPageRoute(builder: (context) => const RegisterScreen());

      case AppRoutes.searchProduct:
        return MaterialPageRoute(
          builder: (context) => const SearchScreen(),
        );

      default:
        return MaterialPageRoute(builder: (context) => const UndefinedScreen());
    }
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
