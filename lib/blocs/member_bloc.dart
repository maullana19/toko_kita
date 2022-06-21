import 'package:toko_kita/helpers/api.dart';
import 'package:toko_kita/models/user.dart';
import 'dart:convert';
import '../helpers/api_url.dart';

class MemberBloc {
  // ignore: prefer_typing_uninitialized_variables
  static var listMembers;

  get length => null;

  get userStream => null;

  static Future<User> getUserData(int id) async {
    String apiUrl = ApiUrl.getUserData(id);
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    User user = User.fromJson(jsonObj);
    return user;
  }

  static Future<List<User>> getAllDataUser() async {
    String apiUrl = ApiUrl.listUsers;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listProduk = (jsonObj as Map<String, dynamic>)['data'];
    List<User> users = [];
    for (int i = 0; i < listProduk.length; i++) {
      users.add(User.list(listProduk[i]));
    }
    return users;
  }
}
