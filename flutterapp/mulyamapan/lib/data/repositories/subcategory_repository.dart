import 'package:mulyankan/core/graphql.dart';
import 'package:mulyankan/data/models/subcategory/budget_range_model.dart';

class SubcategoryRepository {
  Future<List<SubcategoryModel>> getSubCategoryBudgetRanges() async {
    //print("Category repository called");
    final query = '''
      query{
        subcategories{
          id
          subcategoryName
          budgetRanges{
            fromRange
            toRange      
          }
        }
      }
    ''';
    //print("graphQL Query :-" + query);
    try {
      final result = await GraphQLConfig.performQuery(query);
      //print(result);
      final _subCategories = result.data?['subcategories'];
      if (_subCategories == null) {
        throw "Subcategories not found !";
      }

      return (_subCategories as List<dynamic>)
          .map((json) => SubcategoryModel.fromJson(json))
          .toList();
    } catch (error) {
      print("error occured while fetching getSubCategoryBudgetRanges:- " +
          error.toString());
      throw error;
    }
  }
}
