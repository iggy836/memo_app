import 'dart:async'; // 非同期処理をサポートするためのライブラリをインポート
import 'package:path/path.dart'; // ファイルパスを操作するためのライブラリをインポート
import 'package:sqflite/sqflite.dart'; // SQLiteデータベースを操作するためのライブラリをインポート


class DatabaseHelper { // データベース操作を行うためのヘルパークラスを定義
  static final DatabaseHelper _instance = DatabaseHelper._internal(); // シングルトンインスタンスを作成
  factory DatabaseHelper() => _instance; // シングルトンインスタンスを返すファクトリコンストラクタ

  static Database? _database; // データベースインスタンスを保持するための変数

  DatabaseHelper._internal(); // プライベートコンストラクタ

  Future<Database> get database async { // データベースインスタンスを取得する非同期メソッド
    if (_database != null) return _database!; // 既にデータベースが初期化されている場合はそれを返す
    _database = await _initDatabase(); // データベースを初期化
    return _database!; // 初期化されたデータベースを返す
  }

  Future<Database> _initDatabase() async { // データベースを初期化する非同期メソッド
    String path = join(await getDatabasesPath(), 'memo_database.db'); // データベースファイルのパスを取得
    return await openDatabase( // データベースを開く
      path, // データベースのパス
      version: 1, // データベースのバージョン
      onCreate: _onCreate, // データベースが作成される際に呼ばれるコールバック
    );
  }

  Future _onCreate(Database db, int version) async { // データベースが作成される際に呼ばれるメソッド
    await db.execute('''
        CREATE TABLE memos (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          content TEXT NOT NULL,
          created_at TEXT NOT NULL,
          updated_at TEXT NOT NULL
        )
      ''');
  }
  
  Future<int> insertMemo(Map<String, dynamic> row) async { // メモを挿入する非同期メソッド
    Database db = await database; // データベースインスタンスを取得
    return await db.insert('memos', row); // 'memos'テーブルに新しい行を挿入
  }

  Future<List<Map<String, dynamic>>> queryAllMemos() async { // 全てのメモを取得する非同期メソッド
    Database db = await database; // データベースインスタンスを取得
    return await db.query('memos'); // 'memos'テーブルの全ての行を取得
  }

  Future<void> updateMemo(Map<String, dynamic> memo) async {
    final db = await database;
    print('更新するメモ: $memo'); // 更新するデータをログに出力

    int id = memo['id'];
    print('更新するメモのID: $id'); // 更新するメモのIDをログに出力

    await db.update(
      'memos',
      memo,
      where: 'id = ?',
      whereArgs: [id],
    );

    // 更新後のデータを確認
    final updatedMemo = await db.query('memos', where: 'id = ?', whereArgs: [id]);
    print('更新後のメモ: $updatedMemo');
  }

  Future<int> deleteMemo(int id) async { // メモを削除する非同期メソッド
    Database db = await database; // データベースインスタンスを取得
    return await db.delete('memos', where: 'id = ?', whereArgs: [id]); // 指定したIDの行を削除
  }
}