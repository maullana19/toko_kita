import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toko_kita/blocs/logout_bloc.dart';
import 'package:toko_kita/ui/homescreen.dart';
import 'package:toko_kita/ui/login_page.dart';
import 'package:toko_kita/ui/member.dart';
import 'package:toko_kita/ui/produk_page.dart';
import 'package:toko_kita/ui/profile_page.dart';

class MyDrawer extends StatelessWidget {
  final String? userRole;
  const MyDrawer({Key? key, this.userRole}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
              Navigator.pushReplacement(
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProdukPage(),
                ),
              );
            },
          ),
          userRole == 'admin'
              ? ListTile(
                  title: const Text('List Member'),
                  leading: const Icon(Icons.person),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MemberPage(),
                      ),
                    );
                  },
                )
              : const SizedBox(),
          const Divider(
            height: 1.0,
          ),
          ListTile(
            title: const Text('Logout'),
            leading: const Icon(Icons.exit_to_app),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Apakah anda yakin ingin logout?'),
                  actions: [
                    ElevatedButton(
                      child: const Text('Tidak'),
                      onPressed: () => Navigator.pop(context),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                      child: const Text('Ya'),
                      onPressed: () {
                        EasyLoading.show(
                          status: 'Logout...',
                          maskType: EasyLoadingMaskType.black,
                        );
                        LogoutBloc().logout().then(
                          (value) {
                            EasyLoading.dismiss();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
