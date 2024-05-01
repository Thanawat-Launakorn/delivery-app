import 'package:flutter/material.dart';
import 'package:flutter_application_1/feature/screen/login/screen/login.index..dart';
import 'package:flutter_application_1/feature/screen/home/screen/home.index.dart';
import 'package:flutter_application_1/feature/screen/login/screen/register.index.dart';

const String WelcomeViewRoute = '/welcome';
const String HomeViewRoute = 'home';
const String LoginViewRoute = 'login';
const String RegisterViewRoute = 'register';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch(settings.name) {
  
    case HomeViewRoute:
      return MaterialPageRoute(builder: (context) => HomeScreen());
    
    case LoginViewRoute:
       var argument = settings.arguments.toString();
      return MaterialPageRoute(builder: (context) => LoginScreen());

    case RegisterViewRoute:
      return MaterialPageRoute(builder: (context) => RegisterScreen());

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