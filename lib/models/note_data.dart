import 'package:flutter/material.dart';
import 'note.dart';

class NoteData extends ChangeNotifier {
  final List<Note> _allNotes = [
    // Note(
    //     title: '01',
    //     content: 'content',
    //     id: 0,
    //     dateTime: DateTime.now().toString()),
    // Note(
    //     title: '11',
    //     content: 'content',
    //     id: 1,
    //     dateTime: DateTime.now().toString()),
    // Note(
    //     title: '111',
    //     content: 'content',
    //     id: 2,
    //     dateTime: DateTime.now().toString()),
    // Note(
    //     title: '21',
    //     content: 'content',
    //     id: 3,
    //     dateTime: DateTime.now().toString()),
    // Note(
    //     title: '222',
    //     content: 'content',
    //     id: 4,
    //     dateTime: DateTime.now().toString()),
    // Note(
    //     title: '33',
    //     content: 'content',
    //     id: 5,
    //     dateTime: DateTime.now().toString()),
    // Note(
    //     title: '333344',
    //     content: 'content',
    //     id: 6,
    //     dateTime: DateTime.now().toString()),
  ];

  List<Note> getAllNotes() {
    return _allNotes.reversed.toList();
  }

  // add note
  void addNewNote(Note note) {
    _allNotes.add(note);
    notifyListeners();
  }

  // update note
  void updateNote(Note note, String title, String content, String dateTime) {
    for (var i = 0; i < _allNotes.length; i++) {
      if (_allNotes[i].id == note.id) {
        _allNotes[i].title = title;
        _allNotes[i].content = content;
        _allNotes[i].dateTime = dateTime;
      }
    }
    notifyListeners();
  }

  // delete note
  void deleteNote(Note note) {
    _allNotes.remove(note);
    notifyListeners();
  }
}
