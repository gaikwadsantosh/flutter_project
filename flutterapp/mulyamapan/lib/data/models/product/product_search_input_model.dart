class ProductSearchInputModel {
  String? productName;
  String? categoryName;
  String? subCategoryName;
  String? searchType; // Today's Deal or Standard Search

  ProductSearchInputModel(
      {this.productName,
      this.categoryName,
      this.subCategoryName,
      this.searchType});

  ProductSearchInputModel.fromJson(Map<String, dynamic> json) {
    productName = json['productName'];
    categoryName = json['categoryName'];
    subCategoryName = json['subCategoryName'];
    searchType = json['searchType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productName'] = this.productName;
    data['categoryName'] = this.categoryName;
    data['subCategoryName'] = this.subCategoryName;
    data['searchType'] = this.searchType;
    return data;
  }
}
