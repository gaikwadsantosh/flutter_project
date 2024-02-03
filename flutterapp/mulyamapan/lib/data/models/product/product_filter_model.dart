class ProductFilterModel {
  String? subCategoryId;
  double? averageReview;
  double? priceRange;
  bool? payOnDelivery;

  ProductFilterModel({
    this.subCategoryId,
    this.averageReview,
    this.priceRange,
    this.payOnDelivery,
  });

  ProductFilterModel.fromJson(Map<String, dynamic> json) {
    priceRange = json['priceRange'].toDouble();
    subCategoryId = json['subCategoryId'];
    averageReview = json['averageReview'];
    payOnDelivery = json['payOnDelivery'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PriceRange'] = this.priceRange;
    data['subCategoryId'] = this.subCategoryId;
    data['averageReview'] = this.averageReview;
    data['payOnDelivery'] = this.payOnDelivery;
    return data;
  }
}
