import 'dart:async';
import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite_common/sqflite.dart';

class MyFilmAppDatabase {
  FutureOr historyStore() async {
    final database =
        await openDatabase(join(await getDatabasesPath(), 'myfilmapp.db'));
    print(database);
    try {
      await database.execute(
          'CREATE TABLE IF NOT EXISTS History (id INTEGER PRIMARY KEY, film_id INTEGER, season_id INTEGER, episode_id INTEGER, person_id INTEGER,media_type TEXT)');
      // var id = await database.rawInsert(
      //     'INSERT INTO History(film_id, season_id, episode_id,person_id,media_type) VALUES(?,?,?,?,?)',
      //     ['some name', 456.789]);
      // print('inserted1: $id');
      // id = await database.rawInsert(
      //     'INSERT INTO Test(name, value) VALUES(?, ?)',
      //     ['another name', 12345678]);
      // print('inserted2: $id');
      // var count = await database.rawUpdate(
      //     'UPDATE Test SET name = ?, value = ? WHERE name = ?',
      //     ['updated name', '9876', 'some name']);
      // print('updated: $count');
      // expect(count, 1);

      // count = await database
      //     .rawDelete('DELETE FROM Test WHERE name = ?', ['another name']);
      // print('deleted: $count');
      var list = await database.rawQuery('SELECT * FROM History');

      print('list: ${json.encode(list)}');
    } finally {
      await database.close();
    }
  }
}
