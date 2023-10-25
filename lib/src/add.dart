import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:memoapp/src/memolist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPage extends StatefulWidget {
  const AddPage ({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();
  String _titleValue = '';
  String _detailValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 227, 191, 32),
        ),
        actions: [
          TextButton(
            child: const Text('完了',
              style: TextStyle(
                color: Color.fromARGB(255, 227, 191, 32),
                fontWeight: FontWeight.bold,fontSize: 18,
              ),
            ),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await FirebaseFirestore.instance.collection('users').doc('UID').collection('Memo').add({
                  'title': '$_titleValue',
                  'detail': '$_detailValue',
                });
              Navigator.of(context).pop();
              };
            }
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //タイトル記入欄
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 30, left: 30),
                child: TextFormField(
                  style: TextStyle(fontSize: 30),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'タイトルを記入してください';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _titleValue = value;
                    });
                  },
                  decoration: InputDecoration(
                    // 未選択時の枠線
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    // 選択時の枠線
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    // 中を塗りつぶす色
                    fillColor: Colors.white,
                    // 中を塗りつぶすかどうか
                    filled: true,
                  ),
                ),
              ),
              //詳細記入欄
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 30, left: 30),
                child: TextFormField(
                  maxLines: 6,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '詳細を記入してください';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _detailValue = value;
                    });
                  },
                  decoration: InputDecoration(
                    // 未選択時の枠線
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    // 選択時の枠線
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    // 中を塗りつぶす色
                    fillColor: Colors.white,
                    // 中を塗りつぶすかどうか
                    filled: true,
                  ),
                ),
              ),
            ],
          )
        ),
      )
    );
  }
}