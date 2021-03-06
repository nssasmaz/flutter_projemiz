import 'package:flutter/material.dart';
import 'package:flutter_projemiz/ekranlar/oturum_ac.dart';
import 'package:flutter_projemiz/sistem/Kullanici.dart';
import 'package:flutter_projemiz/sistem/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'anasayfa.dart';
import 'oturum_ac.dart';

class SifremiUnuttum extends StatefulWidget {
  @override
  _SifremiUnuttumState createState() => _SifremiUnuttumState();
}

class _SifremiUnuttumState extends State<SifremiUnuttum> {
  final formKullaniciAdi = TextEditingController();
  final formSifre = TextEditingController();

  Future<void> _sifremiSifirla(String _kkod, String _sifre) async {
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => Anasayfa()));
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

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.symmetric(vertical: 50),
              constraints: BoxConstraints(maxWidth: 340),
              width: 340.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    "dosya/logo-renkli.png",
                    width: 200,
                  ),
                  SizedBox(height: 40),
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
                      ],
                    ),
                    decoration: new BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "yada",
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                  SizedBox(height: 20),
                  Container(
                    constraints: BoxConstraints(maxWidth: 340),
                    child: Column(
                      children: [
                        TextField(
                          decoration: new InputDecoration(
                            hintText: 'E-Posta',
                            hintStyle: TextStyle(fontSize: 12.0, color: Colors.grey),
                            contentPadding: EdgeInsets.all(20),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(color: Colors.black87),
                          controller: formKullaniciAdi,
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
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => OturumAc())),
                            child: Text(
                              "Doğrulama Kodum Var",
                              style: TextStyle(color: Colors.white, fontSize: 11),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: ElevatedButton(
                              child: Text(
                                "Doğrulama Kodu Gönder",
                                style: TextStyle(color: Color(0xFF5E0524), fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              onPressed: () async {
                                _sifremiSifirla(formKullaniciAdi.text, formSifre.text);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.orange,
                                padding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                              ),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          )),
    );
  }
}
