import 'dart:js_util';
import 'package:flutter/material.dart';
import 'package:flutter_lans/helpers/user_info.dart';
import 'package:flutter_lans/blocs/logout_bloc.dart';
import 'package:flutter_lans/blocs/produk_bloc.dart';
import 'package:flutter_lans/models/produk.dart';
import 'package:flutter_lans/ui/login_page.dart';
import 'package:flutter_lans/ui/produk_detail.dart';
import 'package:flutter_lans/ui/produk_form.dart';
import 'package:flutter_lans/ui/produk_page.dart';
import 'package:flutter_lans/ui/profile_page.dart';
import 'package:http/http.dart' as http;

// create list member
class MemberPage extends StatefulWidget {
  const MemberPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  final LogoutBloc _logoutBloc = LogoutBloc();
  final ProdukBloc _produkBloc = ProdukBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // create appbar back
      appBar: AppBar(
        title: const Text('Member Data'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('Member' + index.toString()),
            leading: Icon(Icons.person),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilesPages()));
            },
          );
        },
      ),
    );
  }
}
