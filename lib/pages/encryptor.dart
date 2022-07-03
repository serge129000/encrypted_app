// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:qr_code/algorithmes/encrypt.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Encryptor extends StatefulWidget {
  const Encryptor({Key? key}) : super(key: key);

  @override
  State<Encryptor> createState() => _EncryptorState();
}

//secondes de chargement
int seconds = 2;
//random ints
int? rd0, rd1, rd2;
int rd3 = 0;
int rd4 = 0;
int rd5 = 0;
//
String key = "";
String _encrypted = "";
//TextEditingConteoller
TextEditingController text = TextEditingController();

class _EncryptorState extends State<Encryptor> {
  //apply random number to var
  Random rd = Random();
  //checker la connectivite et inserer les donnees
  checkC(String encrypted) async {
    //var _key;
    try {
      //insertion des donnees dans la base de donnees et retourner le key sous encodage json
      var test =
          await http.post(Uri.parse("http://10.0.2.2/crp/crp.php"), body: {
        "message": text.text,
        "encrypted": encrypted,
      });
      //_test = test;
      setState(() {
        key = jsonDecode(test.body);
      });
      //print(_key);
    } catch (e) {
      print(e);
    }
    //return _key;
  }

  @override
  void initState() {
    //checkC();
    //print("encryptor");
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
          "ENCRYPTOR",
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
                "ENCRYPTER UN MESSAGE",
                style: GoogleFonts.poppins(
                    fontSize: textscale * 22, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: height / 15,
            ),
            Container(
              padding: EdgeInsets.only(left: 25, right: 25),
              child: TextField(
                controller: text,
                style: GoogleFonts.poppins(
                    fontSize: textscale * 15, color: Colors.grey[800]),
                decoration: InputDecoration(
                    hintText: "Entrer le message",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.black))),
                maxLines: 10,
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: Container(
                width: width,
                child: ElevatedButton(
                    onPressed: () {
                      if (text.text == "") {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "Entrez au minimum un caractere",
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ));
                      } else {
                        setState(() {
                          //valeur random
                          rd0 = rd.nextInt(23);
                          rd1 = rd.nextInt(23);
                          rd2 = rd.nextInt(14);
                          _encrypted = encryptData(
                              text.text, rd0!, rd1!, rd2!, rd3, rd4, rd5);
                          //key = checkC(_encrypted);
                        });
                        checkC(_encrypted);
                        Timer(Duration(seconds: seconds), () {
                          CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          );
                          showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(30))),
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => showModal(
                                  height, width, textscale, key, _encrypted));
                        });
                      }
                    },
                    child: Text("Encrypter")),
              ),
            )
          ],
        ),
      ),
    );
  }

//show modal au bottom

  showModal(double height, double width, double textscale, String key,
      String encrypted) {
    //print(_encrypted);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: height / 4,
          margin: EdgeInsets.only(top: 50, left: 40, right: 40),
          //affichage du QR code
          child: QrImage(
            data: encrypted,
            size: 200,
            backgroundColor: Colors.white,
          ),
        ),
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
              Text(
                encrypted,
                style: GoogleFonts.poppins(
                    fontSize: textscale * 17, fontWeight: FontWeight.w700),
              ),
              Text(
                "Cle",
                style: GoogleFonts.poppins(
                    color: Colors.red, fontWeight: FontWeight.w500),
              ),
              Text(
                key,
                style: GoogleFonts.poppins(
                    fontSize: textscale * 17, fontWeight: FontWeight.w700),
              ),
              GestureDetector(
                  onTap: () {
                    Clipboard.setData(
                        ClipboardData(text: "Message: $encrypted Cle:$key"));
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "Message crypte copie dans le presse papier")));
                  },
                  child: Icon(Icons.copy_all))
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
