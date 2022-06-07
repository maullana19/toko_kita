import 'package:flutter/material.dart';
import 'package:flutter_lans/helpers/api.dart';
import 'package:flutter_lans/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../helpers/api_url.dart';

class MemberBloc {
  static var listMembers;

  get length => null;

  get userStream => null;

  static Future<String> getUserData() async {
    String apiUrl = ApiUrl.dataMember;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    return jsonObj['nama'];
  }

  static Future<List<User>> getAllDataUser() async {
    String apiUrl = ApiUrl.dataMember;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<User> users = [];

    for (int i = 0; i < jsonObj.length; i++) {
      User user = User.fromJson(jsonObj[i]);
      users.add(user);
    }
    return users;
  }
}