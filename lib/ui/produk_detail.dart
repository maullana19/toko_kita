// ignore_for_file: deprecated_member_use

import 'dart:core';
import 'package:flutter/material.dart';
import 'package:toko_kita/models/produk.dart';
import 'package:toko_kita/ui/produk_form.dart';
import 'package:toko_kita/blocs/produk_bloc.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue:
                        _produk?.kodeProduk!.toString() ?? 'Kode Produk',
                    maxLines: null,
                    decoration: const InputDecoration(
                      labelText: 'KODE PRODUK',
                    ),
                    onSaved: (value) => _produk?.kodeProduk = value,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: _produk?.namaProduk,
                    decoration: const InputDecoration(
                      labelText: 'Nama Produk',
                    ),
                    onSaved: (value) => _produk?.namaProduk = value,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: _produk?.hargaProduk.toString(),
                    decoration: const InputDecoration(
                      labelText: 'Harga Produk',
                    ),
                    onSaved: (value) => _produk?.hargaProduk,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _tombolHapusEdit()
                ],
              )),
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //Tombol Edit
        OutlinedButton(
            child: const Text("EDIT"),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProdukForm(
                            produk: widget.produk!,
                          )));
            }),
        //Tombol Hapus
        OutlinedButton(
            child: const Text("DELETE"), onPressed: () => confirmHapus()),
      ],
    );
  }

  confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        FlatButton(
          child: const Text("HAPUS"),
          onPressed: () {
            ProdukBloc.deleteProduk(_produk?.id);
            Navigator.pop(context);
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
