import 'package:flutter/material.dart';
import 'package:flutter_lans/models/produk.dart';
import 'package:flutter_lans/ui/produk_form.dart';
import 'package:flutter_lans/ui/produk_detail.dart';
import 'package:flutter_lans/blocs/produk_bloc.dart';

class ProdukDetail extends StatefulWidget {
  Produk? produk;
  ProdukDetail({Key? key, this.produk}) : super(key: key);
  @override
  _ProdukDetailState createState() => _ProdukDetailState();
}

// create produk detail with delete and update
class _ProdukDetailState extends State<ProdukDetail> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _produkBloc = ProdukBloc();
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
        title: Text('Detail Produk'),
        actions: [
          IconButton(
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
                  initialValue: _produk?.namaProduk,
                  decoration: InputDecoration(
                    labelText: 'Nama Produk',
                  ),
                  onSaved: (value) => _produk?.namaProduk = value,
                ),
                TextFormField(
                  initialValue: _produk?.hargaProduk.toString(),
                  decoration: InputDecoration(
                    labelText: 'Harga Produk',
                  ),
                  onSaved: (value) => _produk?.hargaProduk,
                ),
                TextFormField(
                  initialValue:
                      _produk?.kodeProduk!.toString()?.replaceAll('<br>', '\n'),
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Deskripsi Produk',
                  ),
                  onSaved: (value) => _produk?.kodeProduk = value,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
