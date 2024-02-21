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
    if (json.containsKey('price') && json['price'] != null) {
      // Check the type of the value and convert it to 'double'
      if (json['price'] is int) {
        price = (json['price'] as int).toDouble();
      } else if (json['price'] is double) {
        price = json['price'];
      } else {
        // Handle other cases if needed
        print('Unexpected type for price: ${json['price']}');
      }
    }
    newArrivals = json['newArrivals'];

    if (json['averageReview'] is int) {
      averageReview = (json['averageReview'] as int).toDouble();
    } else if (json['averageReview'] is double) {
      averageReview = json['averageReview'];
    }
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
