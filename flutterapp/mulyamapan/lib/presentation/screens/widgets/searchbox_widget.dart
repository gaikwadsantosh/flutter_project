import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mulyankan/data/models/product/product_model.dart';
import 'package:mulyankan/data/models/product/products_sort_flitered_by_model.dart';
import 'package:mulyankan/logic/cubits/product_cubit/product_cubit.dart';
import 'package:mulyankan/logic/cubits/product_cubit/product_state.dart';
import 'package:mulyankan/presentation/screens/product/product_search_screen.dart';
import 'package:mulyankan/presentation/screens/product/providers/product_search_provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SearchBoxWidget extends StatefulWidget {
  String hintText;
  bool showDrawer = false;
  final ProductSearchProvider productSearchProvider;
  final ProductsFilterSortByModel productsFilterSortByModel;
  final TextEditingController searchBoxController;

  SearchBoxWidget(
      {super.key,
      required this.hintText,
      this.showDrawer = false,
      required this.productSearchProvider,
      required this.productsFilterSortByModel,
      required this.searchBoxController});

  @override
  State<SearchBoxWidget> createState() => _SearchBoxWidgetState();
}

class _SearchBoxWidgetState extends State<SearchBoxWidget> {
  late Autocomplete<ProductModel> textAutoField;
  final stt.SpeechToText speech = stt.SpeechToText();

  void updateHintText(String newHintText) {
    _SearchBoxWidgetState state =
        context.findAncestorStateOfType<_SearchBoxWidgetState>()!;
    if (state != null) {
      state.setHintText(newHintText);
    }
  }

  @override
  void initState() {
    super.initState();
    print("called: initState");
  }

  void setHintText(String newHintText) {
    setState(() {
      widget.hintText = newHintText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
      if (state is ProductLoadedState) {
        if (state.products == null) return SizedBox.shrink();
        return Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text == '') {
              return const Iterable<String>.empty();
            }
            return state.products
                .where((product) => product.productName!
                    .toLowerCase()
                    .contains(textEditingValue.text.toLowerCase()))
                .map((product) => product.productName!);
          },
          onSelected: (String selection) {
            print('You just selected $selection');

            widget.productsFilterSortByModel.productNameSearchTerm = selection;
            widget.productsFilterSortByModel.subCategoryName = "eCommerce";
            Navigator.pushNamed(context, ProductSearchScreen.routeName,
                arguments: widget.productsFilterSortByModel);
          },
          fieldViewBuilder:
              (context, searchBoxController, focusNode, onFieldSubmitted) {
            return TextFormField(
              controller: searchBoxController,
              focusNode: focusNode,
              decoration: InputDecoration(
                hintText: widget.hintText,
                prefixIcon: widget.showDrawer
                    ? IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      )
                    : null,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.mic),
                  onPressed: () {
                    _startListening();
                    print('Voice input activated!');
                  },
                ),
              ),
              onFieldSubmitted: (text) async {
                widget.productsFilterSortByModel.productNameSearchTerm = text;
                widget.productsFilterSortByModel.subCategoryName = "eCommerce";
                Navigator.pushNamed(context, ProductSearchScreen.routeName,
                    arguments: widget.productsFilterSortByModel);
              },
              onChanged: (text) async {
                if (text.length % 2 == 0) {
                  //--TODO--
                  //if available items in the list < 2, call API again to get next page of data from graph.
                  //widget.productsFilterSortByModel.productNameSearchTerm = text;
                  //widget.productSearchProvider
                  //    .getFilterdProducts(widget.productsFilterSortByModel);

                  //final productCubit = getProductCubit(context);
                  //productCubit.getProductByName(state, text);
                }
                // Dynamically update suggestions based on user input
              },
            );
          },
        );
      } else {
        return SizedBox.shrink();
      }
    });
  }

  void _startListening() async {
    if (!speech.isListening) {
      bool available = await speech.initialize(
        onStatus: (status) {
          print('Speech recognition status: $status');
        },
        onError: (errorNotification) {
          print('Speech recognition error: $errorNotification');
        },
      );

      if (available) {
        speech.listen(
          onResult: (result) {
            if (result.finalResult) {
              setState(() {
                widget.searchBoxController.text = result.recognizedWords;
              });
            }
            widget.searchBoxController.selection = TextSelection.fromPosition(
              TextPosition(offset: widget.searchBoxController.text.length),
            );
          },
        );
      }
    } else {
      speech.stop();
    }
  }
}
