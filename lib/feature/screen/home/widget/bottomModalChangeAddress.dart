import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/constants/button.dart';

class BottomModalChangeAddress extends StatelessWidget {
  const BottomModalChangeAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppButton(text: 'แก้ที่อยู่จัดส่ง', onPressed: () {}, size: AppButtonSize.SMALL,)
        ],
      ),
    );
  }
}
