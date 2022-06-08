import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:toko_kita/helpers/user_info.dart';
import 'package:toko_kita/ui/login_page.dart';
import 'package:toko_kita/ui/produk_page.dart';
import 'package:toko_kita/ui/profile_page.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import './frontend/ui/login_user.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = const CircularProgressIndicator();

  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    var token = await UserInfo().getToken();
    if (token != null) {
      setState(() {
        page = const ProdukPage();
      });
    } else {
      setState(() {
        page = const LoginPage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toko Kita',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      builder: EasyLoading.init(),
    );
  }
}
