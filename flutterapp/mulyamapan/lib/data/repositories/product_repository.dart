import 'dart:math';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mulyankan/core/graphql.dart';
import 'package:mulyankan/data/models/product/product_model.dart';

class ProductRepository {
  Future<List<ProductModel>> getProducts() async {
    //print("Product repository called");
    const query = '''
      query{
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
    ''';
    //print("graphQL Query :-" + query);
    try {
      final result = await GraphQLConfig.performQuery(query);
      //print(result);
      final _products = result.data?['products'];
      if (_products == null) {
        throw "products not found !";
      }

      return (_products as List<dynamic>)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (error) {
      print("error occured while fetching products" + error.toString());
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
      print("error occured while fetching products" + error.toString());
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
      print("error occured while fetching products" + error.toString());
      throw error;
    }
  }
}
