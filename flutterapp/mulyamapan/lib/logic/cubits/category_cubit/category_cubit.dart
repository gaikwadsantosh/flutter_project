import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mulyankan/data/models/category/category_model.dart';
import 'package:mulyankan/data/repositories/category_repository.dart';
import 'package:mulyankan/logic/cubits/category_cubit/category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitialState()) {
    _initialize();
  }
  final _categoryRepository = CategoryRepository();

  void _initialize() async {
    try {
      List<CategoryModel> categories =
          await _categoryRepository.getCategories();
      emit(CategoryLoadedState(categories));
    } catch (ex) {
      emit(CategoryErrorState(ex.toString(), state.categories));
    }
  }
}
