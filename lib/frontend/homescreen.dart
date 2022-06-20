import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toko_kita/ui/produk_page.dart';

import '../blocs/logout_bloc.dart';
import '../ui/member.dart';
import '../ui/profile_page.dart';
import '../widgets/warning_dialog.dart';
import 'ui/login_user.dart';

class HomePages extends StatelessWidget {
  const HomePages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        primary: true,
        backgroundColor: Colors.lightBlue,
        title: const Text('Home Page'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              onDetailsPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
              accountName: const Text("Admin"),
              accountEmail: const Text("Admin@gmail.com "),
            ),
            ListTile(
              title: const Text('Home'),
              leading: const Icon(Icons.home),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePages(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('List Produk'),
              leading: const Icon(Icons.list),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProdukPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('List Member'),
              leading: const Icon(Icons.person),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MemberPage(),
                  ),
                );
              },
            ),
            const Divider(
              height: 1.0,
            ),
            ListTile(
              title: const Text('Logout'),
              leading: const Icon(Icons.exit_to_app),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => WarningDialog(
                    key: const Key('logout_dialog'),
                    description: 'Apakah anda yakin ingin logout?',
                    okClick: () {
                      EasyLoading.show(
                        status: 'Logout...',
                        maskType: EasyLoadingMaskType.black,
                      );
                      // logout
                      LogoutBloc().logout().then((value) {
                        EasyLoading.dismiss();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      });
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Image.asset(
            'images/tokokitalogo.png',
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}
