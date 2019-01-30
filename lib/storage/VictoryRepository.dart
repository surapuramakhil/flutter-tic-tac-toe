import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class VictoryRepository {

  static const String VICTORIES_DOC_NAME = "victories";
  static const String FIELD_COUNT = "count";

  DocumentSnapshot documentCache;

  static VictoryRepository _victoryRepository;

  static VictoryRepository getInstance() {
    if (_victoryRepository == null) {
      _victoryRepository = VictoryRepository();
    }

    return _victoryRepository;
  }

  Stream getVictoryStream() {
    return Firestore.instance.collection(VICTORIES_DOC_NAME).snapshots();
  }

  /// Reactive getter for victory count
  int getVictoryCount(AsyncSnapshot<dynamic> snapshot) {
    if (snapshot.hasData) {
      documentCache = getDocument(snapshot.data);
      return documentCache.data[FIELD_COUNT];
    }

    return -1;
  }

  /// Async setter for adding the victory count
  void addVictory() async {
//    Firestore.instance.runTransaction((transaction) async {
//
//      getVictoryStream().listen((dynamic data) async {
//        var querySnapshot = data as QuerySnapshot;
//        var docSnapshot = getDocument(querySnapshot);
//
//        await transaction.update(docSnapshot.reference, {
//          FIELD_COUNT: docSnapshot[FIELD_COUNT] + 1
//        });
//      });
//    });

    Firestore.instance.runTransaction((transaction) async {
      DocumentReference reference = documentCache.reference;
      DocumentSnapshot docSnapshot = await transaction.get(reference);
      await transaction.update(docSnapshot.reference, {
        FIELD_COUNT: docSnapshot.data[FIELD_COUNT] + 1,
      });
    });
  }

  DocumentSnapshot getDocument(QuerySnapshot snapshot) {
    return snapshot.documents[0];
  }
}