class ProductSearchInputModel {
  String? productName;
  String? categoryName;
  String? subCategoryName;
  String? searchType; // Today's Deal or Standard Search
  int? fromRange;
  int? toRange;
  String? sortOrder;

  ProductSearchInputModel({
    this.productName,
    this.categoryName,
    this.subCategoryName,
    this.searchType,
    this.fromRange,
    this.toRange,
    this.sortOrder,
  });

  ProductSearchInputModel.fromJson(Map<String, dynamic> json) {
    productName = json['productName'];
    categoryName = json['categoryName'];
    subCategoryName = json['subCategoryName'];
    searchType = json['searchType'];
    fromRange = json['fromRange'];
    toRange = json['toRange'];
    sortOrder = json['sortOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productName'] = this.productName;
    data['categoryName'] = this.categoryName;
    data['subCategoryName'] = this.subCategoryName;
    data['searchType'] = this.searchType;
    data['fromRange'] = this.fromRange;
    data['toRange'] = this.toRange;
    data['sortOrder'] = this.sortOrder;
    return data;
  }
}
