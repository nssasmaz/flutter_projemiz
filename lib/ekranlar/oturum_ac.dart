import 'package:flutter/material.dart';
import 'package:flutter_projemiz/sistem/nKullanici.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:io';

class OturumAc2 extends StatefulWidget {
  @override
  _OturumAcState createState() => _OturumAcState();
}

class _OturumAcState extends State<OturumAc2> {
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
        // GET METODU
        var request = http.Request(
            'GET',
            Uri.parse(
                'http://profesor.elazig.yerel/ajax.php?islem=oturumAc&kullanici_kodu=' +
                    _kkod +
                    '&sifre=' +
                    _sifre));

        /*
    // POST METODU
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://profesor.elazig.yerel/ajax.php'));
    request.fields.addAll({'kullanici_adi': 'nssasmaz', 'sifre': 'tmf7qkckct'});
    */

        http.StreamedResponse response = await request.send();
        if (response.statusCode == 200) {
          var sonucJSON = await response.stream.bytesToString();
          var sonuc = convert.jsonDecode(sonucJSON) as Map<String, dynamic>;
          print(sonuc);
          if (sonuc['durum'] == "tamam") {
            setState(() {
              _Kullanici = Kullanici.fromJson(sonuc['veri']);
              _oturum_durumu = true;
            });
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  // Retrieve the text the that user has entered by using the
                  // TextEditingController.
                  content: Text(sonuc['veri']['isim']),
                );
              },
            );
          } else {
            print(sonuc['hata']);
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(sonuc['hata'][0]['baslik']),
                  // Retrieve the text the that user has entered by using the
                  // TextEditingController.
                  content: Text(sonuc['hata'][0]['aciklama']),
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
            height: boyut.height,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("dosya/arkaplan.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Positioned(
                    top: boyut.height * 0.3,
                    width: boyut.width,
                    child: Center(child: Image.asset("dosya/logo-white.png"))),
                Positioned(
                  top: boyut.height * 0.4,
                  width: boyut.width * 0.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextField(
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 0.0),
                            ),
                            border: OutlineInputBorder(),
                            hintStyle:
                                TextStyle(fontSize: 16.0, color: Colors.white),
                            labelStyle:
                                TextStyle(fontSize: 16.0, color: Colors.white),
                            labelText: 'Kullanıcı Adı'),
                        controller: formKullaniciAdi,
                      ),
                      SizedBox(height: 20),
                      TextField(
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        obscureText: true,
                        decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 0.0),
                            ),
                            border: OutlineInputBorder(),
                            hintStyle:
                                TextStyle(fontSize: 16.0, color: Colors.white),
                            labelStyle:
                                TextStyle(fontSize: 16.0, color: Colors.white),
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 20),
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
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
                                _oturumAc(
                                    formKullaniciAdi.text, formSifre.text);
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.pink,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 20),
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
              ],
            )));
  }
}
