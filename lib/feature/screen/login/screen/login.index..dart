import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/l10n/translations.dart';
import 'package:flutter_application_1/cubit/auth/auth.cubit.dart';
import 'package:flutter_application_1/cubit/lang/language_cubit.dart';
import 'package:flutter_application_1/widget/constants/snack_bar.dart';
import 'package:flutter_application_1/feature/screen/login/widget/changeLang.dart';

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

  void handleChangeLang() {
    
  }

  void onPressedLogin(BuildContext context) {
    if (_email.text.isEmpty) {
      snackBar(context, "Please input your email");
    } else if (_password.text.isEmpty) {
      snackBar(context, "Please input your password");
    } else {
      context
          .read<AuthCubit>()
          .loginLogic(_email.text, _password.text, context);
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
                  : const Spacer(),
              const Icon(Icons.arrow_drop_down_rounded)
            ],
          ),
        ),
      );
    }

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
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
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                    controller: _email,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        label: Text(translations(context)!.email))),
                const SizedBox(height: 16,),
                TextField(
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
                            borderRadius: BorderRadius.circular(12)),
                        label: Text(translations(context)!.password))),
                const SizedBox(height: 16,),
                
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {},
                      child: Text(translations(context)!.login)),
                ),
             
                TextButton(
                    onPressed: () {},
                    child: Text(translations(context)!.createAccount))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
