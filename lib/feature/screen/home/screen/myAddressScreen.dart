import 'package:flutter/material.dart';
import 'package:flutter_application_1/asset/image.dart';
import 'package:flutter_application_1/feature/screen/home/widget/bottomManageAddress.dart';

class MyAdressScreen extends StatelessWidget {
  const MyAdressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void manageAddress(BuildContext context) {
      showModalBottomSheet(
          backgroundColor: Colors.white,
          isScrollControlled: true,
          context: context,
          builder: (context) => const BottomManageAddress());
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: .5,
                blurRadius: .5,
              ),
            ],
          ),
          child: AppBar(
            title: Text(
              'ที่อยู่ของฉัน',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    manageAddress(context);
                  },
                  icon: Icon(
                    Icons.add,
                    size: 32,
                  ))
            ],
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 240,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image:
                            AssetImage(Asset.images['noAddress'] as String))),
              ),
              const SizedBox(
                height: 36,
              ),
              Text(
                'No Saved Address',
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
                'You can save your address to\nuse it all the time',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.black54, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ]),
      ),
    );
  }
}
