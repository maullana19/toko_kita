import 'package:flutter/material.dart';
import 'package:flutter_lans/profile/profile.dart';
import 'package:flutter_lans/ui/produk_form.dart';
import 'package:flutter_lans/ui/produk_page.dart';
import 'package:flutter_lans/profile/profile.dart';
import 'package:flutter/widgets.dart';

class HelloWorld extends StatefulWidget {
  @override
  State<HelloWorld> createState() => _HelloWorldState();
}

class _HelloWorldState extends State<HelloWorld> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Belajar Flutter'),
        backgroundColor: Colors.black87,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Profiles(),
                    ));
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_bag),
              title: Text('Produk Form'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProdukForm()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('List Produk'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProdukPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Hello Guys Apa Kabar?'),
      ),
    );
  }
}
