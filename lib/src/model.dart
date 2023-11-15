import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memoapp/src/content.dart';

class Model extends ChangeNotifier {
  List<Content> content = [];

  Model() {
    // Firestoreのデータ変更を監視
    FirebaseFirestore.instance.collection('users').doc('UID').collection('Memo').snapshots().listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        // Firestoreのデータを処理
        final docs = snapshot.docs;
        final updatedContent = docs.map((doc) => Content(doc)).toList();

        // Modelにデータをセット
        content = updatedContent;

        // notifyListeners()でUIに変更を通知
        notifyListeners();
      }
    });
  }
}
