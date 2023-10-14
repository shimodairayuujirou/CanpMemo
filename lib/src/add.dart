import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:memoapp/src/memolist.dart';

class AddPage extends StatefulWidget {
  const AddPage ({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AddPage'),
      ),
    );
  }
}