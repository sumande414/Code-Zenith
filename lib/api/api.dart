import 'dart:convert';
import 'dart:ffi';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:friendz_code/models/codeforce_model.dart';
import 'package:http/http.dart' as http;

class api {
  static Future<Codeforces> fetchHandle(String? handle) async {
    try {
      String url = "https://codeforces.com/api/user.info?handles=$handle";
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return Codeforces.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("${jsonDecode(response.body)["comment"]}");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return Codeforces(status: "", results: []);
    }
  }
}
