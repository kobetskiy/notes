import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notes_test/models/view.dart';

import 'package:notes_test/pages/note_page.dart';

void main() {
  testWidgets('Checking for closing note without any datas (title or content)',
      (WidgetTester tester) async {
    final note = Note(
        title: '', content: '', id: 0, dateTime: DateTime.now().toString());
    final buttonBackInNotePage = find.byKey(const Key('buttonBackInNotePage'));

    await tester.pumpWidget(
      MaterialApp(
        home: NotePage(
          note: note,
          isNewNote: true,
        ),
      ),
    );
    await tester.tap(buttonBackInNotePage);
    expect(0, NoteData().getAllNotes().length);
  });

  testWidgets(
    "Checking for saving new note without content",
    (WidgetTester tester) async {
      final buttonBackInNotePage =
          find.byKey(const Key('buttonBackInNotePage'));
      final note = Note(
          title: 'title', content: '', id: 0, dateTime: DateTime.now().toString());

      await tester.pumpWidget(
        MaterialApp(
          home: NotePage(
            note: note,
            isNewNote: true,
          ),
        ),
      );
      await tester.tap(buttonBackInNotePage);
      expect(1, NoteData().getAllNotes().length);
    },
  );
}