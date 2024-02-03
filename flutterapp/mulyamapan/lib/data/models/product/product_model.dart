class ProductModel {
  String? id;
  String? productName;
  String? productUrl;
  String? imageUrl;
  String? priceDiscount;
  String? dealMessage;
  String? subCategoryId;
  bool? featured;
  double? price;
  bool? newArrivals;
  double? averageReview;

  ProductModel(
      {this.id,
      this.productName,
      this.productUrl,
      this.imageUrl,
      this.priceDiscount,
      this.dealMessage,
      this.subCategoryId});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['productName'];
    productUrl = json['ProductUrl'];
    imageUrl = json['ImageUrl'];
    priceDiscount = json['PriceDiscount'];
    dealMessage = json['DealMessage'];
    subCategoryId = json['subCategoryId'];
    featured = json['featured'];
    price = json['price'].toDouble();
    newArrivals = json['newArrivals'];
    averageReview = json['averageReview'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productName'] = this.productName;
    data['ProductUrl'] = this.productUrl;
    data['ImageUrl'] = this.imageUrl;
    data['PriceDiscount'] = this.priceDiscount;
    data['DealMessage'] = this.dealMessage;
    data['subCategoryId'] = this.subCategoryId;
    data['featured'] = this.featured;
    data['price'] = this.price;
    data['newArrivals'] = this.newArrivals;
    data['averageReview'] = this.averageReview;
    return data;
  }
}
