// To parse this JSON data, do
//
//     final kategoriArtikel = kategoriArtikelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

KategoriArtikel kategoriArtikelFromJson(String str) =>
    KategoriArtikel.fromJson(json.decode(str));

String kategoriArtikelToJson(KategoriArtikel data) =>
    json.encode(data.toJson());

class KategoriArtikel {
  KategoriArtikel({
    required this.method,
    required this.status,
    required this.results,
  });

  final String method;
  final bool status;
  final List<Result> results;

  factory KategoriArtikel.fromJson(Map<String, dynamic> json) =>
      KategoriArtikel(
        method: json["method"],
        status: json["status"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "method": method,
        "status": status,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    required this.title,
    required this.key,
  });

  final String title;
  final String key;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        title: json["title"],
        key: json["key"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "key": key,
      };
}
