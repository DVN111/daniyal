import 'package:async_programming_futurebuilder_resepmasak/model/resep.dart';
import 'package:async_programming_futurebuilder_resepmasak/view/detailmasak.dart';
import 'package:async_programming_futurebuilder_resepmasak/viewmodel/fetchdatamasak.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CariResep extends StatefulWidget {
  const CariResep({super.key});

  @override
  State<CariResep> createState() => _CariResepState();
}

class _CariResepState extends State<CariResep> {
  // List<Result>? daftarHasilPencarianResep;
  // late List<Result> listHasilCari;
  TextEditingController controllerCari = TextEditingController();
  late String katakunci;
  late bool prosesCari;
  // bool adaHasil = false;
  // late Widget dialogProgress;

  @override
  Widget build(BuildContext context) {
    // Bagian field pencarian.
    Widget fieldPencarian = Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onSubmitted: (value) {
          setState(() {
            prosesCari = true;
            katakunci = value;
          });
          controllerCari.clear();
        },
        controller: controllerCari,
        textInputAction: TextInputAction.search,
        decoration: const InputDecoration(
            hintText: 'Mau masak apa hari ini?',
            prefixIcon: Icon(Icons.search),
            filled: true,
            fillColor: Colors.white,
            focusColor: Colors.amber,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            )),
      ),
    );

    // Bagian logo pencarian.
    Widget logoCari = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "images/illustration2.png",
            height: 250,
            width: 250,
          ),
        ],
      ),
    );

    // Bagian futurebuilder.
    Widget tampilHasilCari = FutureBuilder<List<Result>>(
      future: fetchCariResep(katakunci),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Gagal ambil data...'),
          );
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData && snapshot.data!.isEmpty) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.warning,
                size: 40,
                color: Colors.grey,
              ),
              Text(
                'Tidak ditemukan',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              )
            ],
          ));
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Menampilkan hasil pencarian ",
                    style: GoogleFonts.openSans(
                        fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    katakunci+" (${snapshot.data!.length.toString()})",
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              ListMasak(result: snapshot.data),
            ],
          ),
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Cari Resep Masakan',
            style: GoogleFonts.cookie(color: Colors.amber[300], fontSize: 32)),
        backgroundColor: Color.fromARGB(255, 44, 44, 44),
      ),
      body: Container(
        color: Color.fromARGB(255, 255, 243, 219),
        child: Column(
          children: [
            fieldPencarian,
            SizedBox(
              height: 15,
            ),
            Expanded(child: (prosesCari == true) ? tampilHasilCari : logoCari),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    katakunci = '';
    prosesCari = false;
  }
}

class ListMasak extends StatelessWidget {
  const ListMasak({Key? key, required this.result}) : super(key: key);
  final List<Result>? result;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: result?.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Detail(
                            result: result![index],
                          )));
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              color: Color.fromARGB(255, 255, 255, 255),
              elevation: 5,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.network(
                      result![index].thumb,
                      // fit: BoxFit.cover,
                      height: 75,
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(result![index].title,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.network_wifi_outlined,
                              color: Colors.orange,
                              size: 18,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Level: ${result![index].difficulty}"),
                          ],
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.fastfood,
                              color: Colors.orange,
                              size: 18,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Penyajian: ${result![index].serving}"),
                          ],
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.timer,
                              color: Colors.orange,
                              size: 18,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Waktu: ${result![index].times}"),
                          ],
                        )
                      ],
                    ),
                  ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
