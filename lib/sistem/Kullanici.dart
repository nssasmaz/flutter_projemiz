// To parse this JSON data, do
//
//     final kullanici = kullaniciFromJson(jsonString);

import 'dart:convert';

class Kullanici {
  Kullanici({
    this.durum,
    this.mesaj,
    this.kId,
    this.kIsim,
    this.kSoyisim,
    this.kKullaniciAdi,
    this.kEposta,
    this.kYetki,
    this.kPIzin,
    this.kDurum,
    this.iId,
    this.iUnvan,
    this.iDurum,
  });

  bool durum;
  String mesaj;
  int kId;
  String kIsim;
  String kSoyisim;
  String kKullaniciAdi;
  String kEposta;
  String kYetki;
  String kPIzin;
  bool kDurum;
  int iId;
  String iUnvan;
  bool iDurum;

  factory Kullanici.fromRawJson(String str) => Kullanici.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Kullanici.fromJson(Map<String, dynamic> json) => Kullanici(
        durum: json["durum"] == null ? null : json["durum"],
        mesaj: json["mesaj"] == null ? null : json["mesaj"],
        kId: json["k_id"] == null ? null : json["k_id"],
        kIsim: json["k_isim"] == null ? null : json["k_isim"],
        kSoyisim: json["k_soyisim"] == null ? null : json["k_soyisim"],
        kKullaniciAdi: json["k_kullanici_adi"] == null ? null : json["k_kullanici_adi"],
        kEposta: json["k_eposta"] == null ? null : json["k_eposta"],
        kYetki: json["k_yetki"] == null ? null : json["k_yetki"],
        kPIzin: json["k_p_izin"] == null ? null : json["k_p_izin"],
        kDurum: json["k_durum"] == null ? null : json["k_durum"],
        iId: json["i_id"] == null ? null : json["i_id"],
        iUnvan: json["i_unvan"] == null ? null : json["i_unvan"],
        iDurum: json["i_durum"] == null ? null : json["i_durum"],
      );

  Map<String, dynamic> toJson() => {
        "durum": durum == null ? null : durum,
        "mesaj": mesaj == null ? null : mesaj,
        "k_id": kId == null ? null : kId,
        "k_isim": kIsim == null ? null : kIsim,
        "k_soyisim": kSoyisim == null ? null : kSoyisim,
        "k_kullanici_adi": kKullaniciAdi == null ? null : kKullaniciAdi,
        "k_eposta": kEposta == null ? null : kEposta,
        "k_yetki": kYetki == null ? null : kYetki,
        "k_p_izin": kPIzin == null ? null : kPIzin,
        "k_durum": kDurum == null ? null : kDurum,
        "i_id": iId == null ? null : iId,
        "i_unvan": iUnvan == null ? null : iUnvan,
        "i_durum": iDurum == null ? null : iDurum,
      };
}
