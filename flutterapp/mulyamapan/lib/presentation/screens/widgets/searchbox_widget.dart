import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mulyankan/data/models/product/product_model.dart';
import 'package:mulyankan/data/models/product/product_search_input_model.dart';
import 'package:mulyankan/logic/cubits/product_cubit/product_cubit.dart';
import 'package:mulyankan/logic/cubits/product_cubit/product_state.dart';
import 'package:mulyankan/presentation/screens/product/product_search_screen.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SearchBoxWidget extends StatefulWidget {
  final String hintText;
  const SearchBoxWidget({super.key, required this.hintText});

  @override
  State<SearchBoxWidget> createState() => _SearchBoxWidgetState();
}

class _SearchBoxWidgetState extends State<SearchBoxWidget> {
  late Autocomplete<ProductModel> textAutoField;
  final TextEditingController textEditingController = TextEditingController();
  final stt.SpeechToText speech = stt.SpeechToText();

  @override
  void initState() {
    super.initState();
    print("called: initState");
    final productCubit = BlocProvider.of<ProductCubit>(context, listen: false);

    if (productCubit.state.products.isEmpty) {
      productCubit.fetchInitialData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
      if (state is ProductLoadedState) {
        if (state.productsSearched == null) return SizedBox.shrink();
        return Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text == '') {
              return const Iterable<String>.empty();
            }
            return state.productsSearched
                .where((product) => product.productName!
                    .toLowerCase()
                    .contains(textEditingValue.text.toLowerCase()))
                .map((product) => product.productName!);
          },
          onSelected: (String selection) {
            print('You just selected $selection');
            Navigator.pushNamed(context, ProductSearchScreen.routeName,
                arguments: ProductSearchInputModel(
                    categoryName: "eCommerce", searchType: "Product List"));
          },
          fieldViewBuilder:
              (context, textEditingController, focusNode, onFieldSubmitted) {
            return TextFormField(
              controller: textEditingController,
              focusNode: focusNode,
              decoration: InputDecoration(
                hintText: widget.hintText,
                suffixIcon: IconButton(
                  icon: Icon(Icons.mic),
                  onPressed: () {
                    _startListening();
                    print('Voice input activated!');
                  },
                ),
              ),
              onFieldSubmitted: (text) async {
                Navigator.pushNamed(context, ProductSearchScreen.routeName,
                    arguments: ProductSearchInputModel(
                        categoryName: "eCommerce", searchType: "Product List"));

                // Trigger lazy loading when the user submits the field
              },
              onChanged: (text) async {
                if (text.length % 2 == 0) {
                  ProductCubit().getProductByName(state, text);
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
                textEditingController.text = result.recognizedWords;
              });
            }
            // Notify the Autocomplete widget of the changes
            textEditingController.selection = TextSelection.fromPosition(
              TextPosition(offset: textEditingController.text.length),
            );
          },
        );
      }
    } else {
      speech.stop();
    }
  }
}
