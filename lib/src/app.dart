import 'package:flutter/material.dart';
import 'package:memoapp/src/memolist.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MemoApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.grey,
        ),
        useMaterial3: true,
        
      ),
      home: const MemoPage(),
    );
  }
}