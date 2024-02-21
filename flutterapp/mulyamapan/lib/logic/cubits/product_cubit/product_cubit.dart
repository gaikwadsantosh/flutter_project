import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mulyankan/data/models/product/product_model.dart';
import 'package:mulyankan/data/models/product/products_sort_flitered_by_model.dart';
import 'package:mulyankan/data/repositories/product_repository.dart';
import 'package:mulyankan/logic/cubits/product_cubit/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitialState()) {}

  void fetchInitialData() async {
    await _initalize();
  }

  final _productRepository = ProductRepository();

  Future<void> _initalize() async {
    emit(ProductLoadingState(
        state.products, state.products, state.productSortBy));
    try {
      final products = await _productRepository.getFilteredSortedProducts(null);
      final productsortBy = await _productRepository.getProductSortBy();
      emit(ProductLoadedState(products, products, productsortBy));
    } catch (ex) {
      emit(ProductErrorState(
          ex.toString(), state.products, state.products, state.productSortBy));
    }
  }

  void resetSearchedProducts() async {
    try {
      emit(ProductLoadedState(state.products, [], state.productSortBy));
    } catch (ex) {
      emit(ProductErrorState(ex.toString(), state.products,
          state.productsSearched, state.productSortBy));
    }
  }

  void getFilteredSortedProducts(
      ProductsFilterSortByModel? productsFilterSortByModel) async {
    emit(ProductLoadingState(
        state.products, state.productsSearched, state.productSortBy));
    try {
      final productsSearched = await _productRepository
          .getFilteredSortedProducts(productsFilterSortByModel);
      emit(ProductLoadedState(
          state.products.isEmpty ? productsSearched : state.products,
          productsSearched,
          state.productSortBy.isEmpty
              ? await _productRepository.getProductSortBy()
              : state.productSortBy));
    } catch (ex) {
      emit(ProductErrorState(ex.toString(), state.products,
          state.productsSearched, state.productSortBy));
    }
  }
}
