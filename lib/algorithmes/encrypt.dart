encryptData(String text, int rd0, int rd1, int rd2, int rd3, int rd4, int rd5) {
  int test;
  var tList = text.split("");
  int lenght = tList.length;
  String result = "";
  List<String> words = [
    "BANANA",
    "WORD",
    "XXXTENTACION",
    "CHROME",
    "JBL",
    "COMPUTER",
    "ENCRYPTION",
    "DECRYPTION",
    "MUSIC",
    "SONG",
    "DAMSO",
    "NINHO",
    "FLUTTER",
    "DART",
    "GOOGLE",
    "GAMING",
    "ASUS",
    "SERGE",
    "GABA",
    "JONATHAN",
    "AYITE",
    "ACCRO",
    "EDGE",
    "CLAVIER"
  ];
  List<String> words1 = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z"
  ];
  List<String> words2 = [
    "§",
    ".",
    "%",
    "&",
    "+*",
    "####*",
    "#",
    "ä",
    "µ",
    "-!",
    "ß",
    "!&",
    "eee",
    ".",
    ":::",
    "!!!!",
    "|||"
  ];
  List<String> words3 = ["$rd0", "$rd1", "$rd3", "$rd4"];
  for (var i = 0; i < 3; i++) {
    if (i <= 17) {
      result +=
          tList[0] + words3[rd3] + words[rd0] + tList[0] + words2[rd2];
    } else {
      result += words2[rd2] + words1[rd1] + words1[rd1] + words2[rd2];
    }
  }
  return result;
}
