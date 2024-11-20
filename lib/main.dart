// main.dart
import 'package:flutter/material.dart'; // FlutterのMaterialデザインライブラリをインポート
import 'memo_list_screen.dart'; // メモ一覧画面のファイルをインポート


void main() {
  //sqfliteFfiInit(); // sqflite_common_ffiの初期化
  //databaseFactory = databaseFactoryFfi; // databaseFactoryを初期化

  runApp(const MyApp()); // アプリケーションを起動する
}

class MyApp extends StatelessWidget { // MyAppクラスを定義、StatelessWidgetを継承
  const MyApp({super.key}); // コンストラクタ、super.keyで親クラスのコンストラクタを呼び出す

  @override
  Widget build(BuildContext context) { // buildメソッドをオーバーライド
    return MaterialApp( // MaterialAppウィジェットを返す
      title: 'Notepad App', // アプリのタイトルを設定
      theme: ThemeData( // アプリのテーマを設定
        primarySwatch: Colors.blue, // メインカラーを青に設定
        visualDensity: VisualDensity.adaptivePlatformDensity, // プラットフォームに応じたUI密度を適用
      ),
      home: MemoListScreen(), // 初期画面としてメモ一覧画面を設定
    );
  }
}
