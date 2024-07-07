import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/cubit/product/product_cubit.dart';
import 'package:flutter_application_1/route/app_arguments.dart';
import 'package:flutter_application_1/widget/colors.dart';
import 'package:flutter_application_1/l10n/translations.dart';
import 'package:flutter_application_1/feature/screen/home/widget/productItem.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  final content = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colors['white'],
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          style: Theme.of(context).textTheme.titleMedium,
          decoration: InputDecoration(hintText: translations(context)!.search),
        ),
      ),
      body: Center(
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductLoadingState && state.isLoading) {
              return CircularProgressIndicator();
            } else if (state is ProductResponseState) {
              final products = state.response;

              return GridView.builder(
                  itemCount: products.length,
                  primary: false,
                  padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 24),
                  itemBuilder: (context, index) {
                    final ProductDetailArguments product =
                        ProductDetailArguments(product: products[index]);
                    return ProductItem(
                        product: products[index],
                        onPressed: () => Navigator.pushNamed(
                            context, '/productDetail',
                            arguments: product));
                  });
            } else if (state is ProductResponseErrorState) {
              return const Center(
                child: Text('Failed to load product'),
              );
            } else {
              return Text('No products available');
            }
          },
        ),
      ),
    );
  }
}
