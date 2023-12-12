import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Database db;

  initDB() async {
    var path = await getDatabasesPath();
    String filePath = join(path, 'todo.db');

    db = await openDatabase(filePath, version: 1, onCreate: (_db, v) {
      // Create Tables
      _db.execute(
          'CREATE TABLE todo (id INTEGER PRIMARY KEY , title TEXT, body TEXT,dateTime TEXT,done INTEGER)');
    });
  }

  @override
  void initState() {
    initDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                var id = await db.insert('todo', {
                  "id": 2,
                  "title": "title 2",
                  "body": "body 2",
                  "dateTime": DateTime.now().toString(),
                  "done": 0,
                });

                print(id);
              },
              child: const Text("insert"),
            ),
            ElevatedButton(
              onPressed: () async {
                var list = await db.query('todo');

                list.forEach((element) {
                  print(element);
                });
              },
              child: const Text("Get all data"),
            ),
            ElevatedButton(
              onPressed: () async {
                var list = await db.query(
                  'todo',
                  where: 'title = ? AND body = ?',
                  whereArgs: ["title 1", "body 1"],
                );

                print(list.single);
              },
              child: const Text("get item"),
            ),
            ElevatedButton(
              onPressed: () {
                db.update('todo', {"title": "title"},
                    where: 'id = ?', whereArgs: [1]);
              },
              child: const Text("update"),
            ),
            ElevatedButton(
              onPressed: () {
                db.delete(
                  'todo',
                  where: 'id = ?',
                  whereArgs: [1],
                );
              },
              child: const Text("delete"),
            ),
          ],
        ),
      ),
    );
  }
}
