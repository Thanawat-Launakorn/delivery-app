import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/model/request_body/addressRequestBody.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/utils/common.dart';
import 'package:flutter_application_1/widget/constants/button.dart';
import 'package:flutter_application_1/domain/model/address/address.model.dart';
import 'package:flutter_application_1/domain/cubit/address/address_cubit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BottomManageAddress extends StatefulWidget {
  final int? id;
  const BottomManageAddress({this.id, super.key});

  @override
  State<BottomManageAddress> createState() => _BottomManageAddressState();
}

class _BottomManageAddressState extends State<BottomManageAddress> {
  TextEditingController _addressTitle = TextEditingController();
  TextEditingController _fullName = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _zipCode = TextEditingController();
  TextEditingController _address = TextEditingController();

  AddressModel _method = AddressModel(title: 'home');
  String _userId = '';

  @override
  void initState() {
    _addressTitle = TextEditingController();
    _fullName = TextEditingController();
    _phone = TextEditingController();
    _zipCode = TextEditingController();
    _address = TextEditingController();

    void getUserId() async {
      final userId = await const FlutterSecureStorage().read(key: 'userId');
      setState(() {
        if (userId != null) _userId = userId;
      });
    }

    super.initState();
    getUserId();
  }

  @override
  void dispose() {
    _addressTitle.dispose();
    _fullName.dispose();
    _phone.dispose();
    _zipCode.dispose();
    _address.dispose();

    super.dispose();
  }

  void onSubmit(BuildContext context) {
    if (widget.id != null) {
      // edit
    } else {
      final AddressRequest body = AddressRequest(
          method: _method.title,
          addressTitle: _addressTitle.text,
          fullName: _fullName.text,
          address: _address.text,
          phone: _phone.text,
          userId: int.parse(_userId),
          zipCode: _zipCode.text);

      context.read<AddressCubit>().createAddress(body, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget methodAddressButton(IconData icon, String title) {
      return BlocBuilder<AddressCubit, AddressState>(
        builder: (context, state) {
          if (state is AddressInitial) {
            final isActive = state.seletedAddress.title == title;
            return GestureDetector(
              onTap: () {
                final AddressModel selectAddress = AddressModel(title: title);
                context.read<AddressCubit>().onChangeAddress(selectAddress);
                setState(() {
                  _method = AddressModel(title: title);
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                decoration: BoxDecoration(
                    color: isActive ? Colors.green : Colors.grey[400],
                    borderRadius: BorderRadius.circular(6)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      size: 32,
                      color: isActive ? Colors.white : Colors.black,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      capitalize(title),
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: isActive ? Colors.white : Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      );
    }

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 64, 16, 32),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(''),
                Text(
                  'Title',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 32,
                    ))
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: .5,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                methodAddressButton(Icons.home, 'home'),
                methodAddressButton(Icons.work, 'work'),
                methodAddressButton(Icons.location_on_rounded, 'other'),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              controller: _addressTitle,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w400),
              decoration: const InputDecoration(
                labelText: 'Address Title',
              ),
            ),
            TextField(
              controller: _fullName,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w400),
              decoration: const InputDecoration(
                labelText: 'Name Surname',
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _phone,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.w400),
                    decoration: const InputDecoration(
                      labelText: 'Phone',
                    ),
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
                Expanded(
                  child: TextField(
                    controller: _zipCode,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.w400),
                    decoration: const InputDecoration(
                      labelText: 'Zip Code',
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TextFormField(
                controller: _address,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w400),
                decoration: const InputDecoration(labelText: 'Address'),
                keyboardType: TextInputType.multiline,
                minLines: 24,
                maxLines: 50,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            AppButton(
                text: widget.id != null ? 'Edit' : 'Add',
                onPressed: () {
                  onSubmit(context);
                })
          ],
        ),
      ),
    );
  }
}
