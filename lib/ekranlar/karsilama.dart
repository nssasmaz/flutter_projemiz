import 'package:flutter/material.dart';

import 'kayit_ol.dart';
import 'oturum_ac.dart';

class KarsilamaEkrani extends StatefulWidget {
  @override
  _KarsilamaEkraniState createState() => _KarsilamaEkraniState();
}

class _KarsilamaEkraniState extends State<KarsilamaEkrani> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("dosya/arkaplan_oturumac_bordo.jpg"),
            fit: BoxFit.cover,
          ),
          color: Color(0xFF7F2061)),
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset(
            "dosya/logo-amblem-beyaz.png",
            width: 100,
          ),
          SizedBox(
            height: 180,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center, //Center Column contents vertically,
            crossAxisAlignment: CrossAxisAlignment.center, //Center Column contents horizontally,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: ElevatedButton(
                    child: Text(
                      "OTURUM AÇ",
                      style: TextStyle(color: Color(0xFF5E0524), fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OturumAc())),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 40),
                    )),
              ),
              SizedBox(
                height: 90,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: ElevatedButton(
                  child: Text(
                    "Henüz bir hesabın yok ise, Kayıt Ol.",
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => KayitOl())),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 25),
                    shadowColor: Colors.transparent,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
