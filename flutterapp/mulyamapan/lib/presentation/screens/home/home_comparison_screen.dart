import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mulyankan/data/models/product/product_search_input_model.dart';
import 'package:mulyankan/presentation/screens/home/user_feed_screen.dart';
import 'package:mulyankan/presentation/screens/product/product_search_screen.dart';
import 'package:mulyankan/presentation/screens/widgets/carousel_widget.dart';
import 'package:mulyankan/presentation/screens/widgets/gap_widget.dart';
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

  @override
  void initState() {
    super.initState();
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
  Widget build(BuildContext context) {
    return ListView(children: [
      const CarouselWidget(),
      //--------------- Compare prices --------------------
      Container(
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
                      Navigator.pushNamed(
                          context, ProductSearchScreen.routeName,
                          arguments: ProductSearchInputModel(
                              categoryName: "eCommerce",
                              searchType: "Product List"));
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
      ),

      //--------------- Compare Todays Best Deal prices on --------------------
      Container(
        color: const Color.fromARGB(255, 200, 220, 195),
        child: Column(
          children: [
            const GapWidget(
              size: 5,
            ),
            const Text(
              textAlign: TextAlign.center,
              "Compare Today's Best Deal Prices on ...",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold), // Optional text styling
            ),
            Row(
              children: [
                Flexible(
                  child: CupertinoButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, ProductSearchScreen.routeName,
                          arguments: new ProductSearchInputModel(
                              categoryName: "eCommerce",
                              searchType: "Product Deals"));
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
      ),
    ]);
  }
}
