import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yoauto_task/constants/constant.dart';

class ApiServices {
  static void fetchAccessToken() async {
    String clientId =
        '33OkryzDZsIAWP7j7o1a3Wu2lT-X_lm9GnT6350wGfeQu2AbdgOlB6OjvEJmXHGersn1fVABA6H0eq2sBta4kw==';
    // '33OkryzDZsJmtlQgO4BFeNMUfx7EvmOMF77537F25m3OsiMFmTAuqIMpVAZtBA-oly_AjiRQC87FOyC2ByfMmA==';
    String clientSecret =
        'lrFxI-iSEg80_T8nJYynhKi_C4CmeUwTEJ2z3XlaJrVeF12LrKYPOTBdPDy8KA5ILrO1NsE3vU_9a2mJvJEOs3PxyEMquswb';
    // 'lrFxI-iSEg8wb-7rT_2_fWZZmpaZ_lIceqFjMYevA_9ILDLcpH5K9GSwA3LF9ElqFf8mD80Nmw9nu9ZqYIpZnJtA2OxOqgCU';
    String url =
        'https://outpost.mapmyindia.com/api/security/oauth/token?grant_type=client_credentials&client_id=$clientId&client_secret=$clientSecret';
    http.Response response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      accessToken = data['access_token'];
    } else {
      print("Error ${response.statusCode} ${response.body}");
    }
  }
}
