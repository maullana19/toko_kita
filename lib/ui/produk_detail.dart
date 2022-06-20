// ignore_for_file: deprecated_member_use

import 'dart:core';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:toko_kita/helpers/formating.dart';
import 'package:toko_kita/models/produk.dart';
import 'package:toko_kita/ui/produk_form.dart';
import 'package:toko_kita/blocs/produk_bloc.dart';
import 'package:toko_kita/ui/produk_page.dart';

// ignore: must_be_immutable
class ProdukDetail extends StatefulWidget {
  Produk? produk;
  ProdukDetail({Key? key, this.produk}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _ProdukDetailState createState() => _ProdukDetailState();
}

class _ProdukDetailState extends State<ProdukDetail> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Produk? _produk;

  @override
  void initState() {
    super.initState();
    _produk = widget.produk;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Detail Produk'),
        actions: [
          IconButton(
            tooltip: 'Ubah?',
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProdukForm(
                    produk: _produk,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Card(
          elevation: 10,
          margin: const EdgeInsets.all(20),
          // Detail Produk
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: Image.memory(
                    base64Decode("${_produk?.gambarProduk}"),
                    fit: BoxFit.cover,
                  ),
                ),

                Text(
                  '${_produk?.namaProduk}',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Formating.convertToIdr(_produk?.hargaProduk, 0),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 15,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 15,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 15,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 15,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 15,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("(5.0)"),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                // Kategori produk
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.category_outlined,
                          color: Color.fromARGB(255, 70, 77, 83),
                          size: 16,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          Formating.upperCaseFrist("${_produk?.kategori}"),
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    _tombolHapusEdit(),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  '${_produk?.deskripsi}',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //Tombol Edit
        IconButton(
          tooltip: 'Edit',
          icon: const Icon(Icons.edit),
          color: Colors.blue,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProdukForm(
                  produk: widget.produk!,
                ),
              ),
            );
          },
        ),
        const SizedBox(
          width: 10,
        ),
        //Tombol Hapus
        IconButton(
          tooltip: 'Hapus',
          icon: const Icon(Icons.delete),
          color: Colors.red,
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        FlatButton(
          color: const Color.fromARGB(255, 185, 66, 58),
          child: const Text(
            "HAPUS",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          onPressed: () {
            ProdukBloc.deleteProduk(_produk?.id).then(
              (value) => {
                // alert
                Navigator.pop(context),
                _scaffoldKey.currentState?.showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.green,
                    elevation: 10,
                    padding: EdgeInsets.all(20),
                    content: Text("Data berhasil dihapus"),
                    duration: Duration(seconds: 2),
                  ),
                ),
                // wait 2 second
                Future.delayed(
                  const Duration(seconds: 1),
                  () => {
                    // kembali ke halaman produk
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProdukPage(),
                      ),
                      (route) => false,
                    ),
                  },
                ),
              },
            );
          },
        ),
        //tombol batal
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }

  void showWarningDialog(
      BuildContext context, String s, String t, Null Function() param3) {}

  void showErrorDialog(BuildContext context, String s) {}
}
