import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env.dev', useConstantCase: true)
abstract class Env {
  @EnviedField(varName: "SUPABASE_URL")
  static const String supabaseURL = _Env.supabaseUrl;

  @EnviedField(varName: "SUPABASE_ANON")
  static const String supabaseAnon = _Env.supabaseAnon;
}
