import 'package:memoapp/firebase_options.dart';
import 'package:memoapp/src/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async { // main 関数でも async が使えます
  WidgetsFlutterBinding.ensureInitialized(); // runApp 前に何かを実行したいときはこれが必要です。
  await Firebase.initializeApp( // これが Firebase の初期化処理です。
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}