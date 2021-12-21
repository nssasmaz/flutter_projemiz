import 'package:flutter/material.dart';
import 'package:flutter_projemiz/sistem/Kullanici.dart';
import 'package:flutter_projemiz/sistem/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:io';

import '../main.dart';

class OturumAc extends StatefulWidget {
  @override
  _OturumAcState createState() => _OturumAcState();
}

class _OturumAcState extends State<OturumAc> {
  @override
  Widget build(BuildContext context) {
    bool _oturum_durumu = false;
    Kullanici _Kullanici;
    var sonuc = null;

    final formKullaniciAdi = TextEditingController();
    final formSifre = TextEditingController();

    void _oturumAc(String _kkod, String _sifre) async {
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
        var request = http.MultipartRequest('POST', Uri.parse('https://mor.podkobi.com/webservis_panel/servis.php'));
        request.fields.addAll({'i': 'oturum-ac', 'kullanici_adi': _kkod, 'sifre': _sifre});

        http.StreamedResponse response = await request.send();
        if (response.statusCode == 200) {
          var sonucJSON = await response.stream.bytesToString();
          var sonuc = convert.jsonDecode(sonucJSON) as Map<String, dynamic>;
          if (sonuc['durum'] == "tamam") {
            print(sonuc['veri']);
            setState(() {
              globals.nKullanici = Kullanici.fromJson(sonuc['veri']);
              globals.oturumAcik = true;
            });
            Navigator.push(context, MaterialPageRoute(builder: (context) => GirisEkrani()));
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
          } else {
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

    Size boyut = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(color: Color(0xFF7F2061)),
            padding: const EdgeInsets.all(140),
            margin: const EdgeInsets.all(0),
            width: double.maxFinite,
            child: Container(
              width: 340,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset("dosya/logo-white.png"),
                  SizedBox(height: 30),
                  TextField(
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white, width: 0.0),
                        ),
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
                        labelStyle: TextStyle(fontSize: 16.0, color: Colors.white),
                        labelText: 'Kullanıcı Adı'),
                    controller: formKullaniciAdi,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    obscureText: true,
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white, width: 0.0),
                        ),
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
                        labelStyle: TextStyle(fontSize: 16.0, color: Colors.white),
                        labelText: 'Şifre'),
                    controller: formSifre,
                  ),
                  SizedBox(height: 30),
                  // Butonlar
                  Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(29),
                        child: ElevatedButton(
                          child: Text(
                            "İptal",
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                              textStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(29),
                        child: ElevatedButton(
                          child: Text(
                            "Oturum Aç",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            _oturumAc(formKullaniciAdi.text, formSifre.text);
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.pink,
                              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                              textStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ],
                  ))
                ],
              ),
            )));
  }
}
