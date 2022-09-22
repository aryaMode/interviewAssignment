import 'dart:convert';

Map<String, dynamic> objectConversion(Object? object) {
  return jsonDecode(jsonEncode(object));
}
