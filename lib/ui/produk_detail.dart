import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_lans/models/produk.dart';
import 'package:flutter_lans/ui/produk_form.dart';
import 'package:flutter_lans/ui/produk_detail.dart';
import 'package:flutter_lans/blocs/produk_bloc.dart';
import 'package:flutter_lans/widgets/warning_dialog.dart';
import 'dart:convert';
import 'dart:async';

class ProdukDetail extends StatefulWidget {
  Produk? produk = null;
  ProdukDetail({Key? key, this.produk}) : super(key: key);
  @override
  _ProdukDetailState createState() => _ProdukDetailState();
}

class _ProdukDetailState extends State<ProdukDetail> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _produkBloc = ProdukBloc();
  Produk? _produk;

  var produk;

  @override
  void initState() {
    super.initState();
    _produk = widget.produk;
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Detail Produk'),
        actions: [
          IconButton(
            tooltip: 'Ubah?',
            icon: Icon(Icons.edit),
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
          // delete button
          IconButton(
            tooltip: 'Hapus?',
            icon: Icon(Icons.delete),
            onPressed: () {
              ProdukBloc.deleteProduk(_produk!.id).then(
                (value) {},
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
                    decoration: InputDecoration(
                      labelText: 'KODE PRODUK',
                    ),
                    onSaved: (value) => _produk?.kodeProduk = value,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: _produk?.namaProduk,
                    decoration: InputDecoration(
                      labelText: 'Nama Produk',
                    ),
                    onSaved: (value) => _produk?.namaProduk = value,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: _produk?.hargaProduk.toString(),
                    decoration: InputDecoration(
                      labelText: 'Harga Produk',
                    ),
                    onSaved: (value) => _produk?.hargaProduk,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              )),
        ),
      ),
    );
  }

  void showWarningDialog(
      BuildContext context, String s, String t, Null Function() param3) {}

  void showErrorDialog(BuildContext context, String s) {}
}
