import 'package:http/http.dart' as http;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/config/config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/asset/image.dart';
import 'package:flutter_application_1/utils/common.dart';
import 'package:flutter_application_1/l10n/translations.dart';
import 'package:flutter_application_1/widget/constants/button.dart';
import 'package:flutter_application_1/widget/constants/snack_bar.dart';
import 'package:flutter_application_1/domain/cubit/auth/auth.cubit.dart';
import 'package:flutter_application_1/domain/cubit/lang/language_cubit.dart';
import 'package:flutter_application_1/feature/screen/login/widget/changeLang.dart';
import 'package:flutter_application_1/domain/model/request_body/authRequestBody.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _email;
  late TextEditingController _password;

  bool _check = false;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();

    // 🧑🏻‍💼 admin
    // setState(() {
    //   _email = TextEditingController(text: 'john@gmail.com');
    //   _password = TextEditingController(text: 'changeme');
    // });

    // // 🧑🏻‍🦰 client
    setState(() {
      _email = TextEditingController(text: 'maria@gmail.com');
      _password = TextEditingController(text: 'guess');
    });
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();

    super.dispose();
  }

  void handleHidePassword() {
    setState(() {
      _check = !_check;
    });
  }

  void onPressChangeLang(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const ChangeLangModal(),
    );
  }

  void onPressedLogin(BuildContext context) {
    if (_email.text.isEmpty) {
      snackBar(context, translations(context)!.please_input_your_email);
    } else if (_password.text.isEmpty) {
      snackBar(context, translations(context)!.please_input_your_password);
    } else {
      final AuthRequest body =
          AuthRequest(email: _email.text, password: _password.text);
      context.read<AuthCubit>().loginLogic(body, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget selectedLanguage(BuildContext context, LanguageState state) {
      return GestureDetector(
        onTap: () {
          onPressChangeLang(context);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.blue,
              ),
            ],
          ),
          width: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              state is LanguageInitial
                  ? state.selectedLanguage.flag
                  : const Placeholder(),
              const Icon(Icons.arrow_drop_down_rounded)
            ],
          ),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          actions: [
            BlocBuilder<LanguageCubit, LanguageState>(
              builder: (context, state) {
                return Row(
                  children: [
                    selectedLanguage(context, state),
                    const SizedBox(
                      width: 12,
                    )
                  ],
                );
              },
            )
          ],
        ),
        body: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is LoginLoadingState && state.isLoading) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  });
            } else {
              Future.delayed(const Duration(milliseconds: 1000), () {
                Navigator.pop(context);
                if (state is LoginSuccessState) {
                  onReplaceToScreen(context, '/home');
                } else if (state is LoginFailureState) {
                  snackBar(context, state.error);
                }
              });
            }
          },
          child: SafeArea(
            child: SingleChildScrollView(
                clipBehavior: Clip.none,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Expanded(
                          child: Container(
                              width: double.infinity,
                              child: Image(
                                  image: AssetImage(
                                      Asset.images['basket'] as String)))),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Login',
                                  style: Theme.of(context).textTheme.titleLarge,
                                )),
                            const SizedBox(
                              height: 32,
                            ),
                            TextField(
                                style: Theme.of(context).textTheme.titleSmall,
                                controller: _email,
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.person),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    label: Text(translations(context)!.email))),
                            const SizedBox(
                              height: 16,
                            ),
                            TextField(
                                style: Theme.of(context).textTheme.titleSmall,
                                obscureText: _check,
                                obscuringCharacter: '*',
                                controller: _password,
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                      icon: _check
                                          ? const Icon(Icons.lock)
                                          : const Icon(Icons.key_off),
                                      onPressed: handleHidePassword,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    label: Text(
                                      translations(context)!.password,
                                    ))),
                            const SizedBox(
                              height: 30,
                            ),
                            AppButton(
                                text: translations(context)!.login,
                                onPressed: () {
                                  onPressedLogin(context);
                                }),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                const Expanded(
                                    child: Divider(
                                  height: 1,
                                )),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Text(
                                      'or',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    )),
                                const Expanded(
                                    child: Divider(
                                  height: 1,
                                ))
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                                width: double.infinity,
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      text: 'Dont\' have any account?',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                      children: [
                                        const TextSpan(text: ' '),
                                        TextSpan(
                                            text: 'Create one',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(color: Colors.green),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () =>
                                                  onNavigateToScreen(
                                                      context, '/register'))
                                      ]),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ));
  }
}
