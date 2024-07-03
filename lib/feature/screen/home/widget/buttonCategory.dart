import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ButtonCategory extends StatelessWidget {
  final String imgURL;
  const ButtonCategory({required this.imgURL, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Expanded(
        child: Container(
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
                imgURL,
              ), // แสดงภาพจาก URL
              fit: BoxFit.contain,
              // ปรับภาพให้ครอบคลุมพื้นที่ทั้งหมด
            ),
          ),
        ),
      ),
      Text('data', style: Theme.of(context).textTheme.titleSmall,)
    ]);
  }
}
