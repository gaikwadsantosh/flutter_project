import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mulyankan/data/models/subcategory/budget_range_model.dart';
import 'package:mulyankan/data/repositories/subcategory_repository.dart';
import 'package:mulyankan/logic/cubits/subcategory_cubit/sub_category_state.dart';

class SubCategoryCubit extends Cubit<SubCategoryState> {
  SubCategoryCubit() : super(SubCategoryInitialState()) {
    _initialize();
  }
  final _subCategoryRepository = SubcategoryRepository();

  void _initialize() async {
    try {
      List<SubcategoryModel> subCategories =
          await _subCategoryRepository.getSubCategoryBudgetRanges();
      emit(SubCategoryLoadedState(subCategories));
    } catch (ex) {
      emit(SubCategoryErrorState(ex.toString(), state.subCategories));
    }
  }
}
