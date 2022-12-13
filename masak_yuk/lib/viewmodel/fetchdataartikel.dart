import 'package:http/http.dart';
import 'package:async_programming_futurebuilder_resepmasak/model/artikel.dart';
Future<List<Result>> fetchArtikel() async {
  List<Result> dataartikel;

  Response response = await get(
      Uri.parse('https://masak-apa-tomorisakura.vercel.app/api/articles/new'));

  if (response.statusCode == 200) {
    final artikel = artikelFromJson(response.body);
    Map jsonArtikel = artikel.toJson();
    List listArtikel = jsonArtikel["results"] as List;
    dataartikel =
        listArtikel.map<Result>((json) => Result.fromJson(json)).toList();
    return dataartikel;
  } else {
    throw Exception('Failed to load data masak');
  }
}