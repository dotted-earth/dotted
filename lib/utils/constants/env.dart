import 'package:flutter_config/flutter_config.dart';

class Env {
  static String supabaseURL = FlutterConfig.get('SUPABASE_URL');

  static String supabaseAnon = FlutterConfig.get('SUPABASE_ANON');

  static String unsplashAccessKey = FlutterConfig.get('UNSPLASH_ACCESS_KEY');

  static String googlePlacesKey = FlutterConfig.get('GOOGLE_PLACES_KEY');
}
