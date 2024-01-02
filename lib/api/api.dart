import 'dart:convert';
import 'package:friendz_code/models/codeforce_model.dart';
import 'package:http/http.dart' as http;

class api {
  static Future<Codeforces?> fetchHandle(String? handle) async {
    String url = "https://codeforces.com/api/user.info?handles=$handle";
    http.Response response = await http.get(Uri.parse(url));
    print(response.body);
    if (response.statusCode == 200) {
      return Codeforces.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("${jsonDecode(response.body)["comment"]}");
    }
  }
}
