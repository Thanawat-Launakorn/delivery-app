import 'package:flutter/material.dart';
import 'package:flutter_application_1/route/app_routes.dart';
import 'package:flutter_application_1/utils/common.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/domain/cubit/auth/auth.cubit.dart';

class PersonalScreen extends StatelessWidget {
  const PersonalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void Logout() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('logout'),
            content: const Text('r u sure?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('cancel')),
              TextButton(
                  onPressed: () {
                    context.read<AuthCubit>().logoutLogic(context);
                  },
                  child: Text('sure!!'))
            ],
          );
        },
      );
    }

    void Orders() {
      return onNavigateToScreen(context, AppRoutes.orders);
    }

    void MyAddresses() {
      return onNavigateToScreen(context, AppRoutes.myaddresses);
    }

    return Scaffold(
        appBar: AppBar(
            title: Text(
          'personal',
          style: Theme.of(context).textTheme.titleMedium,
        )),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Account',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  GestureDetector(
                    onTap: () {
                      // go to profile
                    },
                    child: const ListTile(
                      contentPadding: EdgeInsets.all(0),
                      leading: Icon(Icons.person),
                      title: Text('Edit Profile'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // go to change password
                    },
                    child: const ListTile(
                      contentPadding: EdgeInsets.all(0),
                      leading: Icon(Icons.key),
                      title: Text('Change Password'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                  Text(
                    'General',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  GestureDetector(
                    onTap: () {
                      // go to profile
                      Orders();
                    },
                    child: const ListTile(
                      contentPadding: EdgeInsets.all(0),
                      leading: Icon(Icons.shopping_basket),
                      title: Text('Orders'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // go to change password
                    },
                    child: const ListTile(
                      contentPadding: EdgeInsets.all(0),
                      leading: Icon(Icons.favorite),
                      title: Text('Favorites'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // go to change password
                      MyAddresses();
                    },
                    child: const ListTile(
                      contentPadding: EdgeInsets.all(0),
                      leading: Icon(Icons.add_location_alt),
                      title: Text('My Addresses'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                  Text(
                    'App Settings',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  GestureDetector(
                    onTap: () {
                      // go to profile
                    },
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      leading: const Icon(Icons.notifications),
                      title: const Text('Notifications'),
                      trailing: Switch(value: true, onChanged: (b) {}),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // go to change password
                    },
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      leading: const Icon(Icons.dark_mode),
                      title: const Text('Dark Mode'),
                      trailing: Switch(value: true, onChanged: (b) {}),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // change language
                    },
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      leading: const Icon(Icons.language),
                      title: const Text('Language'),
                      trailing: Switch(value: true, onChanged: (b) {}),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // logout
                      Logout();
                    },
                    child: const ListTile(
                      contentPadding: EdgeInsets.all(0),
                      leading: Icon(Icons.logout),
                      title: Text('Logout'),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
