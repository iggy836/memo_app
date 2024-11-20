// screens/memo_detail_screen.dart 
import 'package:flutter/material.dart'; // FlutterのMaterialデザインライブラリをインポート
import 'package:memo_app/database_helper.dart'; // データベースヘルパーのファイルをインポート
import 'memo_create_edit_screen.dart'; // メモ作成・編集画面のファイルをインポート

// メモの詳細画面を表示するためのクラス
class MemoDetailScreen extends StatelessWidget {
  final String memoTitle; // メモのタイトルを保持する変数
  final String memoContent; // メモの内容を保持する変数

  // コンストラクタでタイトルと内容を受け取る
  const MemoDetailScreen({super.key, required this.memoTitle, required this.memoContent});

  @override
  Widget build(BuildContext context) {
    // 画面の構造を定義するメソッド
    return Scaffold(
      appBar: AppBar(
        title: const Text('メモ詳細'), // アプリバーに「メモ詳細」と表示
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // 全体に16ピクセルの余白を設定
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 子要素を左揃えに設定
          children: [
            Text(
              memoTitle, // メモのタイトルを表示
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // タイトルのスタイルを設定
            ),
            const SizedBox(height: 10), // 10ピクセルの空白を追加
            Text(
              memoContent, // メモの内容を表示
              style: const TextStyle(fontSize: 16), // 内容のスタイルを設定
            ),
            const SizedBox(height: 20), // 20ピクセルの空白を追加
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // ボタンを均等に配置
              children: [
                ElevatedButton(
                  onPressed: () {
                    // 編集ボタンが押されたときの処理
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
                  child: const Text('編集'), // 編集ボタンのラベル
                ),
                ElevatedButton(
                  onPressed: () async {
                    // 削除ボタンが押されたときの処理
                    final db = DatabaseHelper(); // DatabaseHelperインスタンスを取得
                    await db.deleteMemo(int.parse(memoTitle)); // メモをデータベースから削除（IDを渡す必要あり）
                    Navigator.pop(context); // 削除後、前の画面に戻る
                  },
                  child: const Text('削除'), // 削除ボタンのラベル
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
