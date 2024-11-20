// screens/memo_list_screen.dart
import 'package:flutter/material.dart'; // FlutterのMaterialデザインライブラリをインポート
import 'memo_create_edit_screen.dart'; // メモ作成・編集画面のファイルをインポート
import 'settings_screen.dart'; // 設定画面のファイルをインポート
import 'database_helper.dart'; // データベースヘルパーのファイルをインポート

// メモ一覧画面を表すクラス
class MemoListScreen extends StatefulWidget {
  const MemoListScreen({super.key});

  @override
  _MemoListScreenState createState() => _MemoListScreenState(); // Stateを作成
}

// メモ一覧画面の状態を管理するクラス
class _MemoListScreenState extends State<MemoListScreen> {
  List<Map<String, dynamic>> memos = []; // メモのリストを保持する変数

  @override
  void initState() {
    super.initState(); // 親クラスのinitStateを呼び出す
    _refreshMemoList(); // 画面が初期化されたときにメモのリストを更新
  }

  // データベースからメモのリストを取得して更新するメソッド
  void _refreshMemoList() async {
    final data = await DatabaseHelper().queryAllMemos(); // データベースから全てのメモを取得
    setState(() {
      memos = data; // メモのリストを更新
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('メモ一覧'), // アプリバーに「メモ一覧」と表示
        actions: [
          IconButton(
            icon: const Icon(Icons.settings), // 設定アイコンを表示
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()), // 設定画面に遷移
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: memos.length, // メモの数を取得
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey), // 下部に境界線を追加
              ),
            ),
            child: ListTile(
              title: Text(memos[index]['title']), // メモのタイトルを表示
              subtitle: Text(memos[index]['content']), // メモの内容を表示
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MemoCreateEditScreen(
                      memoId: memos[index]['id'], // メモのIDを渡す
                      memoTitle: memos[index]['title'], // メモのタイトルを渡す
                      memoContent: memos[index]['content'], // メモの内容を渡す
                    ),
                  ),
                ).then((value) => _refreshMemoList()); // メモ詳細から戻った際にリストを更新
              },
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('削除'),
                      content: Text('このメモを削除しますか？'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('はい'),
                          onPressed: () async {
                            await DatabaseHelper().deleteMemo(memos[index]['id']); // メモを削除
                            Navigator.of(context).pop(); // ダイアログを閉じる
                            _refreshMemoList(); // メモリストを更新
                          },
                        ),
                      TextButton(
                          child: Text('いいえ'),
                          onPressed: () {
                            Navigator.of(context).pop(); // ダイアログを閉じる
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MemoCreateEditScreen()), // メモ作成画面に遷移
          ).then((value) => _refreshMemoList()); // メモ作成後にリストを更新
        },
        child: const Icon(Icons.add), // メモ作成ボタンのアイコン
      ),
    );
  }
}