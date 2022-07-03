// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:qr_code/pages/decryptor.dart';
import 'package:qr_code/pages/encryptor.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

//variable index pour la selection au niveau du bottom navigation bar
int index = 0;
//tableau des pages
List<Widget> pages = [
  Encryptor(),
  Decryptor()
];

class _IndexState extends State<Index> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          BottomNavigationBarItem(label: "Encryption", icon: Icon(Icons.key)),
          BottomNavigationBarItem(label: "Decryption", icon: Icon(Icons.lock_open))
        ],
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
      ),
      body: pages[index],
    );
  }
}
