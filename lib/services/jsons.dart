import 'dart:convert';

import 'package:flutter/services.dart';

class JsonService {
  ///getJson() Takes an Path to an Json and Returns it as an Future<Map>
  Future<dynamic> getJson(String jsonPath) async {
    String buffer = await rootBundle.loadString(jsonPath);
    return jsonDecode(buffer);
  }
}
