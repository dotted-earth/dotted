import 'dart:convert';

import 'package:dotted/providers/unsplash_provider.dart';

class UnsplashRepository {
  late UnsplashProvider _unsplashProvider;
  UnsplashProvider unsplashProvider;

  UnsplashRepository(
    this.unsplashProvider,
  ) {
    _unsplashProvider = unsplashProvider;
  }

  Future<String> getRandomImage(String destination) async {
    try {
      final data = await _unsplashProvider.getRandomImage(destination);
      final imageData = jsonDecode(data.body);
      return imageData["urls"]["small"];
    } catch (err) {
      throw err.toString();
    }
  }
}
