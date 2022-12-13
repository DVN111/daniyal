// import 'package:async_programming_futurebuilder_resepmasak/model/artikel.dart';
// import 'package:async_programming_futurebuilder_resepmasak/viewmodel/fetchdetailmasak.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../model/artikel.dart';
import '../viewmodel/fetchdataartikel.dart';
// import '../model/kategoriartikel.dart';
// import '../viewmodel/fetchkategoriartikel.dart';
import 'cariresepmasakan.dart';
import 'drawer.dart';

class ArtikelPage extends StatelessWidget {
  const ArtikelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Artikel",
                style:
                    GoogleFonts.cookie(color: Colors.amber[300], fontSize: 32)),
            InkWell(
              child: Icon(Icons.search),
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: CariResep(),
                        type: PageTransitionType.rightToLeft));
              },
            ),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 44, 44, 44),
      ),
      drawer: DrawerPage(),
      body: FutureBuilder<List<Result>>(
          future: fetchArtikel(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              const Center(
                child: Text('Gagal ambil data...'),
              );
            }
            return snapshot.hasData
                ? TampilArtikel(kategoriartikel: snapshot.data)
                : const Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class TampilArtikel extends StatefulWidget {
  const TampilArtikel({key, required this.kategoriartikel});
  final List<Result>? kategoriartikel;

  @override
  State<TampilArtikel> createState() => _TampilArtikelState();
}

class _TampilArtikelState extends State<TampilArtikel> {
  List<Result>? result;
  @override
  void initState() {
    result = widget.kategoriartikel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 255, 243, 219),
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: result!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: Color.fromARGB(255, 255, 255, 255),
                    elevation: 5,
                    child: Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: InkWell(
                                  onTap: (() =>
                                      launchUrlString(result![index].url)),
                                  child: Text(result![index].key,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
