import 'package:hive_flutter/hive_flutter.dart';

import '../models/note.dart';

class NoteDatabase {
  List<Note> noteDatabase = [];
  final _note_box = Hive.box('note_box');

  void ivitialNotesList() {}
}
