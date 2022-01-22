// To parse this JSON data, do
//
//     final ajaxCevap = ajaxCevapFromJson(jsonString);

import 'dart:convert';

AjaxCevap cevapParcala(String str) => AjaxCevap.fromJson(json.decode(str));

class AjaxCevap {
  AjaxCevap({
    this.durum,
    this.veri,
    this.hata,
  });

  final String durum;
  final String veri;
  final List<dynamic> hata;

  factory AjaxCevap.fromJson(Map<String, dynamic> json) => AjaxCevap(
        durum: json["durum"] == null ? null : json["durum"],
        veri: json["veri"] == null ? null : json["veri"],
        hata: json["hata"] == null ? null : List<dynamic>.from(json["hata"].map((x) => x)),
      );
}
