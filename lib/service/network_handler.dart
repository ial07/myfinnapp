import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class NetworkHandler {
  static final client = http.Client();
  static final storage = FlutterSecureStorage();

  static Future<String> auth(var body, String endpoint) async {
    var response = await client.post(buildUrl(endpoint),
        body: body, headers: {"Content-type": "application/json"});
    return response.body;
  }

  static Future<dynamic> get(String endpoint, String? token) async {
    print(token);
    var response = await client.get(buildUrl(endpoint), headers: {
      "Content-type": "application/json",
      "Authorization": "$token"
    });
    return response.body;
  }

  static Uri buildUrl(String endpoint) {
    String host = "https://myfinnplan.herokuapp.com/api/v1/";
    final apiPath = host + endpoint;
    return Uri.parse(apiPath);
  }

  static Future<void> storeToken(String token) async {
    await storage.write(key: "token", value: "Bearer " + token);
  }

  static Future<String?> getToken() async {
    return await storage.read(key: "token");
  }
}
