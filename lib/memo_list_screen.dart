// screens/memo_list_screen.dart
import 'package:flutter/material.dart'; // FlutterのMaterialデザインライブラリをインポート
import 'memo_create_edit_screen.dart'; // メモ作成・編集画面のファイルをインポート
import 'memo_detail_screen.dart'; // メモ詳細画面のファイルをインポート
import 'settings_screen.dart'; // 設定画面のファイルをインポート

class MemoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('メモ一覧'), // アプリバーに「メモ一覧」と表示
        actions: [
          IconButton(
            icon: Icon(Icons.settings), // 設定アイコンを表示
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()), // 設定画面に遷移
              );
            },
          ),
        ],
      ),
      body: ListView( // 仮のメモリストを表示
        children: [
          ListTile(
            title: Text('仮のメモタイトル 1'),
            subtitle: Text('仮のメモ内容 1'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>MemoDetailScreen(
                    memoTitle: '仮のメモタイトル 1',
                    memoContent: '仮のメモ内容 1',
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: Text('仮のメモタイトル 2'),
            subtitle: Text('仮のメモ内容 2'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MemoDetailScreen(
                    memoTitle: '仮のメモタイトル 2',
                    memoContent: '仮のメモ内容 2',
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MemoCreateEditScreen()), // メモ作成画面に遷移
          );
        },
        child: Icon(Icons.add), // メモ作成ボタンのアイコン
      ),
    );
  }
}