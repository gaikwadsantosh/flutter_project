import 'package:flutter/cupertino.dart';

class ProductsFilterSortByModel extends ChangeNotifier {
  String? id;
  String? sortby; //field
  String? sortbyField; //field
  String? sortOrder; //asc desc
  String? subCategoryId;
  String? subCategoryName;
  double? averageReview;
  double? priceFrom;
  double? priceTo;
  bool? featured = false;
  bool? newArrivals = false;
  bool? payOnDelivery = false;
  String? productNameSearchTerm;

  ProductsFilterSortByModel({
    this.sortby,
    this.sortbyField,
    this.sortOrder,
    this.subCategoryId,
    this.subCategoryName,
    this.averageReview,
    this.priceFrom,
    this.priceTo,
    this.featured,
    this.newArrivals,
    this.payOnDelivery,
    this.productNameSearchTerm,
  });

  ProductsFilterSortByModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sortby = json['sortby'];
    sortbyField = json['sortbyField'];
    sortOrder = json['sortOrder'];
    if (json.containsKey('priceFrom') && json['priceFrom'] != null) {
      if (json['priceFrom'] is int) {
        priceFrom = (json['priceFrom'] as int).toDouble();
      } else if (json['priceFrom'] is double) {
        priceFrom = json['priceFrom'];
      } else {
        // Handle other cases if needed
        print('Unexpected type for price: ${json['priceFrom']}');
      }
    }
    if (json.containsKey('priceTo') && json['priceTo'] != null) {
      // Check the type of the value and convert it to 'double'
      if (json['priceTo'] is int) {
        priceFrom = (json['priceTo'] as int).toDouble();
      } else if (json['priceTo'] is double) {
        priceFrom = json['priceTo'];
      } else {
        // Handle other cases if needed
        print('Unexpected type for price: ${json['priceTo']}');
      }
    }
    subCategoryId = json['subCategoryId'];
    subCategoryName = json['subCategoryName'];
    averageReview = json['averageReview'];
    //payOnDelivery = json['payOnDelivery'];
    featured = json['featured'];
    newArrivals = json['newArrivals'];
    payOnDelivery = json['payOnDelivery'];
    productNameSearchTerm = json['productNameSearchTerm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sortby'] = this.sortby;
    data['sortbyField'] = this.sortbyField;
    data['sortOrder'] = this.sortOrder;
    data['priceFrom'] = this.priceFrom;
    data['priceTo'] = this.priceTo;
    data['subCategoryId'] = this.subCategoryId;
    data['subCategoryName'] = this.subCategoryName;
    data['averageReview'] = this.averageReview;
    data['payOnDelivery'] = this.payOnDelivery;
    data['featured'] = this.featured;
    data['newArrivals'] = this.newArrivals;
    data['productNameSearchTerm'] = this.productNameSearchTerm;
    return data;
  }
}
