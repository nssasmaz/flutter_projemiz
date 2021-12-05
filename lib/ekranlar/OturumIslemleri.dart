import 'package:flutter/material.dart';
import 'package:flutter_projemiz/main.dart';
import 'package:flutter_projemiz/sistem/AjaxCevap.dart';
import 'package:flutter_projemiz/sistem/globals.dart';
import 'package:flutter_projemiz/sistem/nKullanici.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_projemiz/sistem/globals.dart' as globals;

class OturumAc extends StatefulWidget {
  const OturumAc({key}) : super(key: key);

  @override
  _OturumAcState createState() => _OturumAcState();
}

class _OturumAcState extends State<OturumAc> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _formKulaniciAdi = new TextEditingController();
    final TextEditingController _formSifre = new TextEditingController();

    bool hata, islemDevam, basarili;
    String sonucMesaj;

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
                  width: 400,
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextField(
                          controller: _formKulaniciAdi,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.orangeAccent, width: 0.0),
                              ),
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusColor: Colors.white,
                              hintStyle: TextStyle(
                                  fontSize: 16.0, color: Colors.orangeAccent),
                              hintText: 'Kullanıcı Adı'),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          obscureText: true,
                          controller: _formSifre,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.orangeAccent, width: 0.0),
                              ),
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusColor: Colors.white,
                              hintStyle: TextStyle(
                                  fontSize: 16.0, color: Colors.orangeAccent),
                              hintText: 'Şifre'),
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
                                  style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () async {
                                  var request = http.MultipartRequest(
                                      'POST',
                                      Uri.parse(
                                          'https://mor.podkobi.com/webservis_panel/oturum.php'));
                                  request.fields.addAll({
                                    'i': 'oturum-ac',
                                    'kullanici_adi': _formKulaniciAdi.text,
                                    'sifre': _formSifre.text
                                  });
                                  http.StreamedResponse response =
                                      await request.send();

                                  if (response.statusCode == 200) {
                                    sonucMesaj =
                                        await response.stream.bytesToString();

                                    dynamic oturum;

                                    try {
                                      oturum = CevapParcala(sonucMesaj);
                                    } catch (e) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Oturum Açılamadı!"),
                                            content: Text(
                                                "Gelen veri doğrulanamadı! {$sonucMesaj}"),
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
                                    }

                                    if (oturum != null) {
                                      if (oturum.durum == 'hata') {
                                        oturum.hata.asMap().forEach((index,
                                                hataMesaj) =>
                                            {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                      hataMesaj[0],
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    content: Text(
                                                      hataMesaj[2],
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        child: Text(
                                                          "KAPAT",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context, true);
                                                        },
                                                      ),
                                                    ],
                                                    backgroundColor:
                                                        hataMesaj[1] == 'danger'
                                                            ? Colors.red
                                                            : Colors.white,
                                                  );
                                                },
                                              )
                                            });
                                      } else {
                                        if (oturum.veri != null) {
                                          print(oturum.veri);
                                          int kullaniciId = 0;
                                          try {
                                            nKullanici =
                                                kullaniciFromJson(oturum.veri);
                                            kullaniciId =
                                                int.parse(nKullanici.id) ?? 0;
                                          } catch (e) {
                                            kullaniciId = 0;
                                            print("Hata");
                                          }
                                          print(kullaniciId);
                                          if (kullaniciId > 0) {
                                            setState(() {
                                              globals.nKullanici = nKullanici;
                                              globals.oturumAcik = true;
                                            });
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        GirisEkrani()));
/*
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(
                                                      "Merhaba ${nKullanici.isim}"),
                                                  content: Text(
                                                      nKullanici.isletmeId),
                                                  actions: [
                                                    TextButton(
                                                      child: Text("KAPAT"),
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context, true);
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );

 */
                                          }
                                        }
                                      }
                                    }
                                  } else {
                                    sonucMesaj = response.reasonPhrase;
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Oturum Açılamadı!"),
                                          content: Text(sonucMesaj),
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
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.orangeAccent,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 20),
                                    textStyle: TextStyle(
                                        color: Colors.deepPurple,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ],
                        ))
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}
