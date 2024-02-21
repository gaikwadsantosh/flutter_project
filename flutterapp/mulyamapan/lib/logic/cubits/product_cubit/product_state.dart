import 'package:mulyankan/data/models/product/product_model.dart';
import 'package:mulyankan/data/models/product/products_sort_flitered_by_model.dart';

abstract class ProductState {
  final List<ProductModel> products;
  final List<ProductModel> productsSearched;
  final List<ProductsFilterSortByModel> productSortBy;
  ProductState(this.products, this.productsSearched, this.productSortBy);
}

class ProductInitialState extends ProductState {
  ProductInitialState() : super([], [], []);
}

class ProductLoadingState extends ProductState {
  ProductLoadingState(
      super.products, super.productsSearched, super.productSortBy);
}

class ProductLoadedState extends ProductState {
  ProductLoadedState(
      super.products, super.productsSearched, super.productSortBy);
}

class ProductErrorState extends ProductState {
  final String message;
  ProductErrorState(this.message, super.products, super.productsSearched,
      super.productSortBy);
}

class ProductSearchingState extends ProductState {
  ProductSearchingState(
      super.products, super.productsSearched, super.productSortBy);
}

class ProductSearchedState extends ProductState {
  ProductSearchedState(
      super.products, super.productsSearched, super.productSortBy);
}

class ProductSearchLoadingState extends ProductState {
  ProductSearchLoadingState(
      super.products, super.productsSearched, super.productSortBy);
}
