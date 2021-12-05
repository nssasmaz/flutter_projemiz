import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OturumAc2 extends StatefulWidget {
  @override
  _OturumAcState createState() => _OturumAcState();
}

class _OturumAcState extends State<OturumAc2> {
  @override
  Widget build(BuildContext context) {
    final kullaniciAdi = new TextEditingController();
    final sifre = new TextEditingController();

    bool hata, islem_devam, basarili;
    String sonuc_mesaj;

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
                        controller: kullaniciAdi,
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
                        controller: sifre,
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
                                var request = http.MultipartRequest(
                                    'POST',
                                    Uri.parse(
                                        'http://mor.podkobi.com/webservis_panel/oturum.php?i=oturum-ac'));
                                request.fields.addAll({
                                  'kullanici_adi': kullaniciAdi.text,
                                  'sifre': sifre.text
                                });
/*
                                var headers = {
                                  'Cookie':
                                  'PHPSESSID=cvn198iugevio3ocek99gk98u6'
                                };
                                request.headers.addAll(headers);


 */

                                http.StreamedResponse response =
                                    await request.send();

                                if (response.statusCode == 200) {
                                  sonuc_mesaj =
                                      await response.stream.bytesToString();
                                } else {
                                  sonuc_mesaj = response.reasonPhrase;
                                }

                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Oturum Açma İşlemi"),
                                      content: Text("Sonuç : ${sonuc_mesaj}"),
                                      actions: [
                                        TextButton(
                                          child: Text("KAPAT"),
                                          onPressed: () {
                                            Navigator.pop(context, true);
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
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
