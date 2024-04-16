import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Appbar',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: GridView.builder(
          itemCount: 2,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 2, childAspectRatio: 1, crossAxisSpacing: 2),
          itemBuilder: (context, index) {
            return Container(
              child: Text('data'),
              decoration: BoxDecoration(color: Colors.blue),
            );
          },
        ),
      ),
    );
  }
}
