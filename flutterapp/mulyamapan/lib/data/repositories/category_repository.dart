import 'package:mulyankan/core/graphql.dart';
import 'package:mulyankan/data/models/category/category_model.dart';

class CategoryRepository {
  Future<List<CategoryModel>> getCategories() async {
    //print("Category repository called");
    final query = '''
      query{
        categories{
          id
          categoryName
          categoryDescription
        }
      }
    ''';
    //print("graphQL Query :-" + query);
    try {
      final result = await GraphQLConfig.performQuery(query);
      //print(result);
      final _categories = result.data?['categories'];
      if (_categories == null) {
        throw "Categories not found !";
      }

      return (_categories as List<dynamic>)
          .map((json) => CategoryModel.fromJson(json))
          .toList();
    } catch (error) {
      print("error occured while fetching categories" + error.toString());
      throw error;
    }
  }
}
