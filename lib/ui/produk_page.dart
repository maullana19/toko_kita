import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_lans/helpers/user_info.dart';
import 'package:flutter_lans/blocs/logout_bloc.dart';
import 'package:flutter_lans/blocs/produk_bloc.dart';
import 'package:flutter_lans/models/produk.dart';
import 'package:flutter_lans/ui/login_page.dart';
import 'package:flutter_lans/ui/produk_detail.dart';
import 'package:flutter_lans/ui/produk_form.dart';
import 'package:flutter_lans/ui/profile_page.dart';
import 'package:flutter_lans/ui/member.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({Key? key}) : super(key: key);

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TokoKita.com'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return ProdukForm();
                  });
            },
          ),
        ],
      ),
      // create drawer all menu
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Admin'),
              accountEmail: Text('email : '),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text('A'),
              ),
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

      body: FutureBuilder<List>(
        future: ProdukBloc.getProduks(),
        builder: (context, AsyncSnapshot<List> snapshot) {
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

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.note_alt),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Center(
                  child: Text(
                      'Untuk Menghapus Tekan List yang ingin dihapus dengan Lama'),
                );
              });
        },
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
  final double _height = 100;

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
