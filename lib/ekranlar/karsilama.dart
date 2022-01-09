import 'package:flutter/material.dart';

import 'oturum_ac.dart';

class KarsilamaEkrani extends StatefulWidget {
  @override
  _KarsilamaEkraniState createState() => _KarsilamaEkraniState();
}

class _KarsilamaEkraniState extends State<KarsilamaEkrani> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFF7F2061)),
      padding: const EdgeInsets.symmetric(vertical: 140, horizontal: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset(
            "dosya/logo-white-2.png",
            width: 180,
          ),
          SizedBox(
            height: 150,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(29),
            child: ElevatedButton(
              child: Text(
                "BAŞLA",
                style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.w700),
              ),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => OturumAc())),
              style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
            ),
          ),
        ],
      ),
    );
  }
}
