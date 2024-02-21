import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mulyankan/core/ui.dart';
import 'package:mulyankan/core/utils.dart';
import 'package:mulyankan/data/models/product/products_sort_flitered_by_model.dart';
import 'package:mulyankan/logic/cubits/product_cubit/product_cubit.dart';
import 'package:mulyankan/logic/cubits/product_cubit/product_state.dart';
import 'package:mulyankan/logic/cubits/subcategory_cubit/sub_category_state.dart';
import 'package:mulyankan/logic/cubits/subcategory_cubit/subcategory_cubit.dart';
import 'package:mulyankan/presentation/screens/product/product_detail_screen.dart';
import 'package:mulyankan/presentation/screens/product/product_search_screen.dart';
import 'package:mulyankan/presentation/screens/widgets/carousel_widget.dart';
import 'package:mulyankan/presentation/screens/widgets/gap_widget.dart';
import 'package:mulyankan/presentation/screens/widgets/link_button.dart';
import 'package:mulyankan/presentation/screens/widgets/menubar_widget.dart';
import 'package:mulyankan/presentation/screens/widgets/service_providers_logo_widget.dart';

class HomeComparisonScreen extends StatefulWidget {
  const HomeComparisonScreen({super.key});

  @override
  State<HomeComparisonScreen> createState() => _HomeComparisonScreenState();
}

class _HomeComparisonScreenState extends State<HomeComparisonScreen> {
  List<String> eCommerceLogos = [];
  List<String> groceriesLogos = [];
  List<String> pharmacyLogos = [];
  List<String> babyProductsLogos = [];
  final CarouselController carouselControllerComparison = CarouselController();
  final CarouselController carouselControllerBudget = CarouselController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    RawKeyboard.instance.addListener(_productListHandleKeyEvent);

    eCommerceLogos.addAll([
      "lib/assets/images/amazon_logo.jpg",
      "lib/assets/images/flipkart_logo.jpg",
      "lib/assets/images/nykaa_logo.jpg",
      "lib/assets/images/myntra_logo.jpg"
    ]); // Add values within initState

    groceriesLogos.addAll([
      "lib/assets/images/blinkit_logo.jpg",
      "lib/assets/images/zepto_logo.jpg",
      "lib/assets/images/jiomart_logo.jpg",
      "lib/assets/images/bigbasket_logo.jpg"
    ]); // Add values within initState

    pharmacyLogos.addAll([
      "lib/assets/images/flipkartpharmacy_logo.jpg",
      "lib/assets/images/netmeds_logo.jpg",
      "lib/assets/images/apollopharmacy_logo.jpg",
      "lib/assets/images/amazonpharmacy_logo.jpg",
      "lib/assets/images/1mg_logo.jpg",
      "lib/assets/images/wellness_logo.jpg"
    ]); // Add values within initState

