import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_application_1/asset/image.dart';
import 'package:flutter_application_1/l10n/translations.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedOpacity(
          opacity: _visibleAppBar ? 1 : 0,
          duration: const Duration(milliseconds: 250),
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
          Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(255, 255, 255, .4)),
            child: const Icon(
              Icons.person_outline,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 12,
          )
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Stack(children: [
        Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text('ส่งทันที'), Text('your address')],
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
        RawScrollbar(
          controller: _scrollController,
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.only(top: 60),
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                // Main Container
                Container(
                  padding: const EdgeInsets.only(top: 60),
                  height: MediaQuery.of(context).size.height,
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
                                  child: const Text('pick up at the store')),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      CarouselSlider(
                        options: CarouselOptions(
                            initialPage: 0,
                            scrollDirection: Axis.horizontal,
                            height: MediaQuery.of(context).size.height * .2,
                            viewportFraction: .9),
                        items: [
                          1,
                          2,
                          3,
                        ].map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                  clipBehavior: Clip.hardEdge,
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 7.5),
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          Asset.images['carousel'] as String)));
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          primary: false,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8),
                          itemCount: 12,
                          itemBuilder: (context, index) {
                            return Container(
                              color: Colors.green,
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
                // Search Content
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
      ]),
    );
  }
}
