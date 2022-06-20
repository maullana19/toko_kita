import 'package:flutter/material.dart';
import 'package:toko_kita/blocs/logout_bloc.dart';
import 'package:toko_kita/blocs/member_bloc.dart';
import 'package:toko_kita/models/user.dart';
import 'package:toko_kita/ui/login_page.dart';
import 'package:toko_kita/ui/produk_page.dart';

import '../frontend/ui/login_user.dart';

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
                  title: Text(snapshot.data!.namaUser.toString()),
                  subtitle: Text(snapshot.data!.emailUser.toString()),
                ),
                ListTile(
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text('Logout'),
                  onTap: () {
                    _logoutBloc.logout();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return const Center(
              child: Text("Data tidak ditemukan"),
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

  // ignore: use_key_in_widget_constructors
  const ListMembers({
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

// create list member
class MemberItem extends StatelessWidget {
  final User? member;

  const MemberItem({Key? key, this.member}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(member?.namaUser ?? 'Nama'),
      leading: const Icon(Icons.person),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProdukPage(
              memberId: member?.idUser,
            ),
          ),
        );
      },
    );
  }
}