    babyProductsLogos.addAll([
      "lib/assets/images/luvlap_logo.jpg",
      "lib/assets/images/firstcry_logo.jpg",
      "lib/assets/images/sebamed_logo.jpg",
      "lib/assets/images/mamaearth_logo.jpg",
    ]); // Add values within initState
  }

  @override
  void dispose() {
    RawKeyboard.instance.removeListener(_productListHandleKeyEvent);
    super.dispose();
  }

  void _productListHandleKeyEvent(RawKeyEvent event) {
    Utils.handleKeyEventGeneric(event, _scrollController);
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      interactive: true, // Set to true to always show the scrollbar
      controller: _scrollController,
      thickness: 20.0, // Adjust the thickness of the scrollbar
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(children: [
          // Menu bar strip
          const MenuBarWidget(),
          //carousel
          const CarouselWidget(),
          comparePrices(),
          compareDeals(),
          popularProductsComparison(),
          productsByBudget(),
          const GapWidget()
        ]),
      ),
    );
  }

  Widget comparePrices() {
    return Container(
      color: const Color.fromARGB(255, 232, 229, 190),
      child: Column(
        children: [
          const GapWidget(
            size: 5,
          ),
          const Text(
            textAlign: TextAlign.center,
            'Compare Prices on ...',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold), // Optional text styling
          ),
          Row(
            children: [
              Flexible(
                child: CupertinoButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ProductSearchScreen.routeName,
                        arguments: ProductsFilterSortByModel(
                          subCategoryName: "eCommerce",
                        ));
                  },
                  child: ServiceProvidersLogoWidget(
                    title: "eCommerce",
                    imageUrls: eCommerceLogos,
                  ),
                ),
              ),
              Flexible(
                child: CupertinoButton(
                  onPressed: () {},
                  child: ServiceProvidersLogoWidget(
                    title: "Groceries",
                    imageUrls: groceriesLogos,
                  ),
                ),
              ),
              Flexible(
                child: CupertinoButton(
                  onPressed: () {},
                  child: ServiceProvidersLogoWidget(
                    title: "Medicine",
                    imageUrls: pharmacyLogos,
                  ),
                ),
              ),
              Flexible(
                child: CupertinoButton(
                  onPressed: () {},
                  child: ServiceProvidersLogoWidget(
                    title: "Baby Products",
                    imageUrls: babyProductsLogos,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget compareDeals() {
    return Container(
      color: const Color.fromARGB(255, 200, 220, 195),
      child: Column(
        children: [
          const GapWidget(
            size: 5,
          ),
          const Text(
            textAlign: TextAlign.center,
            "Compare Today's Best Deals on ...",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold), // Optional text styling
          ),
          Row(
            children: [
              Flexible(
                child: CupertinoButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ProductSearchScreen.routeName,
                        arguments: ProductsFilterSortByModel(
                          subCategoryName: "eCommerce",
                        ));
                  },
                  child: ServiceProvidersLogoWidget(
                    title: "eCommerce",
                    imageUrls: eCommerceLogos,
                  ),
                ),
              ),
              Flexible(
                child: CupertinoButton(
                  onPressed: () {},
                  child: ServiceProvidersLogoWidget(
                    title: "Groceries",
                    imageUrls: groceriesLogos,
                  ),
                ),
              ),
              Flexible(
                child: CupertinoButton(
                  onPressed: () {},
                  child: ServiceProvidersLogoWidget(
                    title: "Medicine",
                    imageUrls: pharmacyLogos,
                  ),
                ),
              ),
              Flexible(
                child: CupertinoButton(
                  onPressed: () {},
                  child: ServiceProvidersLogoWidget(
                    title: "Baby Products",
                    imageUrls: babyProductsLogos,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget popularProductsComparison() {
    return BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
      return Container(
        alignment: Alignment.topCenter,
        color: Color.fromRGBO(224, 198, 121, 1),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const GapWidget(
              size: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  alignment: Alignment.centerLeft,
                  onPressed: () {
                    carouselControllerComparison.previousPage();
                  },
                ),
                const Expanded(
                  child: Text(
                    textAlign: TextAlign.center,
                    "Popular Products with comparison ...",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  alignment: Alignment.centerRight,
                  onPressed: () {
                    carouselControllerComparison.nextPage();
                  },
                ),
                const GapWidget(),
              ],
            ),
            const GapWidget(size: 5),
            CarouselSlider(
              items: state.products
                  .map(
                    (product) => Container(
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                              color: Colors.blue.withOpacity(0.5), width: 2.0),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 224, 198, 121),
                            offset: Offset(2, 2),
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          CachedNetworkImage(
                            width: 70, //MediaQuery.of(context).size.width / 3,
                            height: 70,
                            imageUrl: "${product.imageUrl}",
                          ),
                          const GapWidget(),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              "${product.productName}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const GapWidget(),
                          Text(
                            "${product.priceDiscount}",
                            style: TextStyles.boldBody3,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          LinkButton(
                            alignment: Alignment.center,
                            text: "Open",
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, ProductDetailScreen.routeName,
                                  arguments: product);
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              carouselController: carouselControllerComparison,
              options: CarouselOptions(
                height: 250,
                scrollPhysics: const BouncingScrollPhysics(),
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 4),
                //aspectRatio: 5,
                viewportFraction: kIsWeb ? 0.2 : 0.6,
                onPageChanged: (index, reason) {
                  setState(() {
                    //currentIndex = index;
                  });
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget productsByBudget() {
    return BlocBuilder<SubCategoryCubit, SubCategoryState>(
        builder: (context, state) {
      return Container(
        color: Color.fromARGB(255, 190, 241, 219),
        alignment: Alignment.topCenter,
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const GapWidget(
              size: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  alignment: Alignment.centerLeft,
                  onPressed: () {
                    carouselControllerBudget.previousPage();
                  },
                ),
                const Expanded(
                  child: Text(
                    textAlign: TextAlign.center,
                    "Popular Products by Budget ...",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                IconButton(
                  alignment: Alignment.centerRight,
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () {
                    carouselControllerBudget.nextPage();
                  },
                ),
                const GapWidget(),
              ],
            ),
            const GapWidget(),
            CarouselSlider(
              items: (state.subCategories ?? [])
                  .map(
                    (subcategory) => Container(
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                              color: Colors.blue.withOpacity(0.5), width: 2.0),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 190, 241, 219),
                            offset: Offset(2, 2),
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                      child: Container(
                        alignment: Alignment.topCenter,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const GapWidget(),
                              Text(
                                subcategory.subcategoryName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              ...subcategory.budgetRanges
                                  .map((budgetrange) => LinkButton(
                                        alignment: Alignment.center,
                                        text:
                                            "Rs.${budgetrange.fromRange} - Rs. ${budgetrange.toRange}",
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            ProductSearchScreen.routeName,
                                            arguments: ProductsFilterSortByModel(
                                                subCategoryName: subcategory
                                                        .subcategoryName ??
                                                    '',
                                                priceFrom: budgetrange
                                                    .fromRange!
                                                    .toDouble(),
                                                priceTo: budgetrange.toRange!
                                                    .toDouble(),
                                                subCategoryId: subcategory.id),
                                          );
                                        },
                                      )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
              carouselController: carouselControllerBudget,
              options: CarouselOptions(
                height: 400,
                scrollPhysics: const BouncingScrollPhysics(),
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 4),
                //aspectRatio: 4,
                viewportFraction: kIsWeb ? 0.2 : 0.6,
                onPageChanged: (index, reason) {
                  setState(() {
                    //currentIndex = index;
                  });
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
