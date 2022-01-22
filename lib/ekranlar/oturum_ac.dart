import 'package:flutter/material.dart';
import 'package:flutter_projemiz/ekranlar/anasayfa.dart';
import 'package:flutter_projemiz/ekranlar/karsilama.dart';
import 'package:flutter_projemiz/ekranlar/kayit_ol.dart';
import 'package:flutter_projemiz/sistem/Kullanici.dart';
import 'package:flutter_projemiz/ekranlar/sifremi_unuttum.dart';
import 'package:flutter_projemiz/sistem/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class OturumAc extends StatefulWidget {
  @override
  _OturumAcState createState() => _OturumAcState();
}

class _OturumAcState extends State<OturumAc> {
  @override
  Widget build(BuildContext context) {
    final formKullaniciAdi = TextEditingController();
    final formSifre = TextEditingController();

    Kullanici kBilgi;

    Future<void> _oturumAc(String _kkod, String _sifre) async {
      final SharedPreferences lokalbilgi = await SharedPreferences.getInstance();
      if (_kkod == '' || _sifre == '') {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Kullanıcı adı veya şifre boş olamaz!"),
            );
          },
        );
      } else {
        /*
        // GET METODU
        var request = http.Request(
            'GET', Uri.parse('http://mor.podkobi.com/webservis_panel/servis.php?i=oturum_ac&kullanici_kodu=' + _kkod + '&sifre=' + _sifre));

    */
        // POST METODU
        var request = http.MultipartRequest('POST', Uri.parse('https://mor.podkobi.com/ws/p/'));
        request.fields.addAll({'i': 'oturum-ac', 'kullanici_adi': _kkod, 'sifre': _sifre});

        http.StreamedResponse response = await request.send();
        if (response.statusCode == 200) {
          var sonucJSON = await response.stream.bytesToString();
          var sonuc = convert.jsonDecode(sonucJSON) as Map<String, dynamic>;
          if (sonuc['durum'] == "tamam") {
            setState(() {
              kBilgi = Kullanici.fromJson(sonuc['veri']);
              lokalbilgi.setBool("oturum", true); // Oturum Açık
              lokalbilgi.setInt("isletme_id", kBilgi.iId);
              lokalbilgi.setInt("kullanici_id", kBilgi.kId);
              lokalbilgi.setString("kullanici_isim", kBilgi.kIsim);
              lokalbilgi.setString("kullanici_soyisim", kBilgi.kSoyisim);
              lokalbilgi.setString("kullanici_eposta", kBilgi.kEposta);
            });
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Anasayfa()));
            /*
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  // Retrieve the text the that user has entered by using the
                  // TextEditingController.
                  content: Text(globals.nKullanici.kIsim),
                );
              },
            );
            */
          } else {
            globals.oturumAcik = false;
            lokalbilgi.setBool("oturum", false); // Oturum Açık
            print(sonuc['hata']);
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(sonuc['hata'][0]),
                  // Retrieve the text the that user has entered by using the
                  // TextEditingController.
                  content: Text(sonuc['hata'][2]),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Tamam'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        }
      }
    }

    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("dosya/arkaplan_oturumac_bordo.jpg"),
                  fit: BoxFit.cover,
                ),
                color: Color(0xFF7F2061)),
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(0),
            width: double.maxFinite,
            constraints: BoxConstraints.expand(),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 100),
                constraints: BoxConstraints(maxWidth: 340),
                width: 340.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      "dosya/logo-renkli.png",
                      width: 200,
                    ),
                    SizedBox(height: 150),
                    Container(
                      constraints: BoxConstraints(maxWidth: 340),
                      child: Column(
                        children: [
                          TextField(
                            decoration: new InputDecoration(
                              hintText: 'Kullanıcı Adı',
                              hintStyle: TextStyle(fontSize: 12.0, color: Colors.grey),
                              contentPadding: EdgeInsets.all(20),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(color: Colors.black87),
                            controller: formKullaniciAdi,
                          ),
                          TextField(
                            decoration: new InputDecoration(
                              hintText: 'Şifre',
                              hintStyle: TextStyle(fontSize: 12.0, color: Colors.grey),
                              contentPadding: EdgeInsets.all(20),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(color: Colors.black26),
                            controller: formSifre,
                            obscureText: true,
                          ),
                        ],
                      ),
                      decoration: new BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white),
                    ),
                    SizedBox(height: 40),

                    // Butonlar
                    Container(
                        constraints: BoxConstraints(maxWidth: 300),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SifremiUnuttum())),
                              child: Text(
                                "Şifremi Unuttum",
                                style: TextStyle(color: Colors.white, fontSize: 11),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                              child: Text(
                                "|",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => KayitOl())),
                              child: Text(
                                "Kayıt Ol",
                                style: TextStyle(color: Colors.white, fontSize: 11),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: ElevatedButton(
                                child: Text(
                                  "OTURUM AÇ",
                                  style: TextStyle(color: Color(0xFF5E0524), fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                                onPressed: () async {
                                  _oturumAc(formKullaniciAdi.text, formSifre.text);
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.orange,
                                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 25),
                                ),
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            )));
  }
}
