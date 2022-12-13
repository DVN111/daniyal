// To parse this JSON data, do
//
//     final artikel = artikelFromJson(jsonString);

// import 'package:meta/meta.dart';
import 'dart:convert';

Artikel artikelFromJson(String str) => Artikel.fromJson(json.decode(str));

String artikelToJson(Artikel data) => json.encode(data.toJson());

class Artikel {
  Artikel({
    required this.method,
    required this.status,
    required this.results,
  });

  final String method;
  final bool status;
  final List<Result> results;

  factory Artikel.fromJson(Map<String, dynamic> json) => Artikel(
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
    required this.url,
    required this.key,
  });

  final String url;
  final String key;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        url: json["url"],
        key: json["key"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "key": key,
      };
}
