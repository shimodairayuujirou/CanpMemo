import 'package:cloud_firestore/cloud_firestore.dart';

// firestoreのドキュメントを扱うクラスBookを作る。
class Content {
  // ドキュメントを扱うDocumentSnapshotを引数にしたコンストラクタを作る
  Content(DocumentSnapshot doc) {
    //　ドキュメントの持っているフィールド'title'をこのBookのフィールドtitleに代入
    Id = doc.id;
    title = doc['title'];
    detail = doc['detail'];
  }
  // Bookで扱うフィールドを定義しておく。
  late String title;
  late String detail;
  late String Id;// ドキュメントIDを格納するフィールド
}