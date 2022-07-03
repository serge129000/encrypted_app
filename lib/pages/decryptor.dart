// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Decryptor extends StatefulWidget {
  const Decryptor({Key? key}) : super(key: key);

  @override
  State<Decryptor> createState() => _DecryptorState();
}

List messages = [];
String? _message;
//
TextEditingController cles = TextEditingController();
TextEditingController encrypted = TextEditingController();

//
class _DecryptorState extends State<Decryptor> {
  //search meaasge

  searchMsg(String cles, String encrypted) async {
    var test = await http.post(Uri.parse("http://10.0.2.2/crp/req.php"), body: {
      "cles": cles,
      "encrypted": encrypted,
    });
    setState(() {
      messages = jsonDecode(test.body);
    });
    for (var element in messages) {
      setState(() {
        _message = element["message"].toString();
      });
      print(_message);
    }
  }

  @override
  void initState() {
    //searchMsg();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double textscale = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "DECRYPTOR",
          style: GoogleFonts.poppins(
              fontSize: textscale * 20,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 25, right: 10),
              child: Text(
                "DECRYPTER UN MESSAGE",
                style: GoogleFonts.poppins(
                    fontSize: textscale * 22, fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20, left: 25, right: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  TextField(
                    controller: encrypted,
                    style: GoogleFonts.poppins(color: Colors.grey[900]),
                    maxLines: 10,
                    decoration: InputDecoration(
                        hintText: "Entrer le texte crypte",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(color: Colors.black))),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  TextField(
                    controller: cles,
                    maxLines: 3,
                    style: GoogleFonts.poppins(color: Colors.grey[900]),
                    decoration: InputDecoration(
                        hintText: "Entrer la cle",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(color: Colors.black))),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: width,
                    child: ElevatedButton(
                        onPressed: () {
                          if (cles.text == "" || encrypted.text == "") {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                "Entrez au minimum un caractere",
                                style: GoogleFonts.poppins(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                            ));
                          } else {
                            searchMsg(cles.text, encrypted.text);
                            Timer(Duration(seconds: 1), () {
                             _message != null? showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(30))),
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) => showModal(
                                      height, width, textscale, _message!)):showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(30))),
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) => showModal(
                                      height, width, textscale, "Code d'encryption introuvable"));
                            });
                          }
                        },
                        child: Text("DECRYPTER")),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  showModal(double height, double width, double textscale, String message) {
    //print(_encrypted);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          margin: EdgeInsets.only(left: 30, right: 30),
          padding: EdgeInsets.only(left: 10, right: 10),
          height: height / 4,
          width: width,
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Column(
            children: [
              Text(
                "Message Encrypte",
                style: GoogleFonts.poppins(
                    color: Colors.red, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 50,
              ),
              Text(message, style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600
            ),)
            ],
          ),
        ),
        SizedBox(
          height: 50,
        )
      ],
    );
  }
}
