import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/constants/button.dart';

class BottomModalChangeAddress extends StatelessWidget {
  const BottomModalChangeAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .2,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 24,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'title',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        'subtitle',
                        style: Theme.of(context).textTheme.titleSmall,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          AppButton(
            text: 'แก้ที่อยู่จัดส่ง',
            onPressed: () {},
            size: AppButtonSize.SMALL,
          )
        ],
      ),
    );
  }
}
