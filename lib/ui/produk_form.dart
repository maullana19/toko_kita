import 'dart:typed_data';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:toko_kita/blocs/produk_bloc.dart';
import 'package:toko_kita/models/produk.dart';
import 'package:toko_kita/ui/produk_page.dart';
import 'package:toko_kita/widgets/myInput.dart';
import 'package:toko_kita/widgets/warning_dialog.dart';
import 'package:image_picker_web/image_picker_web.dart';

import '../widgets/success_dialog.dart';

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
  // Mask IDR
  final _hargaProdukTextboxController = MoneyMaskedTextController(
      thousandSeparator: '.', precision: 0, decimalSeparator: '');
  final _deskripsiProdukTextboxController = TextEditingController();
  final _kategoriSelectFormFieldController = TextEditingController();

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
        _deskripsiProdukTextboxController.text = widget.produk!.deskripsi!;
        _kategoriSelectFormFieldController.text = widget.produk!.kategori!;
        imageAvalible = true;
        // base64 to Uint8List
        imageFile = base64.decode(widget.produk!.gambarProduk!);
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
                _deskripsiProdukTextField(),
                const SizedBox(
                  height: 20,
                ),
                _kategoriSelectFormField(),
                _uploadimage(),
                const SizedBox(
                  height: 20,
                ),
                _image(),
                const SizedBox(
                  height: 20,
                ),
                // add button
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.produk == null ? _addProduk() : ubah();
                    }
                  },
                  child: Text(tombolSubmit,
                      style: const TextStyle(color: Colors.white)),
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
    return MyInput(
            label: "Kode Produk",
            value: _kodeProdukTextboxController,
            error: "Kode Produk harus diisi")
        .standart();
  }

  Widget _namaProdukTextField() {
    return MyInput(
            label: "Nama Produk",
            value: _namaProdukTextboxController,
            error: "Nama Produk harus diisi")
        .standart();
  }

  Widget _hargaProdukTextField() {
    // input harga produk format idr
    return MyInput(
            label: "Harga Produk",
            value: _hargaProdukTextboxController,
            error: "Harga Produk harus diisi")
        .standart();
  }

  Widget _deskripsiProdukTextField() {
    return MyInput(
            label: "Deskripsi Produk",
            value: _deskripsiProdukTextboxController,
            error: "Deskripsi Produk harus diisi")
        .standart();
  }

  Widget _kategoriSelectFormField() {
    return MyInput(
      label: "Kategori",
      options: [
        {
          'value': 'elektronik',
          'label': 'Elektronik',
        },
        {
          'value': 'fashion',
          'label': 'Fashion',
        },
        {
          'value': 'alat',
          'label': 'Alat',
        },
      ],
      value: _kategoriSelectFormFieldController,
      error: "Kategori harus diisi",
    ).select();
  }

  Widget _uploadimage() {
    return FormField(
      builder: (FormFieldState<String> state) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
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
      },
      validator: (value) {
        if (value == null && imageAvalible == false) {
          showDialog(
            context: context,
            builder: (context) => const WarningDialog(
                description: "Gambar produk wajib diupload"),
          );
        }
        return null;
      },
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
    // jika imagefile tidak ada munculkan dialog box
    setState(() {});
    Produk createProduk = Produk(id: widget.produk?.id);
    createProduk.kodeProduk = _kodeProdukTextboxController.text;
    createProduk.namaProduk = _namaProdukTextboxController.text;
    // remove dot from string
    createProduk.hargaProduk =
        int.parse(_hargaProdukTextboxController.text.replaceAll('.', ''));
    createProduk.deskripsi = _deskripsiProdukTextboxController.text;
    createProduk.kategori = _kategoriSelectFormFieldController.text;
    createProduk.gambarProduk = base64Encode(imageFile);
    ProdukBloc.addProduk(produk: createProduk).then((value) {
      if (value.code == 200) {
        showDialog(
          context: context,
          builder: (context) => SuccessDialog(
            description: "Produk berhasil ditambahkan",
            okClick: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => const ProdukPage(),
                ),
              );
            },
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => WarningDialog(description: "${value.message}"),
        );
      }
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Simpan gagal, silahkan coba lagi",
        ),
      );
      setState(() {});
    });
  }

  ubah() {
    setState(() {});
    Produk updateProduk = Produk(id: widget.produk!.id);
    updateProduk.kodeProduk = _kodeProdukTextboxController.text;
    updateProduk.namaProduk = _namaProdukTextboxController.text;
    // remove dot from string
    updateProduk.hargaProduk =
        int.parse(_hargaProdukTextboxController.text.replaceAll('.', ''));
    updateProduk.deskripsi = _deskripsiProdukTextboxController.text;
    updateProduk.kategori = _kategoriSelectFormFieldController.text;
    updateProduk.gambarProduk = base64Encode(imageFile);
    ProdukBloc.updateProduk(produk: updateProduk).then((value) {
      if (value.code == 200) {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) => SuccessDialog(
            description: "Produk berhasil dirubah",
            okClick: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => const ProdukPage(),
                ),
              );
            },
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => WarningDialog(description: "${value.message}"),
        );
      }
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
