import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/model/response_body/getAllCategoryResponseBody.dart';

class ButtonCategory extends StatelessWidget {
  final GetAllCategoryResponse category;
  final void Function() onPressed;
  const ButtonCategory(
      {required this.category, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 4),
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: .5,
              )
            ],
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(
                category.image,
              ), // แสดงภาพจาก URL
              fit: BoxFit.contain,
              // ปรับภาพให้ครอบคลุมพื้นที่ทั้งหมด
            ),
          ),
        ),
        Text(
          category.category,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleSmall,
        )
      ]),
    );
  }
}
