import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mulyankan/data/models/product/products_sort_flitered_by_model.dart';
import 'package:mulyankan/logic/cubits/subcategory_cubit/sub_category_state.dart';
import 'package:mulyankan/logic/cubits/subcategory_cubit/subcategory_cubit.dart';
import 'package:mulyankan/presentation/screens/product/providers/product_search_provider.dart';
import 'package:mulyankan/presentation/screens/widgets/gap_widget.dart';
import 'package:mulyankan/presentation/screens/widgets/searchbox_widget.dart';

class FilterWidget extends StatefulWidget {
  final Function(FocusNode) onFocusRequested;
  final ProductSearchProvider productSearchProvider;
  final ProductsFilterSortByModel productsFilterSortByModel;
  final Function clearSearchBoxCallback;

  const FilterWidget(
      {Key? key,
      required this.onFocusRequested,
      required this.productSearchProvider,
      required this.productsFilterSortByModel,
      required this.clearSearchBoxCallback})
      : super(key: key);

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  final FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    widget.onFocusRequested(_focusNode);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Widget applyFilterRow(BuildContext context,
      ProductsFilterSortByModel productsFilterSortByModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black, // Change color as needed
              width: 0.5, // Change width as needed
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              productsFilterSortByModel.sortbyField != null
                  ? Text(
                      "Sort By : ${productsFilterSortByModel.sortbyField} ${productsFilterSortByModel.sortOrder}")
                  : const Text("Sort By : Default"),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Selected Filters",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              productsFilterSortByModel.featured == true
                  ? Text("Featured : ${productsFilterSortByModel.featured}")
                  : const SizedBox.shrink(),
              productsFilterSortByModel.newArrivals == true
                  ? Text(
                      "New Arrivals : ${productsFilterSortByModel.newArrivals}")
                  : const SizedBox.shrink(),
              productsFilterSortByModel.payOnDelivery == true
                  ? Text(
                      "Pay on Delivery : ${productsFilterSortByModel.payOnDelivery}")
                  : const SizedBox.shrink(),
              productsFilterSortByModel.averageReview != null
                  ? Text(
                      "Average Review : ${productsFilterSortByModel.averageReview}")
                  : const SizedBox.shrink(),
              productsFilterSortByModel.subCategoryId != null
                  ? Text(
                      "Sub Category Id : ${productsFilterSortByModel.subCategoryId}")
                  : const SizedBox.shrink(),
              productsFilterSortByModel.priceFrom != null
                  ? Text(
                      "Price : ${productsFilterSortByModel.priceFrom} - ${productsFilterSortByModel.priceTo}")
                  : const SizedBox.shrink(),
              productsFilterSortByModel.productNameSearchTerm != null
                  ? Text(
                      "Product Search Term : ${productsFilterSortByModel.productNameSearchTerm}")
                  : const SizedBox.shrink(),
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          padding: const EdgeInsets.all(1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CupertinoButton(
                padding: const EdgeInsets.all(0),
                child: const Text("Clear Selection"),
                onPressed: () {
                  setState(() {
                    widget.productsFilterSortByModel.averageReview = null;
                    widget.productsFilterSortByModel.priceFrom = null;
                    widget.productsFilterSortByModel.priceTo = null;
                    widget.productsFilterSortByModel.featured = null;
                    widget.productsFilterSortByModel.newArrivals = null;
                    widget.productsFilterSortByModel.payOnDelivery = null;
                    widget.productsFilterSortByModel.subCategoryId = null;
                    widget.productsFilterSortByModel.productNameSearchTerm = "";
                    widget.productsFilterSortByModel.subCategoryName = "";
                  });
                  widget.clearSearchBoxCallback();
                  widget.productSearchProvider
                      .getFilteredSortedProducts(productsFilterSortByModel);
                },
              ),
              CupertinoButton(
                padding: const EdgeInsets.all(0),
                alignment: Alignment.topLeft,
                child: const Text("Apply Filter"),
                onPressed: () {
                  widget.productSearchProvider
                      .getFilteredSortedProducts(productsFilterSortByModel);
                },
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(
              height: 1,
              color: Colors.black,
            ),
            const SizedBox(
              height: 5,
            ),
            //selected filtered
            applyFilterRow(context, widget.productsFilterSortByModel),
            //available filteres
            const SizedBox(
              height: 5,
            ),
            const Divider(
              height: 1,
              color: Colors.black,
            ),
            CheckboxListTile(
              dense: true,
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text('New Arrivals'),
              value: widget.productsFilterSortByModel.newArrivals ?? false,
              onChanged: (newValue) {
                setState(() {
                  widget.productsFilterSortByModel.newArrivals = newValue;
                });
              },
            ),
            CheckboxListTile(
              dense: true,
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text('Featured'),
              value: widget.productsFilterSortByModel.featured ?? false,
              onChanged: (newValue) {
                setState(() {
                  widget.productsFilterSortByModel.featured = newValue;
                });
              },
            ),
            CheckboxListTile(
              dense: true,
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text('Pay on Delivery'),
              value: widget.productsFilterSortByModel.payOnDelivery ?? false,
              onChanged: (newValue) {
                setState(() {
                  widget.productsFilterSortByModel.payOnDelivery = newValue;
                });
              },
            ),
            const GapWidget(),
            const Text(
              "Subcategory",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
            ),
            BlocBuilder<SubCategoryCubit, SubCategoryState>(
              builder: (context, state) {
                return SizedBox(
                  height: 150,
                  width: 150,
                  child: ListView.builder(
                    itemCount: state.subCategories.length,
                    itemBuilder: (context, index) {
                      final subcategory = state.subCategories[index];
                      final isSelectedSubcategory =
                          widget.productsFilterSortByModel.subCategoryId ==
                              subcategory.id;

                      Color selectedSubCategoryColor = isSelectedSubcategory
                          ? Colors.blue
                          : Colors.transparent;

                      return ListTile(
                        dense: true,
                        visualDensity: const VisualDensity(vertical: -4.0),
                        onTap: () {
                          setState(() {
                            widget.productsFilterSortByModel.subCategoryId =
                                isSelectedSubcategory ? null : subcategory.id;
                          });
                        },
                        title: Text(subcategory.subcategoryName),
                        tileColor: selectedSubCategoryColor,
                      );
                    },
                  ),
                );
              },
            ),
            const GapWidget(),
            const Text(
              "Customer Reviews",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
            ),
            Column(
              children: List.generate(4, (index) {
                final imageName =
                    "lib/assets/images/customer_reviews_${4 - index}_up.jpg"; // Adjust naming pattern as needed
                final isSelectedReview =
                    widget.productsFilterSortByModel.averageReview == 4 - index;

                Color selectedReviewColor =
                    isSelectedReview ? Colors.blue : Colors.transparent;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.productsFilterSortByModel.averageReview =
                          isSelectedReview ? null : 4 - index.toDouble();
                      print("review selected $index");
                    });
                  },
                  child: Image.asset(
                    imageName,
                    height: 30,
                    width: 100,
                    color: selectedReviewColor,
                    colorBlendMode: BlendMode.color,
                  ),
                );
              }),
            ),
            const GapWidget(size: 10),
            const Text(
              "Price",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
            ),
            Column(
              children: List.generate(4, (index) {
                double? _priceFrom = (index * 10 * 1000);
                double? _priceTo = ((index + 1) * 10 * 1000);

                final isSelectedPrice =
                    widget.productsFilterSortByModel.priceFrom == _priceFrom;
                String priceText = "$_priceFrom - $_priceTo";
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.productsFilterSortByModel.priceFrom =
                            isSelectedPrice ? null : _priceFrom;
                        widget.productsFilterSortByModel.priceTo =
                            isSelectedPrice ? null : _priceTo;
                        print("price selected $index");
                      });
                    },
                    child: Text(priceText,
                        style: TextStyle(
                            backgroundColor: isSelectedPrice
                                ? Colors.blue
                                : Colors.transparent)),
                  ),
                );
              }),
            ),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              height: 1,
              color: Colors.black,
            ),
            const SizedBox(
              height: 5,
            ),
            applyFilterRow(context, widget.productsFilterSortByModel),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              height: 1,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
