import 'package:flutter/material.dart';
import 'package:flutter_application_1/asset/image.dart';
import 'package:flutter_application_1/widget/constants/button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'ตะกร้าของฉัน',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 4,
              child: ListView.separated(
                separatorBuilder: (context, index) => Container(
                  width: MediaQuery.of(context).size.width,
                  height: .5,
                  color: Colors.grey,
                ),
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 12),
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black26,
                                    spreadRadius: 1,
                                    blurRadius: 1)
                              ],
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage(
                                      Asset.images['basket'] as String))),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'title named',
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                              ),
                            ),
                            Text(
                              '\$2.99',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26, spreadRadius: 1, blurRadius: 1)
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('ราคารวม',
                            style: Theme.of(context).textTheme.titleSmall!),
                        Text(
                          '116.00 บาท',
                          style: Theme.of(context).textTheme.titleSmall,
                        )
                      ],
                    ),
                    AppButton(
                      text: 'ถัดไป',
                      onPressed: () {},
                      size: AppButtonSize.SMALL,
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
