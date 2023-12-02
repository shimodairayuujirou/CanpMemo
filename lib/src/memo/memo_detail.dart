import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:memoapp/src/memo/memo_update.dart';
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
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(child: Icon(Icons.menu),
              onTap: (){
                showAlertDialog(context, Id, detail, title);
              },
            ),
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

void showAlertDialog(BuildContext context, String Id, String detail, String title) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('編集と削除'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdatePage(
                    detail: detail,
                    title: title,
                    Id: Id,
                  ),
                ),
              );
            },
            child: Text('編集',style: TextStyle(fontSize: 18,color: Color.fromARGB(255, 194, 152, 28)),),
          ),
          TextButton(
            onPressed: () {
              FirebaseFirestore.instance.collection('users').doc('UID').collection('Memo').doc(Id).delete();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text('削除',style: TextStyle(fontSize: 18,color: Colors.red),),
          ),
        ],
      );
    },
  );
}
