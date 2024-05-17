import 'package:dotted/utils/constants/env.dart';
import 'package:http/http.dart' as http;

final client = http.Client();

class UnsplashProvider {
  final String _api = "https://api.unsplash.com";
  final String _accessKey = Env.unsplashAccessKey;

  Future<http.Response> getRandomImage(String destination) {
    return client.get(
        Uri.parse(
            "$_api/photos/random/?query=$destination&orientation=landscape"),
        headers: {'Authorization': "Client-ID $_accessKey"});
  }
}
