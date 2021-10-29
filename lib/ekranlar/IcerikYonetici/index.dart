import 'package:flutter/material.dart';
import 'package:flutter_projemiz/ekranlar/IcerikYonetici/Gonderi/Liste.dart';

class IcerikYonetici extends StatefulWidget {
  const IcerikYonetici({key}) : super(key: key);

  @override
  _IcerikYoneticiState createState() => _IcerikYoneticiState();
}

class _IcerikYoneticiState extends State<IcerikYonetici> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("İçerik Yönetici"),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert, color: Colors.white),
          )
        ],
        backgroundColor: Colors.pink[900],
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Anasayfa'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
              leading: Icon(Icons.folder_open),
              title: Text('İçerik Listeleri'),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GonderiListe()))),
          ListTile(
              leading: Icon(Icons.folder_open),
              title: Text('Medya Galeri'),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => IcerikYonetici()))),
          ListTile(
              leading: Icon(Icons.folder_open),
              title: Text('Slaytlar'),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => IcerikYonetici()))),
          ListTile(
              leading: Icon(Icons.folder_open),
              title: Text('Kategoriler'),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => IcerikYonetici()))),
        ],
      ),
    );
  }
}
