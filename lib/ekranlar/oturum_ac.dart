import 'package:flutter/material.dart';
import 'package:flutter_projemiz/parcalar/form_input.dart';

class OturumAc extends StatefulWidget {
  @override
  _OturumAcState createState() => _OturumAcState();
}

class _OturumAcState extends State<OturumAc> {
  @override
  Widget build(BuildContext context) {
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
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Logo
                        Container(
                            child: const TextField(
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 0.0),
                              ),
                              border: OutlineInputBorder(),
                              hintStyle: TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                              labelStyle: TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                              labelText: 'Kullanıcı Adı'),
                        )),
                        SizedBox(height: 20),

                        // Form
                        Container(
                            child: const TextField(
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          obscureText: true,
                          decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 0.0),
                              ),
                              border: OutlineInputBorder(),
                              hintStyle: TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                              labelStyle: TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                              labelText: 'Şifre'),
                        )),
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
                                onPressed: () {},
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
                ),
              ],
            )));
  }
}
