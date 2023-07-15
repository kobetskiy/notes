import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/view.dart';
import 'view.dart';
import '../models/view.dart';
import '../widgets/view.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

final TextEditingController _searchController = TextEditingController();

class _MainPageState extends State<MainPage> {
  List<Note> foundList = [];
  NoteData noteData = NoteData();

  @override
  void initState() {
    log.i('Build success!');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    foundList = List.from(Provider.of<NoteData>(context).getAllNotes());
    super.didChangeDependencies();
  }

  void goToPage(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  void onSearchNoteChange(String text) {
    setState(() {
      List<Note> result = [];
      if (text.isEmpty) {
        result = List.from(
            Provider.of<NoteData>(context, listen: false).getAllNotes());
      } else {
        result = List.from(Provider.of<NoteData>(context, listen: false)
            .getAllNotes()
            .where((note) =>
                note.title.toLowerCase().contains(text.toLowerCase())));
      }
      foundList = result;
    });
  }

  String _notesCount() {
    if (foundList.isEmpty) {
      return 'No notes';
    } else if (foundList.length == 1) {
      return '1 note';
    }
    return '${foundList.length} notes';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(builder: (context, value, child) {
      return Scaffold(
        appBar: const AppBarWidget(title: Text('Notes')),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: Column(
            children: [
              // * top notes
              // Row(
              //   children: [
              //     Text('No top notes',
              //         style: Theme.of(context).textTheme.labelMedium)
              //   ],
              // ),
              const SizedBox(height: 20),

              // * search text flied
              TextFieldWidget(
                onChanged: (text) => onSearchNoteChange(text),
                controller: _searchController,
                hintText: 'Search...',
                icon: Icons.search_rounded,
              ),
              const SizedBox(height: 10),

              // * notes count
              Center(
                child: Text(
                  _notesCount(),
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              const SizedBox(height: 10),

              // * all notes
              Expanded(child: listViewMethod(value)),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButtonWidget(
          onPressed: () => {
            goToPage(
              NotePage(
                isNewNote: true,
                note: Note(
                  title: titleController.text,
                  content: contentController.text,
                  id: foundList.length,
                  dateTime: '',
                ),
              ),
            ),
          },
        ),
      );
    });
  }

  ListView listViewMethod(NoteData value) {
    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      physics: const BouncingScrollPhysics(),
      itemCount: foundList.length,
      itemBuilder: (context, index) => Card(
        margin: const EdgeInsets.all(0),
        child: ListTile(
          minLeadingWidth: 0,
          contentPadding: const EdgeInsets.only(left: 17.0),
          onTap: () {
            goToPage(
              NotePage(
                isNewNote: false,
                note: value.getAllNotes()[index],
              ),
            );
          },
          leading: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.list),
            ],
          ),
          title: Text(
            value.getAllNotes()[index].title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            foundList[index].dateTime,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () => value.deleteNote(foundList[index]),
            icon: const Icon(Icons.delete_rounded),
          ),
        ),
      ),
      separatorBuilder: (context, index) => const SizedBox(height: 13),
    );
  }
}

// List<PopupMenuEntry> appBarPopupList() {
//   return [
//     popupMenuItem(
//         context,
//         isListView.value ? 'Grid view' : 'List view',
//         isListView.value ? Icons.grid_view_sharp : Icons.list_rounded,
//         MenuValues.gridOrListView),
//     popupMenuItem(context, 'Settings', Icons.settings, MenuValues.settings),
//     popupMenuItem(context, 'Trash', Icons.delete, MenuValues.trash)
//   ];
// }

// List<PopupMenuEntry> notePopupList() {
//   return [
//     popupMenuItem(context, 'Put in top', Icons.arrow_circle_up_rounded,
//         MenuValues.putInTop),
//     popupMenuItem(context, 'Change category', Icons.change_circle_outlined,
//         MenuValues.changeCategory),
//     popupMenuItem(context, 'Rename', Icons.title_rounded, MenuValues.remane),
//     popupMenuItem(context, 'Favorite', Icons.favorite_border_outlined,
//         MenuValues.favorite),
//     popupMenuItem(
//         context,
//         'Delete',
//         Icons.delete_forever_rounded,
//         color: dangerRedColor,
//         MenuValues.delete),
//   ];
// }

// Offset tapPosition = Offset.zero;

// void getTapPosition(TapDownDetails details) {
//   final RenderBox referenceBox = context.findRenderObject() as RenderBox;
//   setState(() {
//     tapPosition = referenceBox.globalToLocal(details.globalPosition);
//   });
// }

// void showContextMenu(BuildContext context) async {
//   final RenderObject? overlay =
//       Overlay.of(context).context.findRenderObject();
//   final value = await showMenu(
//       context: context,
//       position: RelativeRect.fromRect(
//           Rect.fromLTWH(tapPosition.dx, tapPosition.dy, 30, 30),
//           Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width,
//               overlay.paintBounds.size.height)),
//       items: notePopupList());
//   if (value == MenuValues.putInTop) {
//     log.i('putInTop');
//   } else if (value == MenuValues.changeCategory) {
//     log.i('changeCategory');
//   } else if (value == MenuValues.remane) {
//     log.i('rename');
//   } else if (value == MenuValues.favorite) {
//     log.i('favorite');
//   } else if (value == MenuValues.delete) {
//     log.i('delete');
//   }
// }

// GridView gridViewMethod() {
//   return GridView.builder(
//     shrinkWrap: true,
//     physics: const BouncingScrollPhysics(),
//     itemCount: noteData.getAllNotes().length,
//     gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//       maxCrossAxisExtent: 220,
//       childAspectRatio: 1,
//       crossAxisSpacing: 20,
//       mainAxisSpacing: 20,
//     ),
//     itemBuilder: (context, index) => Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//       margin: const EdgeInsets.all(0),
//       color: Colors.grey[700],
//       child: InkWell(
//         onTapDown: (details) => getTapPosition(details),
//         onLongPress: () => showContextMenu(context),
//         onTap: () => goToPage(NotePage(note: noteData.getAllNotes()[index])),
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
//           child: GridTile(
//             header: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   noteData.getAllNotes()[index].name,
//                   style: Theme.of(context)
//                       .listTileTheme
//                       .titleTextStyle!
//                       .copyWith(fontWeight: FontWeight.w600),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 Text(
//                   noteData.getAllNotes()[index].dateTime,
//                   style: Theme.of(context).listTileTheme.subtitleTextStyle,
//                   maxLines: 3,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 53),
//                 SizedBox(
//                   height: 67,
//                   child: Text(
//                     '',
//                     style: Theme.of(context).listTileTheme.subtitleTextStyle,
//                     maxLines: 4,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }

// ! floating action button on press func
// showDialog(
//         context: context,
//         builder: (context) => BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
//           child: AlertDialogWidget(
//             child: Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       IconButton(
//                         padding: const EdgeInsets.only(right: 20),
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                         iconSize: 26,
//                         color: Theme.of(context).iconTheme.color,
//                         splashColor: Colors.transparent,
//                         highlightColor: Colors.transparent,
//                         icon: const Icon(Icons.arrow_back_rounded),
//                       ),
//                       Center(
//                         child: Text('Create a new note',
//                             style: Theme.of(context).textTheme.titleMedium),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   TextFieldWidget(
//                     controller: setNameToNoteController,
//                     hintText: 'Name',
//                     icon: Icons.notes_rounded,
//                   ),
//                   const SizedBox(height: 20),
//                   Container(
//                     width: 150,
//                     height: 45,
//                     decoration: const BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.bottomLeft,
//                         end: Alignment.topRight,
//                         colors: [Color(0xFF4B7BFF), Color(0xFF46D9FF)],
//                       ),
//                       borderRadius: BorderRadius.all(Radius.circular(12)),
//                     ),
// child: ValueListenableBuilder<TextEditingValue>(
//   valueListenable: setNameToNoteController,
//   builder: (context, value, child) {
//     return ElevatedButton(
//       onPressed: setNameToNoteController.text.isNotEmpty
//           ? () => createNewNote(
//               setNameToNoteController.text.trim())
//           : null,
//       style: ButtonStyle(
//         shape: MaterialStateProperty.all(
//           const RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(
//               Radius.circular(12),
//             ),
//           ),
//         ),
//       ),
//       child: Center(
//         child: Text(
//           'Create',
//           style: Theme.of(context)
//               .textTheme
//               .labelLarge!
//               .copyWith(fontSize: 20),
//         ),
//       ),
//     );
//   },
// ),
//             )
//           ],
//         ),
//       ),
//     ),
//   ),
// ),
