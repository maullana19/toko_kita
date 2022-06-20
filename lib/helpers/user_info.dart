import 'package:shared_preferences/shared_preferences.dart';

class UserInfo {
  Future setToken(String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString("token", value);
  }

  Future<String?> getToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token");
  }

  Future setRole(String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString("role", value);
  }
  
  Future<String?> getRole() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("role");
  }

  Future setUserID(int value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setInt("userID", value);
  }

  Future<int?> getUserID() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt("userID");
  }

  Future logout() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}
