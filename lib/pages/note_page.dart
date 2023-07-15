import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/view.dart';
import '../widgets/view.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key, required this.note, required this.isNewNote});

  final Note note;
  final bool isNewNote;

  @override
  State<NotePage> createState() => _NotePageState();
}

final TextEditingController titleController = TextEditingController();
final TextEditingController contentController = TextEditingController();

String newDate() {
  DateTime now = DateTime.now();
  String monthDay = DateFormat.MMMd().format(now);
  String hourMinuteSecond = DateFormat.Hm().format(now);
  String dateTime = '$hourMinuteSecond $monthDay';
  return dateTime;
}

class _NotePageState extends State<NotePage> {
  late NoteData noteData = Provider.of<NoteData>(context, listen: false);

  @override
  void initState() {
    titleController.text = widget.note.title;
    contentController.text = widget.note.content;
    super.initState();
  }



  
  

  void goToPage(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  void createNewNote() {
    setState(() {
      if (titleController.text != '') {
        int id = noteData.getAllNotes().length;

        Note newNote = Note(
            title: titleController.text,
            content: contentController.text,
            id: id,
            dateTime: newDate());
        noteData.addNewNote(newNote);
        Navigator.pop(context);
        titleController.clear();
        contentController.clear();
      }
    });
  }

  void updateCurrentNote() {
    setState(() {
      if (titleController.text != widget.note.title ||
          contentController.text != widget.note.content) {
        // update data
        noteData.updateNote(widget.note, titleController.text, contentController.text, newDate());
        
        // put updated note in top of the list
        noteData.deleteNote(widget.note);
        noteData.addNewNote(widget.note);

        Navigator.maybePop(context);
        titleController.clear();
        contentController.clear();
      }
      Navigator.pop(context);
      titleController.clear();
      contentController.clear();
    });

  }

  void onPressed() {
    setState(() {
      if (contentController.text != '' && titleController.text == '') {
        showDialog(
          context: context,
          builder: (context) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child: AlertDialogWidget(
              height: 170,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Center(
                      child: Text('WARNING',
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        'You can\'t save a note without title.\nPlease, set name to the title',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.grey[300]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 150,
                      height: 45,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [Color(0xFF4B7BFF), Color(0xFF46D9FF)],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context, false),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'OK',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }

      titleController.text == '' && contentController.text == ''
          ? Navigator.pop(context)
          : widget.isNewNote
              ? createNewNote()
              : updateCurrentNote();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        leading: IconButton(
          key: const Key('buttonBackInNotePage'),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: onPressed,
        ),
        title: TextField(
          controller: titleController,
          style: Theme.of(context).textTheme.displaySmall,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Title',
            hintStyle: TextStyle(
              fontSize: Theme.of(context).textTheme.displaySmall?.fontSize,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  TextField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    controller: contentController,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type something',
                      hintStyle: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.bodyMedium?.fontSize),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
