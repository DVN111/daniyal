
import 'package:http/http.dart';
import 'package:async_programming_futurebuilder_resepmasak/model/detailresep.dart';

Future<DetailMasak> fetchDetailMasak(String judul) async {
  DetailMasak datamasak;

  Response response = await get(Uri.parse(
      'https://masak-apa-tomorisakura.vercel.app/api/recipe/:$judul'));

  if (response.statusCode == 200) {
    final masak = masakFromJson(response.body);
    datamasak = DetailMasak.fromJson(masak.toJson());
    return datamasak;
  } else {
    throw Exception('Failed to load data masak');
  }
}

// Future<Artikel> fetchArticle() async {
//   Artikel dataartikel;

//   Response response = await get(
//       Uri.parse('https://masak-apa-tomorisakura.vercel.app/api/articles/new'));

//   if (response.statusCode == 200) {
//     final artikel = artikelFromJson(response.body);
//     dataartikel = Artikel.fromJson(artikel.toJson());
//     return dataartikel;
//   } else {
//     throw Exception('Failed to load data masak');
//   }
// }


