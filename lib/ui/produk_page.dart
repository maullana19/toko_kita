import 'package:flutter/material.dart';
import 'package:toko_kita/blocs/logout_bloc.dart';
import 'package:toko_kita/blocs/produk_bloc.dart';
import 'package:toko_kita/models/produk.dart';
import 'package:toko_kita/ui/login_page.dart';
import 'package:toko_kita/ui/produk_detail.dart';
import 'package:toko_kita/ui/produk_form.dart';
import 'package:toko_kita/ui/profile_page.dart';
import 'package:toko_kita/ui/member.dart';
import 'package:toko_kita/widgets/warning_dialog.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({Key? key, memberId}) : super(key: key);

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        primary: true,
        backgroundColor: Colors.lightBlue,
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProdukForm(),
                ),
              );
            },
          ),
        ],
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
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('List Produk'),
              leading: const Icon(Icons.list),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('List Member'),
              leading: const Icon(Icons.person),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MemberPage()));
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
        child: FutureBuilder<List>(
          future: ProdukBloc.getProduks(),
          builder: (context, AsyncSnapshot<List> snapshot) {
            EasyLoading.show(status: 'TokoKita.com');
            Future.delayed(const Duration(seconds: 3), () {
              EasyLoading.dismiss();
            });
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.connectionState == ConnectionState.none) {
              return const Center(child: CircularProgressIndicator());
            }
            // ignore: avoid_print
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ListProduk(
                    list: snapshot.data,
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}

class ListProduk extends StatelessWidget {
  final List? list;

  const ListProduk({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
      itemCount: list == null ? 0 : list?.length,
      itemBuilder: (context, i) {
        return ItemProduk(
          produk: list![i],
        );
      },
    );
  }
}

class ItemProduk extends StatelessWidget {
  final Produk? produk;
  const ItemProduk({Key? key, required this.produk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProdukDetail(
                produk: produk,
              ),
            ),
          );
        },
        child: Column(
          children: [
            Image.network(
              "https://picsum.photos/200/200?image=${produk?.id}",
              height: 250,
              width: 300,
              fit: BoxFit.cover,
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${produk?.namaProduk}",
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Rp.${produk?.hargaProduk}",
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
