import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';

class NetworkHandler {
  static final client = http.Client();
  static final storage = FlutterSecureStorage();

  static Future<String> auth(var body, String endpoint) async {
    var response = await client.post(buildUrl(endpoint),
        body: body, headers: {"Content-type": "application/json"});
    return response.body;
  }

  static Future<dynamic> get(String endpoint) async {
    var Token = await NetworkHandler.getToken();
    if (Token != null) {
      var response = await client.get(buildUrl(endpoint), headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $Token"
      });
      return response.body;
    }
  }

  static Future<dynamic> getById(String endpoint, String Id) async {
    var Token = await NetworkHandler.getToken();
    if (Token != null) {
      var response = await client.get(buildUrl("$endpoint/$Id"), headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $Token"
      });
      return response.body;
    }
  }

  static Future<String> post(var body, String endpoint) async {
    var Token = await NetworkHandler.getToken();

    var response = await client.post(buildUrl(endpoint), body: body, headers: {
      "Content-type": "application/json",
      "Authorization": "Bearer $Token"
    });
    return response.body;
  }

  static Uri buildUrl(String endpoint) {
    String host = "https://myfinnplan.herokuapp.com/api/v1/";
    final apiPath = host + endpoint;
    return Uri.parse(apiPath);
  }

  // static Future<void> storeToken(String token) async {
  //   final box = GetStorage();
  //   box.write("token", "Bearer " + token);
  // }

  static Future<void> storeData(Map<String, dynamic> data) async {
    final box = GetStorage();
    await box.write("dataUser", data);
  }

  static Future<String> getToken() async {
    final dataUser = GetStorage();
    Map<String, dynamic> data = dataUser.read("dataUser");
    return await data['token'];
  }
}
