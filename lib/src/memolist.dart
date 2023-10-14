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
        backgroundColor: Color.fromARGB(255, 91, 91, 91),
        appBar: AppBar(
          title: const Text(
            'メモ一覧',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color.fromARGB(255, 28, 23, 23),
        ),
        
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddPage()),
            );
          },
          backgroundColor: Colors.black,
          child: const Icon(Icons.add_outlined, color: Colors.white),
        ),
      ),
    );
  }
}