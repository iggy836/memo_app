import 'package:flutter/material.dart'; // FlutterのMaterialデザインライブラリをインポート
import 'memo_create_edit_screen.dart'; // メモ作成・編集画面のファイルをインポート

class MemoDetailScreen extends StatelessWidget {
  final String memoTitle; // メモのタイトルを保持する変数
  final String memoContent; // メモの内容を保持する変数

  MemoDetailScreen({required this.memoTitle, required this.memoContent}); // コンストラクタでタイトルと内容を受け取る

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('メモ詳細'), // アプリバーに「メモ詳細」と表示
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // 全体に16ピクセルの余白を設定
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 子要素を左揃えに設定
          children: [
            Text(
              memoTitle, // メモのタイトルを表示
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // タイトルのスタイルを設定
            ),
            SizedBox(height: 10), // 10ピクセルの空白を追加
            Text(
              memoContent, // メモの内容を表示
              style: TextStyle(fontSize: 16), // 内容のスタイルを設定
            ),
            SizedBox(height: 20), // 20ピクセルの空白を追加
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // ボタンを均等に配置
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MemoCreateEditScreen(
                          memoTitle: memoTitle, // 編集画面に現在のタイトルを渡す
                          memoContent: memoContent, // 編集画面に現在の内容を渡す
                        ),
                      ),
                    );
                  },
                  child: Text('編集'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // 削除ボタンで前の画面に戻る（削除処理は未実装）
                  },
                  child: Text('削除'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
