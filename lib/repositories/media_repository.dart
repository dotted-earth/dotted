import 'package:dotted/models/media_modal.dart';
import 'package:dotted/models/media_type_enum.dart';
import 'package:dotted/providers/media_provider.dart';

class MediaRepository {
  MediaProvider mediaProvider;
  late MediaProvider _mediaProvider;

  MediaRepository({
    required this.mediaProvider,
  }) : super() {
    _mediaProvider = mediaProvider;
  }

  Future<MediaModel> createMedia(String url, MediaTypeEnum mediaType) async {
    try {
      final data = await _mediaProvider.createMedia(url, mediaType);

      return MediaModel.fromMap(data);
    } catch (err) {
      throw err.toString();
    }
  }
}
