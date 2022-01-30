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
            ),
          ],
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
    Future<List<Widget>> _paketleriListele() async {
      final SharedPreferences lokalbilgi = await SharedPreferences.getInstance();
      int isletme_id = lokalbilgi.getInt("isletme_id");
      int kullanici_id = lokalbilgi.getInt("kullanici_id");
      List<Widget> paketListesi = [];

      try {
        final response = await http.get(Uri.parse('https://mor.podkobi.com/ws/p/?i=paketler&i_id=$isletme_id&k_id=$kullanici_id'));

        if (response.statusCode == 200) {
          var sonuc = convert.jsonDecode(response.body) as Map<String, dynamic>;
          var sonucPaketler = convert.jsonDecode(sonuc["veri"]) as Map<String, dynamic>;
          print(sonucPaketler.length);
          if (sonucPaketler.length > 0) {
            paketListesi = sonuc["veri"].map((data) => MenuOge.fromJson(data)).toList();

            sonucPaketler.forEach((key, deger) {
              paketListesi.add(new ListTile(
                leading: Icon(Icons.home),
                title: Text(sonucPaketler[key]['baslik']),
                onTap: () => Navigator.pop(context),
              ));
            });
          }
        }
      } catch (e) {
        print("Başarısız Oldu! $e");
      }
      return paketListesi;
    }

    var sonuc = _paketleriListele();

    print(sonuc);

    /*

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
        ),
      ],
    );

    */
  }
}

class MenuOge {
  MenuOge({
    this.simge,
    this.baglanti,
    this.baslik,
    this.aciklama,
    this.cssClass,
    this.altOgeler,
  });

  String simge;
  String baglanti;
  String baslik;
  String aciklama;
  String cssClass;
  List<dynamic> altOgeler;

  factory MenuOge.fromRawJson(String str) => MenuOge.fromJson(convert.jsonDecode(str));

  String toRawJson() => convert.jsonEncode(toJson());

  factory MenuOge.fromJson(Map<String, dynamic> json) => MenuOge(
        simge: json["simge"] == null ? null : json["simge"],
        baglanti: json["baglanti"] == null ? null : json["baglanti"],
        baslik: json["baslik"] == null ? null : json["baslik"],
        aciklama: json["aciklama"] == null ? null : json["aciklama"],
        cssClass: json["css_class"] == null ? null : json["css_class"],
        altOgeler: json["alt_ogeler"] == null ? null : List<dynamic>.from(json["alt_ogeler"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "simge": simge == null ? null : simge,
        "baglanti": baglanti == null ? null : baglanti,
        "baslik": baslik == null ? null : baslik,
        "aciklama": aciklama == null ? null : aciklama,
        "css_class": cssClass == null ? null : cssClass,
        "alt_ogeler": altOgeler == null ? null : List<dynamic>.from(altOgeler.map((x) => x)),
      };
}
