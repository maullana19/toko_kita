import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:toko_kita/helpers/user_info.dart';
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
import 'package:toko_kita/models/user.dart';

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
              accountName: Text("Admin"),
              accountEmail: Text("Admin@gmail.com "),
            ),
            ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('List Produk'),
              leading: Icon(Icons.list),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('List Member'),
              leading: Icon(Icons.person),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MemberPage()));
              },
            ),
            const Divider(
              height: 1.0,
            ),
            ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.exit_to_app),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ],
        ),
      ),
      body: Container(
        child: Center(
          child: FutureBuilder<List>(
            future: ProdukBloc.getProduks(),
            builder: (context, AsyncSnapshot<List> snapshot) {
              EasyLoading.show(status: 'TokoKita.com');
              Future.delayed(Duration(seconds: 3), () {
                EasyLoading.dismiss();
              });
              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.connectionState == ConnectionState.none) {
                return Center(child: CircularProgressIndicator());
              }
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
      ),
    );
  }
}

class ListProduk extends StatelessWidget {
  final List? list;

  const ListProduk({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list?.length,
        itemBuilder: (context, i) {
          return ItemProduk(
            produk: list![i],
          );
        });
  }
}

class ItemProduk extends StatelessWidget {
  final Produk? produk;
  const ItemProduk({Key? key, required this.produk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(produk!.namaProduk!),
        contentPadding: EdgeInsets.all(10),
        subtitle: Text("Kode :" +
            produk!.kodeProduk! +
            "\n " +
            "Harga :" +
            produk!.hargaProduk!.toString()),
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: Text(produk!.namaProduk![0]),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProdukDetail(
                        produk: produk,
                      )));
        },
      ),
    );
  }
}
