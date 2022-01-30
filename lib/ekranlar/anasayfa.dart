import 'package:flutter/material.dart';
import 'package:flutter_projemiz/ekranlar/IcerikYonetici/index.dart';
import 'package:flutter_projemiz/sistem/Kullanici.dart';
import 'package:flutter_projemiz/sistem/globals.dart' as globals;
import 'package:flutter_projemiz/ekranlar/karsilama.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        child: ListView(
          children: <Widget>[Paketler()],
        ),
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
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Profil())),
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
  List liste = [];

  @override
  Widget build(BuildContext context) {
    Future<List> _paketleriListele() async {
      final SharedPreferences lokalbilgi =
          await SharedPreferences.getInstance();

      var kullanici_pizin = lokalbilgi.getString("kullanici_pizin").split(',');

      print(kullanici_pizin);

      try {
        final response = await http
            .get(Uri.parse('https://mor.podkobi.com/ws/p/?i=paketler'));

        if (response.statusCode == 200) {
          var sonuc = convert.jsonDecode(response.body) as Map<String, dynamic>;
          var sonucPaketler =
              convert.jsonDecode(sonuc["veri"]) as Map<String, dynamic>;
          print(sonucPaketler.length);
          if (sonucPaketler.length > 0) {
            sonucPaketler.forEach((key, deger) {
              liste.add(new ListTile(
                leading: Icon(Icons.home),
                title: Text(sonucPaketler[key]['baslik']),
                onTap: () => Navigator.pop(context),
              ));
            });
          }
        }

        return liste;
      } catch (e) {
        print("Başarısız Oldu! $e");
        return null;
      }
    }

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
