import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ff/model/nesne.dart';

class Services {
  static var db = FirebaseFirestore.instance;

  static Future<List<Nesne>> getObjects() async {
    List<Nesne> sonuc = [];
    var getdb = await db.collection('object').get();
    for (var element in getdb.docs) {
      sonuc.add(Nesne.fromDocument(element));
    }
    return sonuc;
  }
}

class HomeServices {
  static var db = FirebaseFirestore.instance;

  static Future<List<AnasayfaNesne>> getObjects2() async {
    List<AnasayfaNesne> sonuc2 = [];
    var getdb = await db.collection('homeobject').get();
    for (var element in getdb.docs) {
      sonuc2.add(AnasayfaNesne.fromDocument(element));
    }
    return sonuc2;
  }
}

class AnimalServices {
  static var db = FirebaseFirestore.instance;

  static Future<List<HayvanNesne>> getObjects3() async {
    List<HayvanNesne> sonuc3 = [];
    var getdb = await db.collection('animalobject').get();
    for (var element in getdb.docs) {
      sonuc3.add(HayvanNesne.fromDocument(element));
    }
    return sonuc3;
  }
}
