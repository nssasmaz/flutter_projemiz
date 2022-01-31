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

  Future<List<MenuOge>> _paketListesi() async {
    final SharedPreferences lokalbilgi = await SharedPreferences.getInstance();
    int isletmeId = lokalbilgi.getInt("isletme_id");
    int kullaniciId = lokalbilgi.getInt("kullanici_id");
    List<MenuOge> paketListesi = [];
    paketListesi.add(new MenuOge(
      simge: "home",
      baglanti: "anasayfa",
      baslik: "Anasayfa",
      aciklama: "",
      cssClass: "",
    ));
    try {
      final response = await http.get(
        Uri.parse(
            'https://mor.podkobi.com/ws/p/?i=paketler&i_id=$isletmeId&k_id=$kullaniciId'),
      );

      if (response.statusCode == 200) {
        var sonucPaketler =
            convert.jsonDecode(response.body)["veri"] as Map<String, dynamic>;
        if (sonucPaketler.length > 0) {
          sonucPaketler.forEach((key, deger) {
            paketListesi.add(new MenuOge(
                simge: deger["simge"],
                widget: deger["widget"],
                baglanti: deger["baglanti"],
                baslik: deger["baslik"],
                aciklama: deger["aciklama"],
                cssClass: deger["cssClass"]));
          });
        }
      }
    } catch (e) {
      print("0");
      return null;
    }
    return paketListesi;
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
        child: FutureBuilder(
          future: _paketListesi(),
          builder:
              (BuildContext context, AsyncSnapshot<List<MenuOge>> snapshot) {
            if (snapshot.data == null) {
              return Column(
                children: [
                  Center(
                    child: Text("Yükleniyor..."),
                  )
                ],
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.chevronRight,
                        size: 15.0,
                      ),
                      title: Text(snapshot.data[index].baslik),
                      onTap: () => {
                        print(snapshot.data[index].widget),
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            switch (snapshot.data[index].widget) {
                              case 'Anasayfa':
                                return Anasayfa();
                                break;
                              case 'IcerikAnasayfa':
                                return IcerikYonetici();
                                break;
                              default:
                                return Anasayfa();
                            }
                          }),
                        )
                      },
                    );
                  });
            }
          },
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

class MenuOge {
  MenuOge({
    @required this.simge,
    @required this.widget,
    @required this.baglanti,
    @required this.baslik,
    @required this.aciklama,
    @required this.cssClass,
  });

  final String simge;
  final String widget;
  final String baglanti;
  final String baslik;
  final String aciklama;
  final String cssClass;
}
