import 'package:flutter/material.dart';
import 'route/app_router.dart' as router;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_application_1/cubit/auth/auth.cubit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_application_1/cubit/lang/language_cubit.dart';
import 'package:flutter_application_1/domain/bloc/auth/auth_bloc.dart';
import 'package:flutter_application_1/domain/bloc/user/user_bloc.dart';
import 'package:flutter_application_1/domain/db_helper/cache_token.dart';
import 'package:flutter_application_1/domain/service/auth/auth.service.dart';
import 'package:flutter_application_1/domain/service/user/user_service.dart';
import 'package:flutter_application_1/feature/screen/login/screen/login.index..dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    UserService service = UserService();
    AuthService authService = AuthService();
    CacheToken cacheToken = CacheToken();
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(authService, cacheToken),
          ),
          BlocProvider<UserBloc>(create: (context) => UserBloc(service)),
          BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
          BlocProvider(
            create: (context) => LanguageCubit(),
          )
        ],
        child: BlocBuilder<LanguageCubit, LanguageState>(
          builder: (context, state) {
            if (state is LanguageInitial) {
              return MaterialApp(
                  onGenerateRoute: router.generateRoute,
                  initialRoute: '/',
                  debugShowCheckedModeBanner: false,
                  title: 'flutter app',
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate
                  ],
                  supportedLocales: AppLocalizations.supportedLocales,
                  locale: state.selectedLanguage.local,
                  home: LoginScreen());
            } else {
              return const Placeholder();
            }
          },
        ));
  }
}
