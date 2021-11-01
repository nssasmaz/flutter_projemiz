import 'package:flutter/material.dart';

class GonderiListe extends StatefulWidget {
  const GonderiListe({key}) : super(key: key);

  @override
  _GonderiListeState createState() => _GonderiListeState();
}

class _GonderiListeState extends State<GonderiListe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("İçerik Listeleri"),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert, color: Colors.white),
          )
        ],
        backgroundColor: Colors.pink[900],
      ),
      body: Container(
        child: Text("Test"),
      ),
    );
  }
}
