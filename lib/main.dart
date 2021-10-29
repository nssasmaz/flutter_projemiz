import 'package:flutter/material.dart';
import 'package:flutter_projemiz/ekranlar/oturum_ac.dart';
import 'package:flutter_projemiz/ekranlar/profil.dart';
import 'package:flutter_projemiz/ekranlar/IcerikYonetici/index.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uygulama v1',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: GirisEkrani(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class GirisEkrani extends StatefulWidget {
  @override
  _GirisEkraniState createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenuIcerik(),
      appBar: AppBar(
        title: Image.asset(
          "dosya/logo-white.png",
          height: 30,
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Profil())),
            icon: Icon(Icons.account_circle, color: Colors.white),
          ),
          IconButton(
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => OturumAc())),
            icon: Icon(Icons.login, color: Colors.white),
          )
        ],
        backgroundColor: Colors.pink[900],
      ),
      body: Column(
        children: <Widget>[
          Text(
            'Burası giriş sayfamız',
          )
        ],
      ),
    );
  }
}

class SideMenuIcerik extends StatelessWidget {
  const SideMenuIcerik({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40.0,
                  backgroundImage: AssetImage(
                    'dosya/profil.png',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Nursin Şaşmaz",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill, image: AssetImage('dosya/arkaplan.jpg'))),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Anasayfa'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
              leading: Icon(Icons.folder_open),
              title: Text('İçerik Yöneticisi'),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => IcerikYonetici()))),
        ],
      ),
    );
  }
}
