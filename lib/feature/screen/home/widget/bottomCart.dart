import 'package:flutter/material.dart';
import 'package:flutter_application_1/helper/modifyText/index.dart';
import 'package:flutter_application_1/utils/common.dart';
import 'package:flutter_application_1/widget/colors.dart';

class BottomCart extends StatelessWidget {
  final int quantity;
  final int sumTotal;
  const BottomCart({required this.quantity, required this.sumTotal, super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      width: MediaQuery.of(context).size.width,
      child: InkWell(
        onTap: () {
          onNavigateToScreen(context, '/cart');
        },
        child: Container(
          height: 60,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 2, spreadRadius: 2)
          ], color: Theme.of(context).colorScheme.inversePrimary),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black38),
                  padding: const EdgeInsets.all(6),
                  child: Row(
                    children: [
                      Icon(
                        Icons.local_grocery_store_outlined,
                        size: 16,
                        color: AppColors.colors['white'],
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        '$quantity',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Text(
                  'ดูตะกร้าสินค้า',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                Text(
                  '${ModifyText.ModifyTextTwoDedimal(sumTotal)} บาท',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
