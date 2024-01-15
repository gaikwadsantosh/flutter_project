class UserModel {
  String? id;
  String? fullName;
  String? password;
  String? email;
  String? phoneNumber;
  String? address;
  String? city;
  String? state;

  UserModel(
      {this.id,
      this.fullName,
      this.password,
      this.email,
      this.phoneNumber,
      this.address,
      this.city,
      this.state});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    password = json['password'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['password'] = this.password;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    return data;
  }
}
