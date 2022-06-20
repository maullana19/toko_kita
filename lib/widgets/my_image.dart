import 'package:flutter/material.dart';
import 'dart:convert';

class MyImage {
  double? width = 100;
  double? height = 100;
  String? imageBase64;

  MyImage({this.width, this.height, this.imageBase64});

  Widget showImageFromBase64() {
    Widget image = Container(
      width: width,
      height: height,
      color: Colors.grey,
      child: const Icon(Icons.image_not_supported, size: 100),
    );
    if (imageBase64 != null) {
      image = Image.memory(
        base64Decode(imageBase64!),
        fit: BoxFit.cover,
        height: height,
        width: double.infinity,
      );
    }
    return image;
  }
}
