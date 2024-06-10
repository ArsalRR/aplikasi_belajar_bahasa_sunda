class Soal {
  String soalText;
  List<Pilihan> pilihanList;
  int jawabanBenar;

  Soal(
      {required this.soalText,
      required this.pilihanList,
      required this.jawabanBenar});

  Map<String, dynamic> toMap() {
    return {
      'soalText': soalText,
      'pilihanList': pilihanList.map((e) => e.toMap()).toList(),
      'jawabanBenar': jawabanBenar,
    };
  }
}

class Pilihan {
  String text;

  Pilihan({required this.text});

  Map<String, dynamic> toMap() {
    return {'text': text};
  }
}
