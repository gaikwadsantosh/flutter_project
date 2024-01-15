import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static Future<void> saveuserDetails(String email, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("email", email);
    await sharedPreferences.setString("password", password);
    //print("user details saved .." + email + password);
  }

  static Future<Map<String, dynamic>> fetchUserDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? email = sharedPreferences.getString("email");
    String? password = sharedPreferences.getString("password");

    return {"email": email, "password": password};
  }

  static Future<void> clear() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}
