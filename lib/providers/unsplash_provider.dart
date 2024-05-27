import 'package:dotted/utils/constants/env.dart';
import 'package:dotted/utils/constants/http_client.dart';
import 'package:http/http.dart' as http;

class UnsplashProvider {
  final String _api = "https://api.unsplash.com";
  final String _accessKey = Env.unsplashAccessKey;

  Future<http.Response> getRandomImage(String destination) {
    return httpClient.get(
        Uri.parse(
            "$_api/photos/random/?query=$destination&orientation=landscape"),
        headers: {'Authorization': "Client-ID $_accessKey"});
  }
}
