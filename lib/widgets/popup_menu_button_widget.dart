import 'package:flutter/material.dart';
import '../config/colors.dart';
import '../components/logger.dart';

enum MenuValues {
  gridOrListView,
  settings,
  trash,
  putInTop,
  changeCategory,
  remane,
  favorite,
  delete
}

enum PopupTypes { appBar, listTile }

ValueNotifier isListView = ValueNotifier(true);

PopupMenuItem popupMenuItem(
    BuildContext context, String text, IconData icon, MenuValues value,
    {Color color = textAndIconColor}) {
  return PopupMenuItem(
    value: value,
    height: 42,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(color: color),
        ),
        Icon(icon, color: color)
      ],
    ),
  );
}

class PopupMenuButtonWidget extends StatefulWidget {
  const PopupMenuButtonWidget({
    super.key,
    required this.popupTypes,
    required this.appBarPopupList,
    required this.notePopupList,
  });

  final PopupTypes popupTypes;
  final List<PopupMenuEntry> appBarPopupList;
  final List<PopupMenuEntry> notePopupList;

  @override
  State<PopupMenuButtonWidget> createState() => _PopupMenuButtonWidgetState();
}

class _PopupMenuButtonWidgetState extends State<PopupMenuButtonWidget> {
  @override
  Widget build(BuildContext context) {
    
    void goToPage(String page) {
      Navigator.pushNamed(context, page);
    }

    return PopupMenuButton(
      iconSize: Theme.of(context).iconTheme.size,
      child: Container(
        alignment: Alignment.center,
        height: 45,
        width: 35,
        margin: const EdgeInsets.all(10),
        child: Icon(
          Icons.more_vert,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
      itemBuilder: (context) => widget.popupTypes == PopupTypes.appBar
          ? widget.appBarPopupList
          : widget.notePopupList,
      onSelected: (value) {
        if (value == MenuValues.gridOrListView) {
          setState(() {
            isListView.value = !isListView.value;
            log.i(isListView.value);
          });
        } else if (value == MenuValues.settings) {
          goToPage('/settings');
        } else if (value == MenuValues.trash) {
          goToPage('/trash');
        } else if (value == MenuValues.putInTop) {
          log.i('putInTop');
        } else if (value == MenuValues.changeCategory) {
          log.i('changeCategory');
        } else if (value == MenuValues.remane) {
          log.i('rename');
        } else if (value == MenuValues.favorite) {
          log.i('favorite');
        } else if (value == MenuValues.delete) {
          log.i('delete');
        }
      },
    );
  }
}


// class PopUpMenu {
//   VoidCallback onEnable;
//   VoidCallback onDisable;
//   VoidCallback onDelete;

//   PopUpMenu({this.onEnable, this.onDisable, this.onDelete});

//   void showMenuSelection(String value) {
//     switch (value) {
//       case 'Enable User':
//         onEnable();
//         break;
//       case 'Disable User':
//         onDisable();
//         break;
//       case 'Delete User':
//         onDelete();
//         break;
//     }
//   }
// }