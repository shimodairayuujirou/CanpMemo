import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:memoapp/src/model.dart';
import 'package:memoapp/src/add.dart';
import 'detail.dart';

class MemoPage extends StatelessWidget {
  const MemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Model>(
      create: (_) => Model()..fetchContent(),
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 230, 230, 230),
        appBar: AppBar(
          title: const Text(
            'メモ一覧',
            style: TextStyle(color: Color.fromARGB(255, 227, 191, 32), fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color.fromARGB(255, 230, 230, 230),
        ),
        
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddPage()),
            );
        },
        backgroundColor: Color.fromARGB(255, 230, 230, 230),
        child: const Icon(Icons.note_add,color: Color.fromARGB(255, 227, 191, 32),),
      ),
      ),
    );
  }
}
