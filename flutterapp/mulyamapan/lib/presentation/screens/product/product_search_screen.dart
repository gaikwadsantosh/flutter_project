import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mulyankan/core/ui.dart';
import 'package:mulyankan/core/utils.dart';
import 'package:mulyankan/data/models/product/product_model.dart';
import 'package:mulyankan/data/models/product/product_search_input_model.dart';
import 'package:mulyankan/data/models/product/product_sort_by_model.dart';
import 'package:mulyankan/logic/cubits/category_cubit/category_cubit.dart';
import 'package:mulyankan/logic/cubits/category_cubit/category_state.dart';
import 'package:mulyankan/logic/cubits/product_cubit/product_cubit.dart';
import 'package:mulyankan/logic/cubits/product_cubit/product_state.dart';
import 'package:mulyankan/presentation/screens/product/product_detail_screen.dart';
import 'package:mulyankan/presentation/screens/product/providers/product_search_provider.dart';
import 'package:mulyankan/presentation/screens/widgets/custom_scrollview_widget.dart';
import 'package:mulyankan/presentation/screens/widgets/filter_widget.dart';
import 'package:mulyankan/presentation/screens/widgets/gap_widget.dart';
import 'package:mulyankan/presentation/screens/widgets/searchbox_widget.dart';

class ProductSearchScreen extends StatefulWidget {
  static const String routeName = 'product_search';
  final ProductSearchInputModel productSearchInputModel;
  const ProductSearchScreen({super.key, required this.productSearchInputModel});

  @override
  State<ProductSearchScreen> createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  final filterScrollController = ScrollController();
  final searchListScrollController = ScrollController();
  final event = RawKeyEvent;
  final _productListKeyboardFocusNode = FocusNode();
  String selectedSortOption = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _productListKeyboardFocusNode.requestFocus();
    });
  }

  void _productListHandleKeyEvent(RawKeyEvent event) {
    Utils.handleKeyEventGeneric(event, searchListScrollController);
  }

  @override
  void dispose() {
    super.dispose();
    _productListKeyboardFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            //automaticallyImplyLeading: false,
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
              Expanded(
                child: SearchBoxWidget(
                  hintText:
                      "Search ${widget.productSearchInputModel.categoryName ?? ''} ${widget.productSearchInputModel.subCategoryName ?? ''} ${widget.productSearchInputModel.searchType ?? ''} : ${widget.productSearchInputModel.fromRange ?? ''} - ${widget.productSearchInputModel.toRange ?? ''}...",
                ),
              ),
            ])),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CupertinoButton(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            Image.asset(
                              'lib/assets/images/filterby.jpg', // Replace with the actual image file path
                              width: 20.0, // Adjust width as needed
                              height: 20.0, // Adjust height as needed
                              fit: BoxFit
                                  .scaleDown, // BoxFit property controls how the image should be inscribed into the box
                            ),
                            const Text(
                              "Filter by ",
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            //backgroundColor: Colors.white,
                            context: context,
                            builder: (context) {
                              return CustomScrollViewWidget(
                                scrollController: filterScrollController,
                                child: FilterWidget(
                                  onFocusRequested: (focusNode) {
                                    focusNode.requestFocus();
                                  },
                                ),
                              );
                              //),
                            },
                          );
                        }),
                    //const GapWidget(),
                    Image.asset(
                      'lib/assets/images/sortby.jpg', // Replace with the actual image file path
                      width: 30.0, // Adjust width as needed
                      height: 30.0, // Adjust height as needed
                      fit: BoxFit
                          .scaleDown, // BoxFit property controls how the image should be inscribed into the box
                    ),
                    const Text(
                      "Sort by ",
                      style: TextStyle(
                          fontSize: 14, color: const Color(0xff1ab7c3)),
                    ),

                    BlocBuilder<ProductCubit, ProductState>(
                      builder: (context, state) {
                        //return Text(state.productSortBy.length.toString());
                        return Container(
                          width: 200,
                          child: DropdownButtonFormField<ProductsSortByModel>(
                            isExpanded: false,
                            items: state.productSortBy.map((sortOption) {
                              return DropdownMenuItem<ProductsSortByModel>(
                                value: sortOption,
                                child: Text("${sortOption.sortby}" ??
                                    ""), // Customize the text as needed
                              );
                            }).toList(),
                            onChanged: (selectedSortOption) {
                              context
                                  .read<ProductSearchProvider>()
                                  .getSortedProducts(ProductsSortByModel(
                                      sortbyField:
                                          selectedSortOption!.sortbyField,
                                      sortOrder: selectedSortOption.sortOrder));
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const Divider(
                  thickness: 0.5,
                  color: Colors.grey,
                ),
                BlocBuilder<ProductCubit, ProductState>(
                    builder: (context, state) {
                  return Expanded(
                    child: RawKeyboardListener(
                      focusNode: _productListKeyboardFocusNode,
                      onKey: (RawKeyEvent event) {
                        _productListHandleKeyEvent(event);
                      },
                      child: FocusScope(
                        child: Scrollbar(
                          interactive:
                              true, // Set to true to always show the scrollbar
                          controller: searchListScrollController,
                          thickness:
                              20.0, // Adjust the thickness of the scrollbar
                          child: ListView.builder(
                            controller: searchListScrollController,
                            itemCount: state.productsSearched.length,
                            itemBuilder: (context, index) {
                              final product = state.productsSearched[index];
                              if (state is ProductLoadingState &&
                                  state.productsSearched.isEmpty) {
                                const CircularProgressIndicator();
                              }

                              if (state is ProductErrorState &&
                                  state.productsSearched.isEmpty) {
                                Text(state.message);
                              }

                              return Container(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                //child: Center(
                                child: Column(
                                  children: [
                                    CupertinoButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context,
                                            ProductDetailScreen.routeName,
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
                                //),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ]),
        ));
  }
}
