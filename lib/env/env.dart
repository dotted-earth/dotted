import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env.dev', useConstantCase: true)
abstract class Env {
  @EnviedField(varName: "SUPABASE_URL")
  static const String supabaseURL = _Env.supabaseURL;

  @EnviedField(varName: "SUPABASE_ANON")
  static const String supabaseAnon = _Env.supabaseAnon;

  @EnviedField(varName: "UNSPLASH_ACCESS_KEY")
  static const String unsplashAccessKey = _Env.unsplashAccessKey;

  @EnviedField(varName: "GOOGLE_PLACES_KEY")
  static const String googlePlacesKey = _Env.googlePlacesKey;
}
