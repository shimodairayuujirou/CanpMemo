import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class DetailPage extends StatelessWidget {
   const DetailPage({
    super.key,
    required this.detail,
    required this.title,
    required this.Id,
  });

  final String detail;
  final String title;
  final String Id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
      appBar: AppBar(
      backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 227, 191, 32),
        ),
        actions:  [
          InkWell(child: Icon(Icons.delete),
            onTap: (){
            showAlertDialog(context,Id);},
          ),
        ],
    ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 23),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(title,style: const TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  detail,
                  style: const TextStyle(fontSize: 20)
                ),
              )
            ],
          ),
        )
      )
    );
  }
}

void showAlertDialog(BuildContext context,Id) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text('削除の確認'),
        children: [
          SimpleDialogOption(
            child: Text('削除'),
            onPressed: () {
              FirebaseFirestore.instance.collection('users').doc('UID').collection('Memo').doc(Id).delete();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          ),
          SimpleDialogOption(
            child: Text('キャンセル'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}