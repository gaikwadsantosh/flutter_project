import 'package:mulyankan/core/graphql.dart';
import 'package:mulyankan/data/models/product/product_filter_model.dart';
import 'package:mulyankan/data/models/product/product_model.dart';
import 'package:mulyankan/data/models/product/product_sort_by_model.dart';

class ProductRepository {
  Future<List<ProductModel>> getProducts(
      ProductsSortByModel? productsSortByModel) async {
    //print("Product repository called");
    const query = '''
      query(\$sortbyField:String!, \$AscDesc:SortOrder! ){
        products(sortBy: { sortbyField: \$sortbyField, AscDesc:\$AscDesc}) {
          id
          productName
          ProductUrl
          ImageUrl
          PriceDiscount
          DealMessage
          subCategoryId    
          price
          featured
          newArrivals
        }
      }
    ''';

    Map<String, dynamic>? variables = productsSortByModel != null
        ? {
            'sortbyField': productsSortByModel?.sortbyField,
            'AscDesc': productsSortByModel?.sortOrder,
          }
        : {
            'sortbyField': 'productName',
            'AscDesc': 'ASC',
          };

    //print("graphQL Query :-" + query);
    try {
      //final result = await GraphQLConfig.performQuery(query);
      final result =
          await GraphQLConfig.performQuery(query, variables: variables);

      //print(result);
      final _products = result.data?['products'];
      if (_products == null) {
        throw "products not found !";
      }

      return (_products as List<dynamic>)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (error) {
      print("error occured while fetching products :- " + error.toString());
      throw error;
    }
  }

  Future<List<ProductModel>> getFilteredProducts(
      ProductFilterModel? productFilterModel) async {
    const query = '''
      query(\$sortbyField:String!, \$AscDesc:SortOrder! ){
        products(sortBy: { sortbyField: \$sortbyField, AscDesc:\$AscDesc}) {
          id
          productName
          ProductUrl
          ImageUrl
          PriceDiscount
          DealMessage
          subCategoryId    
          price
          featured
          newArrivals
        }
      }
    ''';

    Map<String, dynamic>? variables = {
      'xxxx': productFilterModel?.price,
      'AscDesc': productFilterModel?.sortOrder,
    };

    //print("graphQL Query :-" + query);
    try {
      //final result = await GraphQLConfig.performQuery(query);
      final result =
          await GraphQLConfig.performQuery(query, variables: variables);

      //print(result);
      final _products = result.data?['products'];
      if (_products == null) {
        throw "products not found !";
      }

      return (_products as List<dynamic>)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (error) {
      print("error occured while fetching products :- " + error.toString());
      throw error;
    }
  }

  Future<List<ProductModel>> getProductBySubCategory(
      String subcategoryID) async {
    //print("Product repository called");
    final query = '''
      query{
        subcategory(id:"$subcategoryID"){
          products{
            id
            productName
            ProductUrl
            ImageUrl
            PriceDiscount
            DealMessage
            subCategoryId
          }
        }
      }
    ''';
    //print("graphQL Query :-" + query);
    try {
      final result = await GraphQLConfig.performQuery(query);
      //print(result);
      final _products = result.data?["subcategory"]['products'];
      if (_products == null) {
        throw "products not found !";
      }

      return (_products as List<dynamic>)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (error) {
      print("error occured while fetching getProductsBySubCategories :- " +
          error.toString());
      throw error;
    }
  }

  Future<List<ProductModel>> getProductByName(String productName) async {
    //print("Product repository called");
    final query = '''
      query{
        productsByName(productName:"$productName"){
          id
          productName
        }
      }
    ''';
    //print("graphQL Query :-" + query);
    try {
      final result = await GraphQLConfig.performQuery(query);
      //print(result);
      final _products = result.data?['productsByName'];
      if (_products == null) {
        throw "products not found !";
      }

      return (_products as List<dynamic>)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (error) {
      print(
          "error occured while fetching productsByName :- " + error.toString());
      throw error;
    }
  }

  Future<List<ProductsSortByModel>> getProductSortBy() async {
    final query = '''
      query{
        productsSortBy{
          id
          sortby
          sortbyField
          sortOrder
        }
      }
    ''';
    //print("graphQL Query :-" + query);
    try {
      final result = await GraphQLConfig.performQuery(query);
      //print(result);
      final _productSortBy = result.data?['productsSortBy'];
      if (_productSortBy == null) {
        throw "product sort by not found !";
      }

      return (_productSortBy as List<dynamic>)
          .map((json) => ProductsSortByModel.fromJson(json))
          .toList();
    } catch (error) {
      print(
          "error occured while fetching productsSortBy :- " + error.toString());
      throw error;
    }
  }
}
