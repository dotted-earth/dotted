// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dotted/models/media_modal.dart';
import 'package:dotted/providers/media_provider.dart';

class MediaRepository {
  MediaProvider mediaProvider;
  late MediaProvider _mediaProvider;

  MediaRepository({
    required this.mediaProvider,
  }) : super() {
    _mediaProvider = mediaProvider;
  }

  Future<MedialModel> createMedia(String url) async {
    try {
      final data = await _mediaProvider.createMedia(url);

      return MedialModel.fromMap(data);
    } catch (err) {
      throw err.toString();
    }
  }
}
