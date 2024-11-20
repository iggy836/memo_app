import 'package:flutter/material.dart'; // FlutterのMaterialデザインライブラリをインポート

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('設定'), // アプリバーに「設定」と表示
      ),
      body: Center(
        child: Text('設定画面の内容'), // 設定画面の内容を表示するプレースホルダー
      ),
    );
  }
}
