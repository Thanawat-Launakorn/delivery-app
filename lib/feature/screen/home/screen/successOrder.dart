import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/asset/image.dart';
import 'package:flutter_application_1/route/app_routes.dart';
import 'package:flutter_application_1/utils/common.dart';
import 'package:flutter_application_1/widget/constants/button.dart';

class SuccessOrder extends StatelessWidget {
  const SuccessOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 240,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                            Asset.images['successOrder'] as String))),
              ),
              const SizedBox(
                height: 36,
              ),
              Text(
                'Your Order has Been Accepted',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'We\'ve accepted your order, and we\'re\ngetting it ready.',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.black54, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 36,
              ),
              AppButton(
                  text: 'Trac Order',
                  onPressed: () =>
                      onNavigateToScreen(context, AppRoutes.orders)),
              const SizedBox(
                height: 12,
              ),
              TextButton(
                  onPressed: () {
                    onReplaceToScreen(context, '/home');
                  },
                  child: Text(
                    'Back Home',
                    style: Theme.of(context).textTheme.titleMedium,
                  ))
            ]),
      ),
    );
  }
}
