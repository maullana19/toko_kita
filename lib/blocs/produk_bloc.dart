import 'dart:convert';
import 'dart:io';
import 'package:toko_kita/helpers/api.dart';
import 'package:toko_kita/helpers/api_url.dart';
import 'package:toko_kita/models/produk.dart';
import 'package:meta/meta.dart';
import 'dart:async';

class ProdukBloc {
  static Future<List<Produk>> getProduks() async {
    String apiUrl = ApiUrl.listProduk;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listProduk = (jsonObj as Map<String, dynamic>)['data'];
    List<Produk> produks = [];
    for (int i = 0; i < listProduk.length; i++) {
      produks.add(Produk.fromJson(listProduk[i]));
    }
    return produks;
  }

  static Future<Produk> getProdukById(int id) async {
    String apiUrl = ApiUrl.getProduk(id) + id.toString();
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    Produk produk = Produk.fromJson(jsonObj);
    return produk;
  }

  static Future addProduk({Produk? produk}) async {
    String apiUrl = ApiUrl.createProduk;

    var body = {
      "kode_produk": produk!.kodeProduk,
      "nama_produk": produk.namaProduk,
      "harga": produk.hargaProduk.toString()
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> updateProduk({required Produk produk}) async {
    String apiUrl = ApiUrl.updateProduk(produk.id);

    var body = {
      "kode_produk": produk.kodeProduk,
      "nama_produk": produk.namaProduk,
      "harga": produk.hargaProduk.toString()
    };
    print("Body : $body");
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['data'];
  }

  // delete produk by id
  static Future<bool> deleteProduk(int id) async {
    String apiUrl = ApiUrl.deleteProduk(id.toString());
    var response = await Api().delete(Uri.parse(apiUrl));
    var jsonObj = json.decode(response.body);
    return jsonObj['data'];
  }

  void dispose() {}
}
