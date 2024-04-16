import 'package:flutter/material.dart';

void modalLoading(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          content: Container(
            height: 100,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [],
                ),
                const Divider(),
                const SizedBox(height: 10),
                Row(
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(
                      width: 15,
                    ),
                    Text('data')
                  ],
                )
              ],
            ),
          )));
}
