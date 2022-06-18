// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toko_kita/blocs/produk_bloc.dart';
import 'package:toko_kita/models/produk.dart';
import 'package:toko_kita/ui/produk_page.dart';
import 'package:toko_kita/widgets/warning_dialog.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';

// ignore: must_be_immutable
class ProdukForm extends StatefulWidget {
  Produk? produk;

  ProdukForm({Key? key, this.produk}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProdukFormState createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final _formKey = GlobalKey<FormState>();
  String judul = "TAMBAH PRODUK";
  String tombolSubmit = "SIMPAN";
  bool imageAvalible = false;
  late Uint8List imageFile;

  final _kodeProdukTextboxController = TextEditingController();
  final _namaProdukTextboxController = TextEditingController();
  final _hargaProdukTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.produk != null) {
      setState(() {
        judul = "UBAH PRODUK";
        tombolSubmit = "UBAH";
        _kodeProdukTextboxController.text = widget.produk!.kodeProduk!;
        _namaProdukTextboxController.text = widget.produk!.namaProduk!;
        _hargaProdukTextboxController.text =
            widget.produk!.hargaProduk.toString();
      });
    } else {
      judul = "TAMBAH PRODUK";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  create app bar
      appBar: AppBar(
        title: Text(judul),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _kodeProdukTextField(),
                const SizedBox(
                  height: 20,
                ),
                _namaProdukTextField(),
                const SizedBox(
                  height: 20,
                ),
                _hargaProdukTextField(),
                const SizedBox(
                  height: 20,
                ),
                _uploadimage(),
                const SizedBox(
                  height: 20,
                ),
                _image(),
                const SizedBox(
                  height: 20,
                ),
                // add button
                RaisedButton(
                  child: Text(tombolSubmit),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (widget.produk == null) {
                        _addProduk();
                      } else {
                        ubah();
                      }
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _kodeProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: "Kode Produk"),
      keyboardType: TextInputType.text,
      controller: _kodeProdukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Kode Produk harus diisi";
        }
        return null;
      },
    );
  }

  Widget _namaProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: "Nama Produk"),
      keyboardType: TextInputType.text,
      controller: _namaProdukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama Produk harus diisi";
        }
        return null;
      },
    );
  }

  Widget _hargaProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Harga",
      ),
      keyboardType: TextInputType.number,
      controller: _hargaProdukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Harga harus diisi";
        }
        return null;
      },
    );
  }

  Widget _uploadimage() {
    return Container(
      alignment: Alignment.topLeft,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () async {
          final image = await ImagePickerWeb.getImageAsBytes();
          setState(() {
            imageFile = image!;
            imageAvalible = true;
          });
        },
        icon: const Icon(Icons.image),
        label: const Text("upload gambar"),
      ),
    );
  }

  Widget _image() {
    return Container(
      alignment: Alignment.topLeft,
      child: Container(
        width: 200,
        height: 200,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border:
              Border.all(color: const Color.fromARGB(98, 0, 0, 0), width: 1),
        ),
        child:
            imageAvalible ? Image.memory(imageFile) : const Icon(Icons.image),
      ),
    );
  }

  _addProduk() {
    setState(() {});
    Produk createProduk = Produk(id: widget.produk?.id);
    createProduk.kodeProduk = _kodeProdukTextboxController.text;
    createProduk.namaProduk = _namaProdukTextboxController.text;
    createProduk.hargaProduk = int.parse(_hargaProdukTextboxController.text);
    createProduk.gambarProduk = base64Encode(imageFile);
    ProdukBloc.addProduk(produk: createProduk).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const ProdukPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Simpan gagal, silahkan coba lagi",
              ));
    });
    setState(() {});
  }

  ubah() {
    setState(() {});
    Produk updateProduk = Produk(id: widget.produk!.id);
    updateProduk.kodeProduk = _kodeProdukTextboxController.text;
    updateProduk.namaProduk = _namaProdukTextboxController.text;
    updateProduk.hargaProduk = int.parse(_hargaProdukTextboxController.text);
    updateProduk.gambarProduk = base64Encode(imageFile);
    ProdukBloc.updateProduk(produk: updateProduk).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const ProdukPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Simpan gagal, silahkan coba lagi",
              ));
    });
    setState(() {});
  }
}
