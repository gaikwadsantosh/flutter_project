import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mulyankan/data/models/product/product_model.dart';
import 'package:mulyankan/data/models/product/product_search_input_model.dart';
import 'package:mulyankan/logic/cubits/product_cubit/product_cubit.dart';
import 'package:mulyankan/logic/cubits/product_cubit/product_state.dart';
import 'package:mulyankan/presentation/screens/product/product_detail_screen.dart';
import 'package:mulyankan/presentation/screens/widgets/gap_widget.dart';
import 'package:mulyankan/presentation/screens/widgets/searchbox_widget.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class ProductSearchScreen extends StatefulWidget {
  static const String routeName = 'product_search';
  final ProductSearchInputModel productSearchInputModel;
  const ProductSearchScreen({super.key, required this.productSearchInputModel});

  @override
  State<ProductSearchScreen> createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
            Expanded(
              child: SearchBoxWidget(
                hintText:
                    "Search ${widget.productSearchInputModel.categoryName} ${widget.productSearchInputModel.searchType} ...",
              ),
            ),
          ])),
      body: CustomScrollView(
        slivers: [
          BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final product = state.products[index];
                  if (state is ProductLoadingState && state.products.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is ProductErrorState && state.products.isEmpty) {
                    return Center(
                      child: Text(state.message),
                    );
                  }

                  return Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Center(
                      child: Column(
                        children: [
                          CupertinoButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, ProductDetailScreen.routeName,
                                  arguments: product);
                            },
                            child: Row(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: product.imageUrl ?? "",
                                  width: 200,
                                  height: 100,
                                ),
                                const GapWidget(),
                                Flexible(
                                  child: Text(
                                    product.productName!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  color: Colors.amber,
                                  child: const Column(
                                    children: [
                                      GapWidget(),
                                      Text(
                                        "Amazon",
                                        textAlign: TextAlign.center,
                                      ),
                                      GapWidget(),
                                      Text(
                                        "Description: ",
                                      ),
                                      Text(
                                        "Price: ",
                                      ),
                                      Text(
                                        "Rating: ",
                                      ),
                                      GapWidget(),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  color: Colors.green,
                                  child: const Column(
                                    children: [
                                      GapWidget(),
                                      Text(
                                        "Flipkart",
                                        textAlign: TextAlign.center,
                                      ),
                                      GapWidget(),
                                      Text(
                                        "Description: ",
                                      ),
                                      Text(
                                        "Price: ",
                                      ),
                                      Text(
                                        "Rating: ",
                                      ),
                                      GapWidget(),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.grey,
                            thickness: 1.0,
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: state.products
                    .length, // Update childCount to match the product list length
              ),
            );
          }),
        ],
      ),
    );
  }
}
