import 'dart:js_util';
import 'package:flutter/material.dart';
import 'package:toko_kita/helpers/user_info.dart';
import 'package:toko_kita/blocs/logout_bloc.dart';
import 'package:toko_kita/blocs/produk_bloc.dart';
import 'package:toko_kita/blocs/member_bloc.dart';
import 'package:toko_kita/models/produk.dart';
import 'package:toko_kita/models/user.dart';
import 'package:toko_kita/ui/login_page.dart';
import 'package:toko_kita/ui/produk_detail.dart';
import 'package:toko_kita/ui/produk_form.dart';
import 'package:toko_kita/ui/produk_page.dart';
import 'package:toko_kita/ui/profile_page.dart';
import 'package:http/http.dart' as http;

class MemberPage extends StatefulWidget {
  const MemberPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  final LogoutBloc _logoutBloc = LogoutBloc();
  final MemberBloc _memberBloc = MemberBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Member Data'),
      ),
      body: StreamBuilder<User>(
        stream: _memberBloc.userStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(snapshot.data!.nama_user.toString()),
                  subtitle: Text(snapshot.data!.email_user.toString()),
                ),
                ListTile(
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text('Logout'),
                  onTap: () {},
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class ListMembers extends StatelessWidget {
  final String? listz;
  final int? daftarMember;
  final int? length;

  ListMembers({
    required this.listz,
    required this.daftarMember,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Member Data'),
      ),
      body: FutureBuilder<List<User>>(
        future: MemberBloc.getAllDataUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                User user = snapshot.data![index];
                return ListTile(
                  title: Text(User.getNama(user)),
                  subtitle: Text(User.getEmail(user)),
                  onTap: () {},
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

// create list member
class memberItem extends StatelessWidget {
  final User? member;

  const memberItem({Key? key, this.member}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(member?.nama_user ?? 'Nama'),
      leading: Icon(Icons.person),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProdukPage(
              memberId: member?.id_user,
            ),
          ),
        );
      },
    );
  }
}
