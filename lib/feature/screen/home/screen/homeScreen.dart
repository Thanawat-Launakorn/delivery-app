import 'package:flutter/material.dart';
import 'package:flutter_application_1/feature/screen/home/widget/bottomCart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/asset/image.dart';
import 'package:flutter_application_1/utils/common.dart';
import 'package:flutter_application_1/l10n/translations.dart';
import 'package:flutter_application_1/route/app_arguments.dart';
import 'package:flutter_application_1/domain/bloc/cart/cart_bloc.dart';
import 'package:flutter_application_1/domain/cubit/lang/language_cubit.dart';
import 'package:flutter_application_1/domain/cubit/product/product_cubit.dart';
import 'package:flutter_application_1/domain/cubit/category/category_cubit.dart';
import 'package:flutter_application_1/feature/screen/home/widget/productItem.dart';
import 'package:flutter_application_1/feature/screen/login/widget/changeLang.dart';
import 'package:flutter_application_1/feature/screen/home/widget/buttonCategory.dart';
import 'package:flutter_application_1/feature/screen/home/widget/iconButtonOnAppBar.dart';
import 'package:flutter_application_1/feature/screen/home/widget/bottomModalChangeAddress.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _visibleAppBar = false;
  final double expandedBarHeight = 200;
  final double collapsedBarHeight = 100;

  @override
  void initState() {
    //handleScroll
    _scrollController.addListener(() {
      if (_scrollController.offset > 50) {
        // attached appbar
        setState(() {
          _visibleAppBar = true;
        });
      } else {
        setState(() {
          _visibleAppBar = false;
        });
      }
    });
    super.initState();
  }

  void openChangeAddress(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => BottomModalChangeAddress(),
    );
  }

  void onClickSearchField(BuildContext context) {
    onNavigateToScreen(context, '/searchProduct');
  }

  void onPressChangeLang(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const ChangeLangModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: AnimatedOpacity(
        opacity: _visibleAppBar ? 1 : 0,
        duration: const Duration(milliseconds: 150),
        child: GestureDetector(
          onTap: () {
            // call change address
            if (_visibleAppBar) {
              openChangeAddress(context);
            }
          },
          child: const ListTile(
            title: Text('ส่งทันที่'),
            subtitle: Row(
              children: [
                Text('เลือกที่อยู่จัดส่ง'),
                SizedBox(
                  width: 2,
                ),
                Icon(Icons.arrow_drop_down)
              ],
            ),
          ),
        ),
      ),
      actions: [
        !_visibleAppBar
            ? Row(children: [
                IconButtonOnAppBar(
                    onPress: () {
                      onNavigateToScreen(context, '/favorite');
                    },
                    child: const Icon(
                      Icons.favorite_outline,
                      color: Colors.white,
                    )),
                const SizedBox(
                  width: 10,
                ),
                BlocBuilder<LanguageCubit, LanguageState>(
                  builder: (context, state) {
                    return IconButtonOnAppBar(
                        onPress: () {
                          onPressChangeLang(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: state is LanguageInitial
                              ? state.selectedLanguage.flag
                              : const Placeholder(),
                        ));
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButtonOnAppBar(
                    onPress: () {
                      onNavigateToScreen(context, '/settings');
                    },
                    child: const Icon(
                      Icons.person_outline,
                      color: Colors.white,
                    )),
                const SizedBox(
                  width: 20,
                )
              ])
            : Row(
                children: [
                  IconButtonOnAppBar(
                      onPress: () {
                        onNavigateToScreen(context, '/search');
                      },
                      child: const Icon(Icons.search_outlined,
                          color: Colors.white)),
                  const SizedBox(
                    width: 20,
                  )
                ],
              )
      ],
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    );
    int itemC = 24;
    double topContainerHeight = 150;
    int rowCount = (itemC / 2).ceil();
    double appBarHeight = appBar.preferredSize.height;
    double screenHeight = MediaQuery.of(context).size.height;
    double totalHeight = (rowCount * 200) + ((rowCount - 1) * 24);
    double availableHeight = screenHeight - appBarHeight - topContainerHeight;

    double gridViewHeight =
        totalHeight > availableHeight ? totalHeight : availableHeight;
    // print('total ===> ${totalHeight}');
    // print('avaible ===> ${availableHeight}');
    // print('gridViewHeight ===> ${gridViewHeight}');
    return Scaffold(
      appBar: appBar,
      body: Stack(children: [
        Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ส่งทันที'),
                      Row(children: [
                        Text('เลือกที่อยู่จัดส่ง'),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        )
                      ])
                    ],
                  ),
                ),
                Align(
                  child: Image(
                      fit: BoxFit.fill,
                      image: AssetImage(Asset.images['basket'] as String)),
                )
              ],
            ),
          ),
        ),
        // *** main container ***
        RawScrollbar(
          controller: _scrollController,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            padding: const EdgeInsets.only(top: 60),
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                // Main Container
                Container(
                  padding: const EdgeInsets.only(top: 60),
                  height: gridViewHeight,
                  decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30)),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: ElevatedButton(
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(translations(context)!.send_now),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        const Icon(Icons.delivery_dining)
                                      ],
                                    ))),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(translations(context)!
                                            .pick_up_at_the_store),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        const Icon(Icons.home_filled)
                                      ])),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'หมวดหมู่สินค้า',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                ),
                                InkWell(
                                  onTap: () {
                                    onNavigateToScreen(context, '/categoryAll');
                                  },
                                  child: Text(
                                    'ดูทั้งหมด > ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          fontSize: 14,
                                          color: Colors.black54,
                                        ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),

                      // All Category
                      BlocBuilder<CategoryCubit, CategoryState>(
                        builder: (context, state) {
                          if (state is CategoryLoadingState &&
                              state.isLoading) {
                            return const CircularProgressIndicator();
                          } else if (state is CategoryResponseState) {
                            final categories = state.response;
                            return SizedBox(
                              width: double.infinity,
                              height: 200,
                              child: GridView.builder(
                                scrollDirection: Axis.horizontal,
                                primary: false,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 24,
                                  crossAxisCount: 2,
                                ),
                                itemCount: categories
                                    .length, // ใช้ length ของ categories
                                itemBuilder: (context, index) {
                                  final category = categories[index];
                                  return ButtonCategory(
                                    category: category,
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/categoryDetail',
                                          arguments: CategoryDetailArguments(
                                              id: category.id));
                                    },
                                  );
                                },
                              ),
                            );
                          } else if (state is CategoryResponseErrorState) {
                            return const Center(
                              child: Text(
                                  'Failed to load categories'), // ข้อความแจ้งข้อผิดพลาด
                            );
                          } else {
                            return Text('No categories available');
                          }
                        },
                      ),

                      const SizedBox(
                        height: 24,
                      ),

                      Expanded(
                        child: BlocBuilder<ProductCubit, ProductState>(
                          builder: (context, state) {
                            if (state is ProductLoadingState &&
                                state.isLoading) {
                              return CircularProgressIndicator();
                            } else if (state is ProductResponseState) {
                              final products = state.response;
                              return GridView.builder(
                                clipBehavior: Clip.none,
                                physics: const NeverScrollableScrollPhysics(),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                primary: false,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 1,
                                        mainAxisSpacing: 24,
                                        crossAxisSpacing: 24),
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  final ProductDetailArguments product =
                                      ProductDetailArguments(
                                          product: products[index]);

                                  return ProductItem(
                                    onPressed: () => Navigator.pushNamed(
                                        context, '/productDetail',
                                        arguments: product),
                                    product: products[index],
                                    key: ValueKey(index),
                                  );
                                },
                              );
                            } else if (state is ProductResponseErrorState) {
                              return const Center(
                                child: Text(
                                    'Failed to load products'), // ข้อความแจ้งข้อผิดพลาด
                              );
                            } else {
                              return Text('No categories available');
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),

                //  *** Search Content ***
                Positioned(
                  top: -10,
                  height: MediaQuery.of(context).size.height * .05,
                  width: MediaQuery.of(context).size.width * .9,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 3,
                          )
                        ]),
                    child: TextField(
                      onTap: () {
                        onClickSearchField(context);
                      },
                      canRequestFocus: false,
                      style: Theme.of(context).textTheme.titleSmall,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12),
                          filled: true,
                          fillColor: Colors.white,
                          label: Text(
                            translations(context)!.search,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // *** Container Cart ***
        BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            final isHaveCart = state is CartUpdated && state.items.isNotEmpty;
            if (isHaveCart) {
              final sumTotal = state.items.map((it) => it.quantity * it.product.price).reduce((value, element) => value + element);
              final sumQuantity = state.items
                  .map((it) => it.quantity)
                  .reduce((prev, curr) => prev + curr);
              return BottomCart(
                sumTotal: sumTotal,
                quantity: sumQuantity,
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ]),
      floatingActionButton: AnimatedOpacity(
        opacity: _visibleAppBar ? 1 : 0,
        duration: const Duration(milliseconds: 150),
        child: FloatingActionButton(
          onPressed: () {
            _scrollController.animateTo(0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.linearToEaseOut);
          },
          child: const Icon(Icons.arrow_drop_up),
        ),
      ),
    );
  }
}
