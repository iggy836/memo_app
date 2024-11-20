import 'package:flutter/material.dart'; // FlutterのMaterialデザインライブラリをインポート

class MemoCreateEditScreen extends StatelessWidget {
  final String? memoTitle; // メモのタイトルを保持する変数
  final String? memoContent; // メモの内容を保持する変数

  MemoCreateEditScreen({this.memoTitle, this.memoContent}); // コンストラクタでタイトルと内容を受け取る

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController(text: memoTitle); // タイトル入力用のコントローラを作成
    TextEditingController contentController = TextEditingController(text: memoContent); // 内容入力用のコントローラを作成

    return Scaffold(
      appBar: AppBar(
        title: Text(memoTitle == null ? 'メモ作成' : 'メモ編集'), // 新規作成か編集かでタイトルを変更
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // 全体に16ピクセルの余白を設定
        child: Column(
          children: [
            TextField(
              controller: titleController, // タイトル入力フィールドにコントローラを設定
              decoration: InputDecoration(labelText: 'タイトル'), // 「タイトル」というラベルを設定
            ),
            TextField(
              controller: contentController, // 内容入力フィールドにコントローラを設定
              decoration: InputDecoration(labelText: '内容'), // 「内容」というラベルを設定
              maxLines: null, // 複数行入力を許可
            ),
            SizedBox(height: 20), // 20ピクセルの空白を追加
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // ボタンを均等に配置
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // キャンセルボタンで前の画面に戻る
                  },
                  child: Text('キャンセル'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // 保存ボタンで前の画面に戻る（保存処理は未実装）
                  },
                  child: Text('保存'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}