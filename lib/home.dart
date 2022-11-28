import 'package:flutter/material.dart';
import 'package:youtube_clone/custom_search_delegate.dart';
import 'package:youtube_clone/pages/biblioteca.dart';
import 'package:youtube_clone/pages/em_alta.dart';
import 'package:youtube_clone/pages/inicio.dart';
import 'package:youtube_clone/pages/inscricao.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

//

class _HomeState extends State<Home> {
  int _bottomIndex = 0;
  String _search = "";

  @override
  Widget build(BuildContext context) {
    List<Widget> telas = [
      Inicio(_search),
      EmAlta(),
      Inscricao(),
      Biblioteca(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey[600]),
        title: Image.asset(
          "images/youtube.png",
          width: 98,
          height: 22,
        ),
        actions: [
          IconButton(icon: Icon(Icons.videocam), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                String res = await showSearch(
                    context: context, delegate: CustomSearchDelegate());
                setState(() {
                  _search = res;
                });
              }),
          IconButton(icon: Icon(Icons.account_circle), onPressed: () {})
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Center(child: telas[_bottomIndex]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomIndex,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        onTap: (index) {
          setState(() {
            _bottomIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(label: "Início", icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: "Em alta", icon: Icon(Icons.whatshot)),
          BottomNavigationBarItem(
              label: "Inscrições", icon: Icon(Icons.subscriptions)),
          BottomNavigationBarItem(
              label: "Biblioteca", icon: Icon(Icons.folder)),
        ],
      ),
    );
  }
}
