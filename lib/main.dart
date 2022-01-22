import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ekranlar/anasayfa.dart';
import 'ekranlar/karsilama.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences lokalbilgi = await SharedPreferences.getInstance();
  var oturumAcik = (lokalbilgi.getBool('oturum') == null) ? false : lokalbilgi.getBool('oturum');
  runApp(MaterialApp(
    title: 'Mor',
    theme: ThemeData(
      primarySwatch: Colors.purple,
    ),
    home: oturumAcik ? Anasayfa() : KarsilamaEkrani(),
    debugShowCheckedModeBanner: false,
  ));
}
