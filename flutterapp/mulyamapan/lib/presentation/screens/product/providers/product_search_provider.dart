import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mulyankan/data/models/product/products_sort_flitered_by_model.dart';
import 'package:mulyankan/logic/cubits/product_cubit/product_cubit.dart';
import 'package:provider/provider.dart';

class ProductSearchProvider with ChangeNotifier {
  final BuildContext context;
  String _resultText = "";

  ProductSearchProvider(this.context) {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      //getFilteredSortedProducts(null);
      //notifyListeners();
    } catch (error) {
      // Handle error
    }
  }

  void getFilteredSortedProducts(
      ProductsFilterSortByModel? productsFilterSortByModel) {
    try {
      BlocProvider.of<ProductCubit>(context)
          .getFilteredSortedProducts(productsFilterSortByModel);
      _resultText = " ";
    } catch (e) {
      _resultText =
          "Error while getting filtered sorted products ${e.toString()}";
      //notifyListeners();
      rethrow;
    }
  }

// Create a provider for ProductsFilterSortByModel
  final productsFilterSortByModelProvider =
      ChangeNotifierProvider<ProductsFilterSortByModel>(
    create: (context) =>
        ProductsFilterSortByModel(), // Provide the required 'create' argument
  );

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
