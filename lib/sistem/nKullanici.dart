// To parse this JSON data, do
//
//     final kullanici = kullaniciFromJson(jsonString);

import 'dart:convert';

Kullanici kullaniciFromJson(String str) => Kullanici.fromJson(json.decode(str));

String kullaniciToJson(Kullanici data) => json.encode(data.toJson());

class Kullanici {
  Kullanici({
    this.id,
    this.isim,
    this.soyisim,
    this.telefon,
    this.resim,
    this.kullaniciAdi,
    this.eposta,
    this.sifre,
    this.kodOnay,
    this.yetki,
    this.pIzin,
    this.pBilgi,
    this.iZaman,
    this.durum,
    this.isletmeId,
  });

  final String id;
  final String isim;
  final String soyisim;
  final String telefon;
  final String resim;
  final String kullaniciAdi;
  final String eposta;
  final String sifre;
  final dynamic kodOnay;
  final String yetki;
  final String pIzin;
  final String pBilgi;
  final DateTime iZaman;
  final String durum;
  final String isletmeId;

  factory Kullanici.fromJson(Map<String, dynamic> json) => Kullanici(
        id: json["id"] == null ? null : json["id"],
        isim: json["isim"] == null ? null : json["isim"],
        soyisim: json["soyisim"] == null ? null : json["soyisim"],
        telefon: json["telefon"] == null ? null : json["telefon"],
        resim: json["resim"] == null ? null : json["resim"],
        kullaniciAdi:
            json["kullanici_adi"] == null ? null : json["kullanici_adi"],
        eposta: json["eposta"] == null ? null : json["eposta"],
        sifre: json["sifre"] == null ? null : json["sifre"],
        kodOnay: json["kod_onay"],
        yetki: json["yetki"] == null ? null : json["yetki"],
        pIzin: json["p_izin"] == null ? null : json["p_izin"],
        pBilgi: json["p_bilgi"] == null ? null : json["p_bilgi"],
        iZaman:
            json["i_zaman"] == null ? null : DateTime.parse(json["i_zaman"]),
        durum: json["durum"] == null ? null : json["durum"],
        isletmeId: json["isletme_id"] == null ? null : json["isletme_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "isim": isim == null ? null : isim,
        "soyisim": soyisim == null ? null : soyisim,
        "telefon": telefon == null ? null : telefon,
        "resim": resim == null ? null : resim,
        "kullanici_adi": kullaniciAdi == null ? null : kullaniciAdi,
        "eposta": eposta == null ? null : eposta,
        "sifre": sifre == null ? null : sifre,
        "kod_onay": kodOnay,
        "yetki": yetki == null ? null : yetki,
        "p_izin": pIzin == null ? null : pIzin,
        "p_bilgi": pBilgi == null ? null : pBilgi,
        "i_zaman": iZaman == null ? null : iZaman.toIso8601String(),
        "durum": durum == null ? null : durum,
        "isletme_id": isletmeId == null ? null : isletmeId,
      };
}
