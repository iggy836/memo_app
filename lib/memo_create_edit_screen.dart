// screens/memo_create_edit_screen.dart
import 'package:flutter/material.dart'; // FlutterのMaterialデザインライブラリをインポート
import 'package:memo_app/database_helper.dart'; // データベースヘルパーのファイルをインポート

class MemoCreateEditScreen extends StatelessWidget {
  final String? memoTitle; // メモのタイトルを保持する変数
  final String? memoContent; // メモの内容を保持する変数
  final int? memoId; // メモのIDを保持する変数

  const MemoCreateEditScreen({super.key, this.memoTitle, this.memoContent, this.memoId}); // コンストラクタでタイトル、内容、IDを受け取る

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
              decoration: const InputDecoration(labelText: 'タイトル'), // 「タイトル」というラベルを設定
            ),
            TextField(
              controller: contentController, // 内容入力フィールドにコントローラを設定
              decoration: const InputDecoration(labelText: '内容'), // 「内容」というラベルを設定
              maxLines: null, // 複数行入力を許可
            ),
            const SizedBox(height: 20), // 20ピクセルの空白を追加
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // ボタンを均等に配置
              children: [
                ElevatedButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus(); // キーボードを閉じる
                    
                    try {
                      final db = DatabaseHelper(); // DatabaseHelperインスタンスを取得
                      final isUpdate = memoId != null && memoId != 0; // 更新かどうかを確認
                      if (memoId == null || memoId == 0) { // 新規メモの場合（IDがnullまたは0の場合）
                        print('新規です');
                        await db.insertMemo({ // メモをデータベースに挿入
                          'title': titleController.text, // タイトルフィールドの内容を取得
                          'content': contentController.text, // 内容フィールドの内容を取得
                          'created_at': DateTime.now().toIso8601String(), // 現在の日時を作成日時として保存
                          'updated_at': DateTime.now().toIso8601String(), // 現在の日時を更新日時として保存
                        });
                      } else { // 既存メモの編集の場合
                      print('更新です');
                       await db.updateMemo({ // メモを更新
                          'id': memoId!, // 編集するメモのIDを渡す（null安全演算子を追加）
                          'title': titleController.text, // タイトルフィールドの内容を取得
                          'content': contentController.text, // 内容フィールドの内容を取得
                          'updated_at': DateTime.now().toIso8601String(), // 現在の日時を更新日時として保存
                        });
                      }
                      if (context.mounted) Navigator.pop(context, true); // 保存後、前の画面に戻り、成功フラグを渡す
                        Navigator.of(context).popUntil((route) => route.isFirst); // 保存後、メモ一覧画面に戻る

                      // 保存後にDBにデータが保存されたか確認
                      final allMemos = await db.queryAllMemos();
                      print('データベースの全メモ:');
                      allMemos.forEach((memo) {
                        print("ID: ${memo['id']}, タイトル: ${memo['title']}, 内容: ${memo['content']}");
                      });
                    } catch (e) {
                      print('エラーが発生しました: $e'); // エラーハンドリングを追加
                    } // 保存後、前の画面に戻り、成功フラグを渡す
                  },
                  child: Text('保存'), // 保存ボタンのラベル
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, false); // キャンセルボタンで前の画面に戻り、キャンセルフラグを渡す
                  },
                  child: Text('キャンセル'), // キャンセルボタンのラベル
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}