import 'package:http/http.dart';
import 'package:async_programming_futurebuilder_resepmasak/model/kategoriartikel.dart';

Future<List<Result>> fetchKategoriArtikel() async {
  List<Result> datakategoriartikel;

  Response response = await get(Uri.parse(
      'https://masak-apa-tomorisakura.vercel.app/api/category/article'));

  if (response.statusCode == 200) {
    final kategoriartikel = kategoriArtikelFromJson(response.body);
    Map jsonKategoriArtikel = kategoriartikel.toJson();
    List listKategoriArtikel = jsonKategoriArtikel["results"] as List;
    datakategoriartikel = listKategoriArtikel
        .map<Result>((json) => Result.fromJson(json))
        .toList();
    return datakategoriartikel;
  } else {
    throw Exception('Failed to load data masak');
  }
}
