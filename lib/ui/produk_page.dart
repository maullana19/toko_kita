import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_lans/helpers/user_info.dart';
import 'package:flutter_lans/blocs/logout_bloc.dart';
import 'package:flutter_lans/blocs/produk_bloc.dart';
import 'package:flutter_lans/models/produk.dart';
import 'package:flutter_lans/ui/login_page.dart';
import 'package:flutter_lans/ui/produk_detail.dart';
import 'package:flutter_lans/ui/produk_form.dart';
import 'package:flutter_lans/ui/profile_page.dart';

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
        //  create user profile icon
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilesPages()));
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
        child: const Icon(Icons.add),
        onPressed: () async {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ProdukForm()));
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
        itemCount: list == null ? 0 : list!.length,
        itemBuilder: (context, i) {
          return ItemProduk(
            produk: list![i],
          );
        });
  }
}

// create list produk item widget class with produk data
class ItemProduk extends StatelessWidget {
  final Produk? produk;

  const ItemProduk({Key? key, this.produk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(produk!.namaProduk!),
        subtitle: Text("Kode :" + produk!.kodeProduk!),
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
