import 'package:mulyankan/data/models/product/product_model.dart';

abstract class ProductState {
  final List<ProductModel> products;
  final List<ProductModel> productsSearched;
  ProductState(this.products, this.productsSearched);
}

class ProductInitialState extends ProductState {
  ProductInitialState() : super([], []);
}

class ProductLoadingState extends ProductState {
  ProductLoadingState(super.products, super.productsSearched);
}

class ProductLoadedState extends ProductState {
  ProductLoadedState(super.products, super.productsSearched);
}

class ProductErrorState extends ProductState {
  final String message;
  ProductErrorState(this.message, super.products, super.productsSearched);
}

class ProductSearchingState extends ProductState {
  ProductSearchingState(super.products, super.productsSearched);
}

class ProductSearchedState extends ProductState {
  ProductSearchedState(super.products, super.productsSearched);
}

class ProductSearchLoadingState extends ProductState {
  ProductSearchLoadingState(super.products, super.productsSearched);
}
