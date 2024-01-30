import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({
    super.key,
    required this.detail,
    required this.title,
    required this.Id,
  });

  final String detail;
  final String title;
  final String Id;

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final _formKey = GlobalKey<FormState>();
  String _titleValue = '';
  String _detailValue = '';

  @override
  void initState() {
    super.initState();
    // initState 内で初期化を行う
    _titleValue = widget.title;
    _detailValue = widget.detail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffECEAD8),
      appBar: AppBar(
        title: const Text(
          '編集',
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xff3D6E55),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 227, 191, 32),
        ),
        actions: [
          TextButton(
            child: const Text(
              '完了',
              style: TextStyle(
                color: Color.fromARGB(255, 227, 191, 32),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                // 変更がある場合は更新
                if (_titleValue != widget.title || _detailValue != widget.detail) {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc('UID')
                      .collection('Memo')
                      .doc(widget.Id)
                      .update({
                    'title': '$_titleValue',
                    'detail': '$_detailValue',
                  });
                }
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // タイトル記入欄
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 30, left: 30),
                child: TextFormField(
                  initialValue: _titleValue,
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
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Color(0xffECEAD8),),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Color(0xffECEAD8),
                      ),
                    ),
                    fillColor: Color.fromARGB(255, 253, 251, 244),
                    filled: true,
                  ),
                ),
              ),
              // 詳細記入欄
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 30, left: 30),
                child: TextFormField(
                  initialValue: _detailValue,
                  maxLines: 15,
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
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Color(0xffECEAD8),),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Color(0xffECEAD8),
                      ),
                    ),
                    fillColor: Color.fromARGB(255, 253, 251, 244),
                    filled: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
