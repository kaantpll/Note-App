import 'package:flutter/cupertino.dart';
import 'package:hurry/core/database/database_provider.dart';
import 'package:sqflite/sqflite.dart';

class Note {
  int id;
  @required
  String title;
  @required
  String noteText;

  Note({
    this.id,
    this.title,
    this.noteText,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.COLUMN_TITLE: title,
      DatabaseProvider.COLUMN_NOTE: noteText,
    };
    if (id != null) {
      map[DatabaseProvider.COLUMN_ID] = id;
    }
    return map;
  }

  Note.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseProvider.COLUMN_ID];
    title = map[DatabaseProvider.COLUMN_TITLE];
    noteText = map[DatabaseProvider.COLUMN_NOTE];
  }
}

List<String> colors = ["#FEF579", "#5684E4", "#FF6865", "#8456AD", "#5BD281"];
