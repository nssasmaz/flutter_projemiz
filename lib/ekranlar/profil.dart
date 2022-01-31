import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'oturum_ac.dart';

class Profil extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  SharedPreferences _lokalbilgi;
  Future<void> _lokalBilgiGuncelle() async {
    SharedPreferences lokalbilgi = await SharedPreferences.getInstance();
    setState(() {
      _lokalbilgi = lokalbilgi;
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
      body: ListView(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  CircleAvatar(
                      radius: 40.0,
                      backgroundImage: _lokalbilgi?.getBool('oturum')
                          ? NetworkImage(
                              "https://mor.podkobi.com/ws/p/?i=profilFotografi&k_id=" +
                                  _lokalbilgi
                                      ?.getInt("kullanici_id")
                                      .toString())
                          : AssetImage('dosya/profil.png')),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    _lokalbilgi?.getBool('oturum') == true
                        ? (_lokalbilgi?.getString('kullanici_isim') +
                            ' ' +
                            _lokalbilgi?.getString('kullanici_soyisim'))
                        : 'İsim Yok',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('dosya/arkaplan_oturumac_bordo.jpg'),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Anasayfa'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Bilgileri Güncelle'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.security),
            title: Text('Şifremi Güncelle'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Çıkış Yap'),
            onTap: () => {
              setState(() {
                _lokalbilgi.setBool("oturum", false); // Oturum Kapalı
                _lokalbilgi.remove("isletme_id");
                _lokalbilgi.remove("kullanici_id");
                _lokalbilgi.remove("kullanici_isim");
                _lokalbilgi.remove("kullanici_soyisim");
                _lokalbilgi.remove("kullanici_eposta");
              }),
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => OturumAc()),
                  (Route<dynamic> route) => false)
            },
          ),
        ],
      ),
    );
  }
}
/*

Column(
          children: [
            SizedBox(height: 20),
            Text("Kullanıcı Profili"),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(29),
                child: ElevatedButton(
                  child: Text(
                    "Oturum Kapat",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () => {
                    setState(() {
                      _lokalbilgi.setBool("oturum", false); // Oturum Kapalı
                      _lokalbilgi.remove("isletme_id");
                      _lokalbilgi.remove("kullanici_id");
                      _lokalbilgi.remove("kullanici_isim");
                      _lokalbilgi.remove("kullanici_soyisim");
                      _lokalbilgi.remove("kullanici_eposta");
                    }),
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OturumAc())),
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      textStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
                ),
              ),
            )
          ],
        ));

*/
