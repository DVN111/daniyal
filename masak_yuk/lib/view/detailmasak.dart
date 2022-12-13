import 'package:flutter/material.dart';
import 'package:async_programming_futurebuilder_resepmasak/model/resep.dart';
import 'package:async_programming_futurebuilder_resepmasak/model/detailresep.dart';
import 'package:async_programming_futurebuilder_resepmasak/viewmodel/fetchdetailmasak.dart';
import 'package:google_fonts/google_fonts.dart';

class Detail extends StatelessWidget {
  const Detail({Key? key, required this.result}) : super(key: key);
  final Result result;

  @override
  Widget build(BuildContext context) {
    String judul = result.key;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cara Memasak',
          style: GoogleFonts.cookie(color: Colors.amber[300], fontSize: 32),
        ),
        backgroundColor: Color.fromARGB(255, 44, 44, 44),
      ),
      body: FutureBuilder<DetailMasak>(
          future: fetchDetailMasak(judul),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              const Center(
                child: Text('Gagal ambil data...'),
              );
            }
            return snapshot.hasData
                ? TampilCaraMasak(datadetailmasak: snapshot.data)
                : const Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class TampilCaraMasak extends StatelessWidget {
  const TampilCaraMasak({Key? key, required this.datadetailmasak})
      : super(key: key);
  final DetailMasak? datadetailmasak;
  final bool? gambar = true;

  @override
  Widget build(BuildContext context) {
    // Bagian gambar.
    Widget bagianGambar = (datadetailmasak!.results.thumb != null)
        ? Image.network(
            datadetailmasak!.results.thumb,
            width: 600,
            fit: BoxFit.cover,
          )
        : Image.asset(
            'asset/gambar/Gambar-tidak-tersedia.png',
            width: 600,
            fit: BoxFit.cover,
          );

    // Widget bagian judul.
    Widget bagianJudul = Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(datadetailmasak!.results.title,
                      style: Theme.of(context).textTheme.headline6),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Color.fromARGB(0, 0, 0, 0)),
                              borderRadius: BorderRadius.circular(15),
                              color: Color.fromARGB(255, 44, 44, 44)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.network_wifi_outlined,
                                color: Colors.amber[300],
                                size: 18,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(datadetailmasak!.results.difficulty,
                                  style: TextStyle(color: Colors.white)),
                            ],
                          )),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Color.fromARGB(0, 0, 0, 0)),
                              borderRadius: BorderRadius.circular(15),
                              color: Color.fromARGB(255, 44, 44, 44)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.fastfood,
                                color: Colors.amber[300],
                                size: 18,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(datadetailmasak!.results.servings,
                                  style: TextStyle(color: Colors.white)),
                            ],
                          )),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Color.fromARGB(0, 0, 0, 0)),
                              borderRadius: BorderRadius.circular(15),
                              color: Color.fromARGB(255, 44, 44, 44)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.timer,
                                color: Colors.amber[300],
                                size: 18,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(datadetailmasak!.results.times,
                                  style: TextStyle(color: Colors.white)),
                            ],
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

    // Widget bagian deskripsi.
    Widget bagianDeskripsi = Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 10),
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 44, 44, 44),
            ),
            child: Text(
              "Deskripsi",
              style:
                  GoogleFonts.openSans(fontSize: 20, color: Colors.amber[300]),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            datadetailmasak!.results.desc,
            style: const TextStyle(height: 1.5, fontSize: 14),
            softWrap: true,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );

    // Bagian bahan-bahan
    List<String>? itemBahan = datadetailmasak!.results.ingredient;
    Widget bagianBahan = Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 10),
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 44, 44, 44),
            ),
            child: Text(
              'Bahan-bahan:',
              style:
                  GoogleFonts.openSans(fontSize: 20, color: Colors.amber[300]),
            ),
          ),
        ),
        Column(
          children: itemBahan.map((bahan) {
            return ListTile(
              title: Text(
                bahan,
                style: const TextStyle(height: 1.5, fontSize: 14),
              ),
            );
          }).toList(),
        ),
      ],
    );

    // Bagian cara masak
    List<String>? itemTahap = datadetailmasak!.results.step;
    Widget bagianTahap = Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 10),
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 44, 44, 44),
            ),
            child: Text(
              'Langkah-langkahs:',
              style: GoogleFonts.openSans(fontSize: 20, color: Colors.amber[300]),
            ),
          ),
        ),
        Column(
          children: itemTahap.map((cara) {
            return ListTile(
              title: Text(
                cara,
                style: const TextStyle(height: 1.5, fontSize: 14),
              ),
            );
          }).toList(),
        ),
      ],
    );

    return Scaffold(
      body: ListView(
        children: <Widget>[
          // Bagian gambar
          bagianGambar,
          // Bagian judul
          bagianJudul,
          // Bagian deskripsi
          bagianDeskripsi,
          // Bagian bahan
          bagianBahan,
          // Bagian tahap
          bagianTahap,
        ],
      ),
    );
  }
}
