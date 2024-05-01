import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/constants/button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Register',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 32,
              ),
              TextField(
                style: Theme.of(context).textTheme.titleSmall,
                decoration: InputDecoration(
                  labelText: 'email',
                ),
              ),
              TextField(
                style: Theme.of(context).textTheme.titleSmall,
                decoration: InputDecoration(
                  labelText: 'password',
                ),
              ),
              TextField(
                style: Theme.of(context).textTheme.titleSmall,
                decoration: InputDecoration(
                  labelText: 'Verify Password',
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              AppButton(
                text: 'Register',
                onPressed: () {},
              )
            ],
          ),
        )));
  }
}
