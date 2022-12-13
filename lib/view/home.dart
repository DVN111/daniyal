import 'package:async_programming_futurebuilder_resepmasak/view/cariresepmasakan.dart';
import 'package:flutter/material.dart';
import 'package:async_programming_futurebuilder_resepmasak/view/detailmasak.dart';
import 'package:async_programming_futurebuilder_resepmasak/viewmodel/fetchdatamasak.dart';
import 'package:async_programming_futurebuilder_resepmasak/model/resep.dart';
import 'package:async_programming_futurebuilder_resepmasak/view/drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Let's Cook",
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
      drawer: const DrawerPage(),
      body: FutureBuilder<List<Result>>(
          future: fetchMasakPage(1),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              const Center(
                child: Text('Gagal ambil data...'),
              );
            }
            return snapshot.hasData
                ? ListMasak(masak: snapshot.data)
                : const Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class ListMasak extends StatefulWidget {
  const ListMasak({Key? key, required this.masak}) : super(key: key);
  final List<Result>? masak;

  @override
  State<ListMasak> createState() => _ListMasakState();
}

class _ListMasakState extends State<ListMasak> {
  ScrollController scrollController = ScrollController();
  List<Result>? result;
  int currentPage = 1;

  bool onnotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (scrollController.position.maxScrollExtent > scrollController.offset &&
          scrollController.position.maxScrollExtent - scrollController.offset <=
              25) {
        fetchMasakPage(currentPage + 1).then((value) {
          currentPage = currentPage + 1;
          setState(() {
            result?.addAll(value);
          });
        });
      }
    }
    return true;
  }

  @override
  void initState() {
    result = widget.masak;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: onnotification,
      child: Container(
        color: Color.fromARGB(255, 255, 243, 219),
        padding: EdgeInsets.symmetric(horizontal: 6),
        child: Column(
          children: [
            Container(
              height: 240,
              color: Color.fromARGB(255, 255, 243, 219),
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Card(
                child: Image.asset("images/banner.png"),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Colors.amber[300],
                elevation: 5,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: result!.length,
                controller: scrollController,
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
                          Container(
                            height: 75,
                            padding: const EdgeInsets.all(10.0),
                            child: Image.network(
                              result![index].thumb,
                              fit: BoxFit.fitHeight,
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
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
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
                                    Text(
                                        "Penyajian: ${result![index].serving}"),
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
            ),
          ],
        ),
      ),
    );
  }
}
