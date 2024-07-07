import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/bloc/cart/cart_bloc.dart';
import 'package:flutter_application_1/domain/cubit/address/address_cubit.dart';
import 'package:flutter_application_1/domain/cubit/category/category_cubit.dart';
import 'package:flutter_application_1/domain/cubit/product/product_cubit.dart';
import 'route/app_routes.dart' as router;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_application_1/domain/cubit/auth/auth.cubit.dart';
import 'package:flutter_application_1/domain/db_helper/cache_token.dart';
import 'package:flutter_application_1/domain/cubit/lang/language_cubit.dart';
import 'package:flutter_application_1/domain/service/auth/authService.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // UserService service = UserService();
    AuthService authService = AuthService();
    CacheToken cacheToken = CacheToken();
    var kColorScheme = ColorScheme.fromSeed(seedColor: Colors.green);

    ThemeData theme = ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onTertiary,
            foregroundColor: kColorScheme.onBackground),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kColorScheme.inversePrimary,
                foregroundColor: kColorScheme.background)),
        inputDecorationTheme: const InputDecorationTheme(),
        primaryTextTheme: const TextTheme(
          headlineMedium: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700),
          headlineSmall: TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700),
          titleLarge: TextStyle(
            fontSize: 36,
            color: Colors.white,
          ),
          titleMedium: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
          titleSmall: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
          headlineSmall: TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),
          titleLarge: TextStyle(
            fontSize: 36,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
          titleSmall: TextStyle(
            fontSize: 12,
            color: Colors.black,
          ),
        ));

    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(authService, cacheToken),
          ),
          BlocProvider(
            create: (context) => LanguageCubit(),
          ),
          BlocProvider(
            create: (context) => CategoryCubit()..fetchCategory(),
          ),
          BlocProvider(
            create: (context) => ProductCubit()..fetchProduct(),
          ),
          BlocProvider(create: (context) => CartBloc()),
          BlocProvider(create: (context) => AddressCubit())

          // call fetchCategory
        ],
        child: BlocBuilder<LanguageCubit, LanguageState>(
          builder: (context, state) {
            if (state is LanguageInitial) {
              return GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: MaterialApp(
                  theme: theme,
                  onGenerateRoute: router.AppGenerateRoutes().generateRoute,
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
                ),
              );
            } else {
              return const Placeholder();
            }
          },
        ));
  }
}
