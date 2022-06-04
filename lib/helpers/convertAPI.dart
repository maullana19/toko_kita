import 'dart:convert';

dynamic jsonDecode(String source,
    {Object? reviver(Object? key, Object? value)?}) {
  return json.decode(source, reviver: reviver);
}

const jsonString =
    '{"text": "foo", "value": 1, "status": false, "extra": null}';
