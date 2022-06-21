// ignore_for_file: file_names

import "package:flutter/material.dart";
import 'package:select_form_field/select_form_field.dart';

class MyInput {
  final String? label;
  final TextEditingController? value;
  final String? error;
  final List<Map<String, dynamic>>? options;
  const MyInput({Key? key, this.label, this.error, this.value, this.options});

  Widget standart({bool isRead = false}) {
    return TextFormField(
      readOnly: isRead,
      decoration:
          InputDecoration(border: const OutlineInputBorder(), labelText: label),
      keyboardType: TextInputType.number,
      controller: value,
      validator: (value) {
        if (value!.isEmpty) {
          return error;
        }
        return null;
      },
    );
  }

  Widget select() {
    final items = options;
    return SelectFormField(
      type: SelectFormFieldType.dropdown,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: "$label",
      ),
      items: items,
      controller: value,
      validator: (value) {
        if (value!.isEmpty) {
          return error;
        }
        return null;
      },
    );
  }
}
