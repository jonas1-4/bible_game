import 'package:flutter/services.dart';

class JsonService {
  ///getJson() Takes an Path to an Json and Returns it as an Future<String>
  Future<String> getJson(String jsonPath) {
  return rootBundle.loadString('jsonPath');
}
}
