import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mulyankan/data/models/product/product_model.dart';
import 'package:mulyankan/data/models/product/product_search_input_model.dart';
import 'package:mulyankan/data/models/product/product_sort_by_model.dart';
import 'package:mulyankan/logic/cubits/product_cubit/product_cubit.dart';

class ProductSearchProvider with ChangeNotifier {
  final BuildContext context;
  //final ProductsSortByModel _productsSortByModel;
  //ProductsSortByModel get selectedProductsSortByModel => _productsSortByModel;
  String _resultText = "";

  ProductSearchProvider(this.context) {}

  void getSortedProducts(ProductsSortByModel? productsSortByModel) {
    try {
      BlocProvider.of<ProductCubit>(context)
          .getSortedProducts(productsSortByModel);
      _resultText = " successfully got sorted products !!";
      notifyListeners();
    } catch (e) {
      _resultText = "Error while getting sorted products ${e.toString()}";
      notifyListeners();
      rethrow;
    }
  }

  void getFilterdProducts(ProductModel? productModel) {
    try {
      BlocProvider.of<ProductCubit>(context).getFilteredProducts(productModel);
      _resultText = " ";
      notifyListeners();
    } catch (e) {
      _resultText = "Error while getting filtered products ${e.toString()}";
      notifyListeners();
      rethrow;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
