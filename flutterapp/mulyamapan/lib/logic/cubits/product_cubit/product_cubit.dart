import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mulyankan/data/repositories/product_repository.dart';
import 'package:mulyankan/logic/cubits/product_cubit/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitialState()) {}

  void fetchInitialData() async {
    await _initalize();
  }

  final _productRepository = ProductRepository();

  Future<void> _initalize() async {
    emit(ProductLoadingState(state.products, state.products));
    try {
      final products = await _productRepository.getProducts();
      emit(ProductLoadedState(products, products));
    } catch (ex) {
      emit(ProductErrorState(ex.toString(), state.products, state.products));
    }
  }

  void getProductByName(ProductState state, String productName) async {
    emit(ProductLoadedState(state.products, state.productsSearched));
    try {
      final productsSearched =
          await _productRepository.getProductByName(productName);
      emit(ProductLoadedState(state.products, productsSearched));
    } catch (ex) {
      emit(ProductErrorState(
          ex.toString(), state.products, state.productsSearched));
    }
  }

  void resetSearchedProducts() async {
    try {
      emit(ProductLoadedState(state.products, []));
    } catch (ex) {
      emit(ProductErrorState(
          ex.toString(), state.products, state.productsSearched));
    }
  }
}
