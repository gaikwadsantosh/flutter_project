import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mulyankan/data/models/product/product_model.dart';
import 'package:mulyankan/data/models/product/product_sort_by_model.dart';
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
      final products = await _productRepository.getProducts(null);
      final productsortBy = await _productRepository.getProductSortBy();
      emit(ProductLoadedState(products, products, productsortBy));
    } catch (ex) {
      emit(ProductErrorState(
          ex.toString(), state.products, state.products, state.productSortBy));
    }
  }

  void getProductByName(ProductState state, String productName) async {
    emit(ProductLoadedState(
        state.products, state.productsSearched, state.productSortBy));
    try {
      final productsSearched =
          await _productRepository.getProductByName(productName);
      emit(ProductLoadedState(
          state.products, productsSearched, state.productSortBy));
    } catch (ex) {
      emit(ProductErrorState(ex.toString(), state.products,
          state.productsSearched, state.productSortBy));
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

  void getProductSortBy(ProductState state) async {
    emit(ProductLoadedState(
        state.products, state.productsSearched, state.productSortBy));
    try {
      final productsSortBy = await _productRepository.getProductSortBy();
      emit(ProductLoadedState(
          state.products, state.productsSearched, state.productSortBy));
    } catch (ex) {
      emit(ProductErrorState(ex.toString(), state.products,
          state.productsSearched, state.productSortBy));
    }
  }

  void getSortedProducts(ProductsSortByModel? productsSortByModel) async {
    emit(ProductLoadingState(
        state.products, state.productsSearched, state.productSortBy));
    try {
      final sortedProducts =
          await _productRepository.getProducts(productsSortByModel);
      emit(ProductLoadedState(
          state.products, sortedProducts, state.productSortBy));
    } catch (ex) {
      emit(ProductErrorState(ex.toString(), state.products,
          state.productsSearched, state.productSortBy));
    }
  }

  void getFilteredProducts(ProductModel? productModel) async {
    emit(ProductLoadingState(
        state.products, state.productsSearched, state.productSortBy));
    try {
      final sortedProducts = await _productRepository.getProducts(productModel);
      emit(ProductLoadedState(
          state.products, sortedProducts, state.productSortBy));
    } catch (ex) {
      emit(ProductErrorState(ex.toString(), state.products,
          state.productsSearched, state.productSortBy));
    }
  }
}
