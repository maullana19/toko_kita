// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:toko_kita/helpers/formating.dart';
import 'package:toko_kita/models/produk.dart';
import 'package:toko_kita/ui/produk_detail.dart';

class ItemProduk extends StatelessWidget {
  final Produk? produk;
  const ItemProduk({Key? key, required this.produk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String namaProduk = "${produk?.namaProduk}";
    namaProduk.length > 20
        ? namaProduk = '${namaProduk.substring(0, 32)}...'
        : namaProduk = namaProduk;
    return Card(
      elevation: 10,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProdukDetail(
                produk: produk,
              ),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // base64 image to image
            Image.memory(
              base64Decode("${produk?.gambarProduk}"),
              fit: BoxFit.cover,
              height: 180,
              width: double.infinity,
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    namaProduk,
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    Formating.convertToIdr(produk?.hargaProduk, 0),
                    style: const TextStyle(fontSize: 12),
                  ),
                  // Ratting
                  const SizedBox(
                    height: 5,
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
                    children: [
                      const Icon(
                        Icons.category_outlined,
                        color: Color.fromARGB(255, 70, 77, 83),
                        size: 12,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        Formating.upperCaseFrist("${produk?.kategori}"),
                        style: const TextStyle(fontSize: 11),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
