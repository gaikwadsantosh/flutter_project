class ProductsSortByModel {
  String? id;
  String? sortby; //field
  String? sortbyField; //field
  String? sortOrder; //asc desc

  ProductsSortByModel({this.sortbyField, this.sortOrder});

  ProductsSortByModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sortby = json['sortby'];
    sortbyField = json['sortbyField'];
    sortOrder = json['sortOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sortby'] = this.sortby;
    data['sortbyField'] = this.sortbyField;
    data['sortOrder'] = this.sortOrder;
    return data;
  }
}
