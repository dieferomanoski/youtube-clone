import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:youtube_clone/api/api.dart';
import 'package:youtube_clone/controllers/api_controller.dart';
import 'package:youtube_clone/models/video.dart';

class Inicio extends StatefulWidget {
  String search;
  Inicio(this.search);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  final apiController = ApiController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Video>>(
        future: apiController.listVideos(widget.search),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasData) {
                return ListView.separated(
                    itemBuilder: (context, index) {
                      List<Video> videos = snapshot.data;
                      Video video = videos[index];
                      return GestureDetector(
                        onTap: () {
                          FlutterYoutube.playYoutubeVideoById(
                              apiKey: YOUTUBE_KEY,
                              videoId: video.id,
                              autoPlay: true,
                              fullScreen: true);
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(video.imagem))),
                            ),
                            ListTile(
                              title: Text(video.titulo),
                              subtitle: Text(video.canal),
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(
                          height: 2,
                          color: Colors.grey,
                        ),
                    itemCount: snapshot.data.length);
              } else {
                return Center(
                  child: Text("Nenhum dado a ser exibido"),
                );
              }
              break;
          }
        });
  }
}
