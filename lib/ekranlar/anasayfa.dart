import 'package:flutter/material.dart';
import 'package:flutter_projemiz/ekranlar/IcerikYonetici/index.dart';
import 'package:flutter_projemiz/sistem/Kullanici.dart';
import 'package:flutter_projemiz/sistem/globals.dart' as globals;
import 'package:flutter_projemiz/ekranlar/karsilama.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'kayit_ol.dart';
import 'oturum_ac.dart';
import 'profil.dart';

class Anasayfa extends StatefulWidget {
  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  SharedPreferences _lokalbilgi;
  Future<void> _lokalBilgiGuncelle() async {
    SharedPreferences lokalbilgi = await SharedPreferences.getInstance();
    setState(() {
      _lokalbilgi = lokalbilgi;
      if (lokalbilgi.getBool('oturum') != true) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => OturumAc(),
          ),
          (route) => false,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _lokalBilgiGuncelle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Paketler(),
      ),
      appBar: AppBar(
        title: Center(
          child: Image.asset(
            "dosya/logo-renkli.png",
            height: 20,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Profil())),
            icon: Icon(Icons.account_circle, color: Colors.white),
          )
        ],
        backgroundColor: Colors.pink[900],
      ),
      body: Column(
        children: <Widget>[
          Text("Anasayfa İçeriği"),
        ],
      ),
    );
  }
}

class Paketler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Anasayfa'),
          onTap: () => Navigator.pop(context),
        ),
        ListTile(
          leading: Icon(Icons.folder_open),
          title: Text('İçerik Yöneticisi'),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => IcerikYonetici()),
          ),
        )
      ],
    );
  }
}
