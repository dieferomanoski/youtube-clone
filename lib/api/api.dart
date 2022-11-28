import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/video.dart';

const YOUTUBE_KEY = 'AIzaSyAmqOLzFRmL9_7z6H947huV5sMMC51kyx4';
const ID_CHANNEL = 'UC9-y-6csu5WGm29I7JiwpnA';
const URL_BASE = 'https://www.googleapis.com/youtube/v3/';

class Api {
  Future<List<Video>> search(String pesquisa) async {
    http.Response response = await http.get(URL_BASE +
        'search'
            '?part=snippet'
            '&type=video'
            '&maxResults=20'
            '&order=date'
            '&key=$YOUTUBE_KEY'
            //'&channelId=$ID_CHANNEL'
            '&q=$pesquisa');

    if (response.statusCode == 200) {
      Map<String, dynamic> dadosJson = json.decode(response.body);
      List<Video> videos = dadosJson["items"].map<Video>((map) {
        return Video.fromJson(map);
      }).toList();

      return videos;
    } else {}
  }
}
