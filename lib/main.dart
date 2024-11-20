// main.dart
import 'package:flutter/material.dart'; // FlutterのMaterialデザインライブラリをインポート
import 'memo_list_screen.dart'; // メモ一覧画面のファイルをインポート

void main() {
  runApp(MyApp()); // アプリケーションを起動する
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notepad App', // アプリのタイトルを設定
      theme: ThemeData(
        primarySwatch: Colors.blue, // メインカラーを青に設定
        visualDensity: VisualDensity.adaptivePlatformDensity, // プラットフォームに応じたUI密度を適用
      ),
      home: MemoListScreen(), // 初期画面としてメモ一覧画面を設定
    );
  }
}