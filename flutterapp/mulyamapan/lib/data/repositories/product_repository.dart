import 'package:mulyankan/core/graphql.dart';
import 'package:mulyankan/data/models/product/product_model.dart';
import 'package:mulyankan/data/models/product/products_sort_flitered_by_model.dart';

class ProductRepository {
  Future<List<ProductModel>> getFilteredSortedProducts(
      ProductsFilterSortByModel? productsFilterSortByModel) async {
    final String query = buildProductsQuery(productsFilterSortByModel);

    final Map<String, dynamic> variables =
        buildProductsVariables(productsFilterSortByModel);

    print(query);
    print(variables);

    try {
      final result =
          await GraphQLConfig.performQuery(query, variables: variables);

      final _products = result.data?['products'];

      if (_products == null) {
        return [];
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
      ProductsFilterSortByModel? productsFilterSortByModel) async {
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
      'sortbyField': productsFilterSortByModel?.sortbyField,
      'AscDesc': productsFilterSortByModel?.sortOrder,
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

  String buildProductsQuery(
      ProductsFilterSortByModel? productsFilterSortByModel) {
    final StringBuffer query = StringBuffer('''
      query(
        \$sortbyField: String!, 
        \$AscDesc: SortOrder!, 
        ${productsFilterSortByModel?.averageReview != null ? '\$averageReview: Float!,' : ''}
        ${productsFilterSortByModel?.subCategoryId != null ? '\$subCategoryId: String!,' : ''}
        ${productsFilterSortByModel?.priceFrom != null ? '\$priceFrom: Float!,' : ''}
        ${productsFilterSortByModel?.priceTo != null ? '\$priceTo: Float!,' : ''}
        ${productsFilterSortByModel?.newArrivals == true ? '\$newArrivals: Boolean!,' : ''}
        ${productsFilterSortByModel?.featured == true ? '\$featured: Boolean!,' : ''}
        ${productsFilterSortByModel?.payOnDelivery == true ? '\$payOnDelivery: Boolean!,' : ''}
        ${productsFilterSortByModel?.productNameSearchTerm != null ? '\$productNameSearchTerm: String!,' : ''}
      ) {
        products(
          sortBy: { sortbyField: \$sortbyField, AscDesc: \$AscDesc }
          filterBy: {
            ${productsFilterSortByModel?.averageReview != null ? 'averageReview: \$averageReview,' : ''}
            ${productsFilterSortByModel?.subCategoryId != null ? 'subCategoryId: \$subCategoryId,' : ''}
            ${productsFilterSortByModel?.priceFrom != null ? 'priceFrom: \$priceFrom,' : ''}
            ${productsFilterSortByModel?.priceTo != null ? 'priceTo: \$priceTo,' : ''}
            ${productsFilterSortByModel?.newArrivals == true ? 'newArrivals: \$newArrivals,' : ''}
            ${productsFilterSortByModel?.featured == true ? 'featured: \$featured,' : ''}
            ${productsFilterSortByModel?.payOnDelivery == true ? 'payOnDelivery: \$payOnDelivery,' : ''}
            ${productsFilterSortByModel?.productNameSearchTerm != null ? 'productNameSearchTerm: \$productNameSearchTerm,' : ''}
          }
        ) {
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
          averageReview
          payOnDelivery
        }
      }
    ''');

    return query.toString();
  }

  Map<String, dynamic> buildProductsVariables(
      ProductsFilterSortByModel? productsFilterSortByModel) {
    final Map<String, dynamic> variables = {
      'sortbyField': productsFilterSortByModel?.sortbyField ?? 'productName',
      'AscDesc': productsFilterSortByModel?.sortOrder ?? 'ASC',
    };

    if (productsFilterSortByModel != null) {
      if (productsFilterSortByModel.averageReview != null) {
        variables['averageReview'] = productsFilterSortByModel.averageReview;
      }

      if (productsFilterSortByModel.subCategoryId != null) {
        variables['subCategoryId'] = productsFilterSortByModel.subCategoryId;
      }

      if (productsFilterSortByModel.priceFrom != null) {
        variables['priceFrom'] = productsFilterSortByModel.priceFrom;
      }

      if (productsFilterSortByModel.priceTo != null) {
        variables['priceTo'] = productsFilterSortByModel.priceTo;
      }

      if (productsFilterSortByModel.newArrivals == true) {
        variables['newArrivals'] = productsFilterSortByModel.newArrivals;
      }

      if (productsFilterSortByModel.featured == true) {
        variables['featured'] = productsFilterSortByModel.featured;
      }

      if (productsFilterSortByModel.payOnDelivery == true) {
        variables['payOnDelivery'] = productsFilterSortByModel.payOnDelivery;
      }

      if (productsFilterSortByModel.productNameSearchTerm != null) {
        variables['productNameSearchTerm'] =
            productsFilterSortByModel.productNameSearchTerm;
      }
    }

    return variables;
  }

  Future<List<ProductsFilterSortByModel>> getProductSortBy() async {
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
          .map((json) => ProductsFilterSortByModel.fromJson(json))
          .toList();
    } catch (error) {
      print(
          "error occured while fetching productsSortBy :- " + error.toString());
      throw error;
    }
  }
}
