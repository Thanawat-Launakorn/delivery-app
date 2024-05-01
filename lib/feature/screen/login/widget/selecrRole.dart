import 'package:flutter/material.dart';

class SelectRole extends StatelessWidget {
  const SelectRole({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('How do you want to continue'),
            Card(
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Colors.red,
                    Colors.yellow.shade300,
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                )),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 64, vertical: 48),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('img'),
                      Text('Restaurant', style: TextStyle(fontSize: 20),),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
