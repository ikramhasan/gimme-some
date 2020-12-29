import 'dart:convert';

import 'package:gimme_some/src/models/advice.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String url = 'https://api.adviceslip.com/advice';

  fetchAdvice() async {
    final response = await http.get(url);
    final rawJsonData = jsonDecode(response.body);
    return Advice.fromJson(rawJsonData);
  }
}
