import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:memoapp/src/content.dart';

class Model extends ChangeNotifier {
  List<Content> content = [];

  Future<void> fetchContent() async {
    final docs = await FirebaseFirestore.instance.collection('users').doc('UID').collection('Memo').get();
    final _titleValue = docs.docs
        .map((doc) => Content(doc)) 
        .toList();
    this.content = _titleValue; 
    notifyListeners(); 
  }
}