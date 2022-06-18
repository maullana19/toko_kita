// ignore_for_file: file_names
import 'dart:convert';

dynamic sonDecode(String source,
    {Object? Function(Object? key, Object? value)? reviver}) {
  return json.decode(source, reviver: reviver);
}
