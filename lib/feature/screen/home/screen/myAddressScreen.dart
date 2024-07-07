import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_application_1/asset/image.dart';
import 'package:flutter_application_1/domain/cubit/address/get_address_cubit.dart';
import 'package:flutter_application_1/feature/screen/home/widget/bottomManageAddress.dart';
import 'package:flutter_application_1/domain/model/response_body/addressResponseBody.dart';

class MyAdressScreen extends StatefulWidget {
  const MyAdressScreen({super.key});

  @override
  State<MyAdressScreen> createState() => _MyAdressScreenState();
}

class _MyAdressScreenState extends State<MyAdressScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetAddressCubit>().fetchAddress();
  }

  @override
  Widget build(BuildContext context) {
    void manageAddress(BuildContext context) {
      showModalBottomSheet(
          backgroundColor: Colors.white,
          isScrollControlled: true,
          context: context,
          builder: (context) => const BottomManageAddress());
    }

    Widget itemAddress(BuildContext context, AddressResponse data) {
      return Column(children: [
        ListTile(
          leading: Icon(
            data.method == 'home'
                ? Icons.home
                : data.method == 'work'
                    ? Icons.work
                    : Icons.location_on_sharp,
            size: 32,
          ),
          title: Text(data.addressTitle),
          subtitle: Text(data.address),
          trailing: const Icon(
            Icons.arrow_right_outlined,
            size: 32,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: .5,
          color: Colors.grey,
        ),
      ]);
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
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
                  icon: const Icon(
                    Icons.add,
                    size: 32,
                  ))
            ],
          ),
        ),
      ),
      body: BlocBuilder<GetAddressCubit, GetAddressState>(
        builder: (context, state) {
          final isHaveAddress =
              state is ResponseGetUserAddressState && state.response.isNotEmpty;
          if (isHaveAddress) {
            return Expanded(
              child: ListView.builder(
                  itemCount: state.response.length,
                  itemBuilder: (context, index) {
                    return itemAddress(context, state.response[index]);
                  }),
            );
          } else if (state is LoadingGetUserAddressState) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Container(
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
                              image: AssetImage(
                                  Asset.images['noAddress'] as String))),
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
            );
          }
        },
      ),
    );
  }
}
