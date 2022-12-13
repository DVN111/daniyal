import 'dart:io';

import 'package:async_programming_futurebuilder_resepmasak/view/cariresepmasakan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import '../model/artikel.dart';
import 'artikel_page.dart';
import 'home.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture:
                CircleAvatar(backgroundColor: Colors.amber[300]),
            accountName: Text("Username"),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 44, 44, 44),
            ),
            accountEmail: Text("+62 xxx-xxxx-xxxx"),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
            ),
            title: const Text('Home'),
            onTap: () {
              Navigator.push(context,
                  PageTransition(child: Home(), type: PageTransitionType.fade));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.search,
            ),
            title: const Text('Cari Resep'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CariResep()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.list,
            ),
            title: const Text('Artikel'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  PageTransition(
                      child: ArtikelPage(), type: PageTransitionType.fade));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app,
            ),
            title: const Text('Exit'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  alignment: Alignment.center,
                  title: Text(
                    "Apakah Kamu Akan Pergi?",
                    style: GoogleFonts.openSans(fontWeight: FontWeight.bold),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  icon: Image.asset(
                    "images/illustration.png",
                    height: 200,
                    width: 200,
                  ),
                  content: Text(
                    "Kuharap kamu jangan pergi lama-lama ya, cepatlah kembali",
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("CANCEL")),
                    TextButton(
                        onPressed: () => SystemNavigator.pop(),
                        child: Text("EXIT")),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
