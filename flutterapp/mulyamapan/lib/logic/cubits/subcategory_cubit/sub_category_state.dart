import 'package:mulyankan/data/models/subcategory/budget_range_model.dart';

abstract class SubCategoryState {
  final List<SubcategoryModel> subCategories;
  SubCategoryState(this.subCategories);
}

class SubCategoryInitialState extends SubCategoryState {
  SubCategoryInitialState() : super([]);
}

class SubCategoryLoadingState extends SubCategoryState {
  SubCategoryLoadingState(super.subCategories);
}

class SubCategoryLoadedState extends SubCategoryState {
  SubCategoryLoadedState(super.subCategories);
}

class SubCategoryErrorState extends SubCategoryState {
  final String message;
  SubCategoryErrorState(this.message, super.subCategories);
}
