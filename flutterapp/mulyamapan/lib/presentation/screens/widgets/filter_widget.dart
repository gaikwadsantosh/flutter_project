import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mulyankan/logic/cubits/subcategory_cubit/sub_category_state.dart';
import 'package:mulyankan/logic/cubits/subcategory_cubit/subcategory_cubit.dart';
import 'package:mulyankan/presentation/screens/widgets/gap_widget.dart';

class FilterWidget extends StatefulWidget {
  final Function(FocusNode) onFocusRequested;
  const FilterWidget({Key? key, required this.onFocusRequested})
      : super(key: key);

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  final FocusNode _focusNode = FocusNode();
  int? _selectedReviewIndex;
  int? _selectedPriceIndex;
  bool? _payOnDelivery = false;

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

  Widget applyFilterRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Selected Filters (2)"),
        CupertinoButton(
          child: const Text("Clear Selection"),
          onPressed: () {},
        ),
        CupertinoButton(
          child: const Text("Apply Filter"),
          onPressed: () {},
        )
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
            applyFilterRow(),
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
                      return ListTile(
                        visualDensity: const VisualDensity(vertical: -4.0),
                        onTap: () {
                          setState(() {
                            subcategory.isSelected
                                ? subcategory.isSelected = false
                                : subcategory.isSelected = true;
                          });
                        },
                        title: Text(subcategory.subcategoryName),
                        tileColor: subcategory.isSelected
                            ? Colors.blue
                            : Colors.transparent,
                      );
                    },
                  ),
                );
              },
            ),
            const GapWidget(
              size: 10,
            ),
            const Text(
              "Customer Reviews",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
            ),
            Column(
              children: List.generate(4, (index) {
                final imageName =
                    "lib/assets/images/customer_reviews_${4 - index}_up.jpg"; // Adjust naming pattern as needed
                final isSelectedReview = _selectedReviewIndex == index;

                Color selectedReviewColor =
                    isSelectedReview ? Colors.blue : Colors.transparent;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedReviewIndex = isSelectedReview ? null : index;
                      print("price selected $index");
                    });
                  },
                  child: Image.asset(
                    imageName,
                    height: 30,
                    width: 100,
                    color: selectedReviewColor,
                    colorBlendMode: BlendMode
                        .color, // You can adjust this blend mode as needed
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
                final isSelected = _selectedPriceIndex == index;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedPriceIndex = isSelected ? null : index;
                        print("price selected $index");
                      });
                    },
                    child: Text(
                        "${index * 1000 * 10} - ${(index + 1) * 10 * 1000}",
                        style: TextStyle(
                            backgroundColor:
                                isSelected ? Colors.blue : Colors.transparent)),
                  ),
                );
              }),
            ),
            const GapWidget(size: 10),
            const Text(
              "Pay on delivery",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
            ),
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text('Eligible for Pay On Delivery'),
              value: _payOnDelivery, // Bind to a boolean variable
              onChanged: (newValue) {
                setState(() {
                  _payOnDelivery = newValue;
                });
              },
            ),
            const GapWidget(size: 80),
            const Text(
              "Discount",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
            ),
            const GapWidget(size: 80),
            const Text(
              "Availability",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
            ),
            const GapWidget(size: 80),
            applyFilterRow(),
          ],
        ),
      ),
    );
  }
}
