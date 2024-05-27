import 'package:dotted/utils/constants/env.dart';
import 'package:dotted/utils/constants/http_client.dart';
import 'package:http/http.dart' as http;

class ViatorProvider {
  final String _api = "https://api.sandbox.viator.com/partner";
  final String _accessKey = Env.viatorApiKey;

  Future<http.Response> getDestinations(String destination) {
    return httpClient.get(Uri.parse("$_api/v1/taxonomy/destinations"),
        headers: {'exp-api-key': _accessKey, 'Accept-Language': 'en-US'});
  }
}
