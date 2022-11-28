import 'package:youtube_clone/api/api.dart';
import 'package:youtube_clone/models/video.dart';

class ApiController {
  Future<List<Video>> listVideos(String searchString) {
    Api api = Api();

    return api.search(searchString);
  }
}
