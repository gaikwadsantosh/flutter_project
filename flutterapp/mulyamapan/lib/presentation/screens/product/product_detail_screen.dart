import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mulyankan/core/ui.dart';
import 'package:mulyankan/data/models/product/product_model.dart';
import 'package:mulyankan/presentation/screens/widgets/gap_widget.dart';
import 'package:mulyankan/presentation/screens/widgets/primary_button.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = "product_detail";
  final ProductModel productModel;
  const ProductDetailScreen({super.key, required this.productModel});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: [
          Flexible(
            child: Text(
              "${widget.productModel.productName}",
              style: TextStyles.body1,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      )),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          children: [
            SizedBox(
              height: 150,
              child: CarouselSlider.builder(
                  slideBuilder: (index) {
                    return CachedNetworkImage(
                        imageUrl: widget.productModel.imageUrl ?? "");
                  },
                  itemCount: 1),
            ),
            const GapWidget(),
            Text(
              widget.productModel.productName ?? "",
              style: TextStyles.body1,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              widget.productModel.priceDiscount ?? "",
              style: TextStyles.heading3,
            ),
            const GapWidget(),
            PrimaryButton(
              onPressed: () {},
              text: "Add to Card",
            ),
            const GapWidget(),
            Text(
              widget.productModel.dealMessage ?? "",
              style: TextStyles.body2.copyWith(fontWeight: FontWeight.bold),
            ),
            const GapWidget(),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Container(
                    alignment: Alignment.topLeft,
                    color: Colors.amber,
                    child: Column(
                      children: [
                        const GapWidget(),
                        Text(
                          "Amazon",
                          style: TextStyles.heading3,
                        ),
                        const GapWidget(),
                        const Text(
                          "Description: ",
                        ),
                        const Text(
                          "Price: ",
                        ),
                        const Text(
                          "Rating: ",
                        ),
                        const GapWidget(),
                      ],
                    ),
                  ),
                ),
                const GapWidget(),
                Flexible(
                  child: Container(
                    alignment: Alignment.topLeft,
                    color: Colors.green,
                    child: Column(
                      children: [
                        const GapWidget(),
                        Text(
                          "Flipkart",
                          style: TextStyles.heading3,
                        ),
                        const GapWidget(),
                        const Text(
                          "Description: ",
                        ),
                        const Text(
                          "Price: ",
                        ),
                        const Text(
                          "Rating: ",
                        ),
                        const GapWidget(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
